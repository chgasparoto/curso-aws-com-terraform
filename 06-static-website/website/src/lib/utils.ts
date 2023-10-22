import { type ClassValue, clsx } from "clsx";
import { twMerge } from "tailwind-merge";
import { Todo } from "./types";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

export function TodoToStoreRecord(todos: Todo[]): Record<string, Todo> {
  return todos.reduce(
    (acc, todo) => {
      acc[todo.TodoId] = todo;
      return acc;
    },
    {} as Record<string, Todo>
  );
}

export function StoreRecordToTodos(storeRecord: Record<string, Todo>): Todo[] {
  return Object.values(storeRecord).map((todo) => ({
    TodoId: todo.TodoId,
    UserId: todo.UserId,
    Task: todo.Task,
    Done: todo.Done,
    CreatedAt: todo.CreatedAt,
    UpdatedAt: todo.UpdatedAt,
  }));
}
