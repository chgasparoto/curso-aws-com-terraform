import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import * as jwt from 'jsonwebtoken';

import { TodoService } from 'services';
import { TodoItem } from 'types';
import { successResponse, errorResponse } from 'utils';
import { ZodError } from 'zod';

const todoService = new TodoService(process.env.TABLE_NAME || '');

const verifyToken = (event: APIGatewayProxyEvent): jwt.JwtPayload | string => {
  const token = event.headers.Authorization?.split(' ')[1];
  const { payload } = jwt.decode(token, { complete: true });

  return payload;
};

const processRequest = async (
  userId: string,
  event: APIGatewayProxyEvent,
): Promise<TodoItem | TodoItem[]> => {
  const method = event.httpMethod;
  const payload: TodoItem = JSON.parse(event.body as string);
  const pathParams = event.pathParameters;

  let todo: TodoItem[] | TodoItem;

  switch (method) {
    case 'DELETE':
      todo = await todoService.delete(userId, pathParams?.todoId);
      break;
    case 'GET':
      const queryString = event.queryStringParameters;

      if (pathParams?.todoId) {
        todo = await todoService.findOne(userId, pathParams?.todoId);
        break;
      }

      todo = await todoService.findMany(userId, queryString?.isDone || '');
      break;
    case 'POST':
      todo = await todoService.create(userId, payload.Task);
      break;
    case 'PUT':
      todo = await todoService.update(userId, payload);
      break;
    default:
      throw new Error(`Unsupported method "${method}"`);
  }

  return todo;
};

export const handler = async (
  event: APIGatewayProxyEvent,
): Promise<APIGatewayProxyResult> => {
  if (process.env.DEBUG === 'true') {
    console.log({
      message: 'Event received',
      data: JSON.stringify(event),
    });
  }

  try {
    const payload = verifyToken(event);

    console.log({
      message: 'Decoded token',
      data: JSON.stringify(payload),
    });

    const userId = payload!.sub;
    const todo = await processRequest(userId as string, event);

    console.log({
      message: 'Database response',
      data: JSON.stringify(todo),
    });

    return successResponse(todo, event.httpMethod === 'POST' ? 201 : 200);
  } catch (err) {
    if (err instanceof jwt.JsonWebTokenError) {
      console.error({
        message: 'Error while verifying token',
        data: err,
      });

      return errorResponse({ message: 'Unauthorized' }, 401);
    }

    if (err instanceof ZodError) {
      console.error({
        message: 'Validation error',
        data: err,
      });

      const message = JSON.parse(err.message);
      return errorResponse(
        { message: message.map((error: ZodError) => error.message).join('\n') },
        400,
      );
    }

    console.error({
      message: 'Error while processing event',
      data: err,
    });

    return errorResponse();
  }
};
