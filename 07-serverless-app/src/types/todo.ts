import { z } from 'zod';

export const TodoItemDto = z.object({
  TodoId: z.string().uuid(),
  UserId: z.string().uuid(),
  Task: z.string().min(5),
  Done: z.string().optional(),
  CreatedAt: z.string().optional(),
  UpdatedAt: z.string().optional(),
});

export type TodoItem = z.infer<typeof TodoItemDto>;
