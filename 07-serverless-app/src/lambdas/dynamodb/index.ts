import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import * as jwt from 'jsonwebtoken';

import { TodoService } from 'services';
import { TodoItem } from 'types';
import { successResponse, errorResponse } from 'utils';

const todoService = new TodoService(process.env.TABLE_NAME || '');

const verifyToken = (event: APIGatewayProxyEvent): jwt.JwtPayload | string => {
  const token = event.headers.Authorization?.split(' ')[1];
  const { payload } = jwt.decode(token, { complete: true });

  return payload;
};

const processRequest = async (userId: string, event: APIGatewayProxyEvent) => {
  const method = event.httpMethod;
  const data: TodoItem = JSON.parse(event.body as string);

  let todo: TodoItem[] | TodoItem;

  switch (method) {
    case 'DELETE':
      todo = await todoService.delete(userId, data.TodoId);
      break;
    case 'GET':
      const queryString = event.queryStringParameters;

      if (queryString?.id) {
        todo = await todoService.findOne(userId, queryString.id);
        break;
      }

      todo = await todoService.findMany(userId, queryString?.isDone || '');
      break;
    case 'POST':
      todo = await todoService.create(userId, data.Task);
      break;
    case 'PUT':
      todo = await todoService.update(userId, data);
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
  } catch (error) {
    if (error instanceof jwt.JsonWebTokenError) {
      console.error({
        message: 'Error while verifying token',
        data: error,
      });

      return errorResponse({ message: 'Unauthorized' }, 401);
    }

    console.error({
      message: 'Error while processing event',
      data: error,
    });

    return errorResponse();
  }
};
