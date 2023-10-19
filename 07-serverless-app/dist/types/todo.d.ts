import { z } from 'zod';
export declare const TodoItemDto: z.ZodObject<{
    TodoId: z.ZodString;
    UserId: z.ZodString;
    Task: z.ZodString;
    Done: z.ZodOptional<z.ZodString>;
    CreatedAt: z.ZodOptional<z.ZodString>;
    UpdatedAt: z.ZodOptional<z.ZodString>;
}, "strip", z.ZodTypeAny, {
    TodoId?: string;
    UserId?: string;
    Task?: string;
    Done?: string;
    CreatedAt?: string;
    UpdatedAt?: string;
}, {
    TodoId?: string;
    UserId?: string;
    Task?: string;
    Done?: string;
    CreatedAt?: string;
    UpdatedAt?: string;
}>;
export type TodoItem = z.infer<typeof TodoItemDto>;
