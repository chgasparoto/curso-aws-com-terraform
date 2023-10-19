import { TodoItem } from '../types';
export declare class TodoService {
    private tableName;
    private indexName;
    private readonly client;
    private readonly docClient;
    constructor(tableName: string, indexName?: string);
    findOne(userId: string, todoId: string): Promise<TodoItem>;
    findMany(userId: string, isDone?: string): Promise<TodoItem[]>;
    create(userId: string, task: string): Promise<TodoItem>;
    update(userId: string, record: TodoItem): Promise<TodoItem>;
    delete(userId: string, todoId: string): Promise<TodoItem>;
}
