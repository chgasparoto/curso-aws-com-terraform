import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import {
  DynamoDBDocumentClient,
  GetCommand,
  QueryCommand,
  PutCommand,
  DeleteCommand,
  UpdateCommand,
} from '@aws-sdk/lib-dynamodb';
import { v4 as uuidv4 } from 'uuid';

import { TodoItem, TodoItemSchema } from '../types';

export class TodoService {
  private readonly client: DynamoDBClient;
  private readonly docClient: DynamoDBDocumentClient;

  constructor(
    private tableName: string,
    private indexName: string = 'TodosByUser',
  ) {
    this.client = new DynamoDBClient({});
    this.docClient = DynamoDBDocumentClient.from(this.client);
  }

  async findOne(userId: string, todoId: string): Promise<TodoItem> {
    const todo = await this.docClient.send(
      new GetCommand({
        TableName: this.tableName,
        Key: {
          TodoId: todoId,
          UserId: userId,
        },
      }),
    );

    return todo.Item as TodoItem;
  }

  async findMany(userId: string, isDone?: string): Promise<TodoItem[]> {
    const conditionExpression = ['UserId = :userId'];
    const expAttrValues = { ':userId': userId };

    if (isDone === '0' || isDone === '1') {
      conditionExpression.push('Done = :done');
      expAttrValues[':done'] = isDone;
    }

    const todo = await this.docClient.send(
      new QueryCommand({
        TableName: this.tableName,
        IndexName: this.indexName,
        KeyConditionExpression: conditionExpression.join(' AND '),
        ExpressionAttributeValues: expAttrValues,
      }),
    );

    return todo.Items as TodoItem[];
  }

  async create(userId: string, task: string): Promise<TodoItem> {
    const todoId = uuidv4();
    const now = new Date().toISOString();
    const item: TodoItem = {
      TodoId: todoId,
      UserId: userId,
      Task: task,
      Done: '0',
      CreatedAt: now,
      UpdatedAt: now,
    };

    TodoItemSchema.parse(item);

    await this.docClient.send(
      new PutCommand({
        TableName: this.tableName,
        Item: item,
      }),
    );

    return item;
  }

  async update(userId: string, record: TodoItem): Promise<TodoItem> {
    const updateExpression = ['#done = :d', '#updatedAt = :u'];
    const expAttrNames = { '#done': 'Done', '#updatedAt': 'UpdatedAt' };
    const expAttrValues = { ':d': record.Done, ':u': new Date().toISOString() };

    if (record.Task) {
      updateExpression.unshift('#task = :t');
      expAttrNames['#task'] = 'Task';
      expAttrValues[':t'] = record.Task;
    }

    const todo = await this.docClient.send(
      new UpdateCommand({
        TableName: this.tableName,
        Key: {
          TodoId: record.TodoId,
          UserId: userId,
        },
        UpdateExpression: `set ${updateExpression.join(', ')}`,
        ExpressionAttributeNames: expAttrNames,
        ExpressionAttributeValues: expAttrValues,
        ReturnValues: 'ALL_NEW',
      }),
    );

    return todo.Attributes as TodoItem;
  }

  async delete(userId: string, todoId: string): Promise<TodoItem> {
    const todo = await this.docClient.send(
      new DeleteCommand({
        TableName: this.tableName,
        Key: {
          TodoId: todoId,
          UserId: userId,
        },
        ReturnValues: 'ALL_OLD',
      }),
    );

    return todo.Attributes as TodoItem;
  }
}
