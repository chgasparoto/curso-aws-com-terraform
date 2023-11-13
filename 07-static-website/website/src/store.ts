import { create } from "zustand";
import { immer } from "zustand/middleware/immer";

import { Auth, Todo } from "@/lib/types";
import { TodoToStoreRecord } from "@/lib/utils";

type State = {
  auth: Auth;
};

type Actions = {
  setAuth: (auth: Auth) => void;
  setEmail: (email: string) => void;
  logout: () => void;
};

const auth = {
  id: "",
  email: "",
  idToken: "",
  accessToken: "",
  refreshToken: "",
  isAuthenticated: false,
};

export const useAuthStore = create(
  immer<State & Actions>((set) => ({
    auth: auth,
    setAuth: (creds: Auth) =>
      set((state) => {
        state.auth = creds;
      }),
    setEmail: (email: string) =>
      set((state) => {
        state.auth.email = email;
      }),
    logout: () =>
      set((state) => {
        state.auth = auth;
      }),
  }))
);

type TodoState = {
  todos: Record<string, Todo>;
};

type TodoActions = {
  addTodo: (todo: Todo) => void;
  toggleTodo: (todoId: string) => void;
  updateTodoTask: (todoId: string, task: string) => void;
  deleteTodo: (todoId: string) => void;
  setTodos: (todos: Todo[]) => void;
};

export const useTodoStore = create(
  immer<TodoState & TodoActions>((set) => ({
    todos: {},
    addTodo: (todo: Todo) =>
      set((state) => {
        state.todos[todo.TodoId] = todo;
      }),
    toggleTodo: (todoId: string) =>
      set((state) => {
        state.todos[todoId].Done = state.todos[todoId].Done === "1" ? "0" : "1";
      }),
    updateTodoTask: (todoId: string, task: string) =>
      set((state) => {
        state.todos[todoId].Task = task;
      }),
    deleteTodo: (todoId: string) =>
      set((state) => {
        delete state.todos[todoId];
      }),
    setTodos: (todos: Todo[]) =>
      set((state) => {
        state.todos = TodoToStoreRecord(todos);
      }),
  }))
);
