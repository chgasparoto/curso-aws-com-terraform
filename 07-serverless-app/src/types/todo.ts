import { z } from 'zod';

export const TodoItemSchema = z.object({
  TodoId: z.string().uuid(),
  UserId: z.string().uuid(),
  Task: z.string().min(5),
  Done: z.enum(['1', '0']).default('0').optional(),
  CreatedAt: z.string().optional(),
  UpdatedAt: z.string().optional(),
});

export type TodoItem = z.infer<typeof TodoItemSchema>;
