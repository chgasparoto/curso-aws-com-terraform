"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TodoService = void 0;
const client_dynamodb_1 = require("@aws-sdk/client-dynamodb");
const lib_dynamodb_1 = require("@aws-sdk/lib-dynamodb");
const uuid_1 = require("uuid");
class TodoService {
    tableName;
    indexName;
    client;
    docClient;
    constructor(tableName, indexName = 'TodosByUser') {
        this.tableName = tableName;
        this.indexName = indexName;
        this.client = new client_dynamodb_1.DynamoDBClient({});
        this.docClient = lib_dynamodb_1.DynamoDBDocumentClient.from(this.client);
    }
    async findOne(userId, todoId) {
        const todo = await this.docClient.send(new lib_dynamodb_1.GetCommand({
            TableName: this.tableName,
            Key: {
                TodoId: todoId,
                UserId: userId,
            },
        }));
        return todo.Item;
    }
    async findMany(userId, isDone) {
        const conditionExpression = ['UserId = :userId'];
        const expAttrValues = { ':userId': userId };
        if (isDone === '0' || isDone === '1') {
            conditionExpression.push('Done = :done');
            expAttrValues[':done'] = isDone;
        }
        const todo = await this.docClient.send(new lib_dynamodb_1.QueryCommand({
            TableName: this.tableName,
            IndexName: this.indexName,
            KeyConditionExpression: conditionExpression.join(' AND '),
            ExpressionAttributeValues: expAttrValues,
        }));
        return todo.Items;
    }
    async create(userId, task) {
        const todoId = (0, uuid_1.v4)();
        const now = new Date().toISOString();
        const item = {
            TodoId: todoId,
            UserId: userId,
            Task: task,
            Done: '0',
            CreatedAt: now,
            UpdatedAt: now,
        };
        await this.docClient.send(new lib_dynamodb_1.PutCommand({
            TableName: this.tableName,
            Item: item,
        }));
        return item;
    }
    async update(userId, record) {
        const updateExpression = ['#done = :d', '#updatedAt = :u'];
        const expAttrNames = { '#done': 'Done', '#updatedAt': 'UpdatedAt' };
        const expAttrValues = { ':d': record.Done, ':u': new Date().toISOString() };
        if (record.Task) {
            updateExpression.unshift('#task = :t');
            expAttrNames['#task'] = 'Task';
            expAttrValues[':t'] = record.Task;
        }
        const todo = await this.docClient.send(new lib_dynamodb_1.UpdateCommand({
            TableName: this.tableName,
            Key: {
                TodoId: record.TodoId,
                UserId: userId,
            },
            UpdateExpression: `set ${updateExpression.join(', ')}`,
            ExpressionAttributeNames: expAttrNames,
            ExpressionAttributeValues: expAttrValues,
            ReturnValues: 'ALL_NEW',
        }));
        return todo.Attributes;
    }
    async delete(userId, todoId) {
        const todo = await this.docClient.send(new lib_dynamodb_1.DeleteCommand({
            TableName: this.tableName,
            Key: {
                TodoId: todoId,
                UserId: userId,
            },
            ReturnValues: 'ALL_OLD',
        }));
        return todo.Attributes;
    }
}
exports.TodoService = TodoService;
//# sourceMappingURL=todo.js.map