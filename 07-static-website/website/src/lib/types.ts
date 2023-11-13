import { z } from "zod";

export const signInSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8, "Password must be at least 8 characters"),
});

export const signUpSchema = z
  .object({
    email: z.string().email(),
    password: z.string().min(8, "Password must be at least 8 characters"),
    confirmPassword: z
      .string()
      .min(8, "Password must be at least 8 characters"),
  })
  .refine((data) => data.password === data.confirmPassword, {
    message: "Passwords must match",
    path: ["confirmPassword"],
  });

export const signUpConfirmSchema = z.object({
  code: z.string().min(6, "Code must be at least 6 characters").max(6),
});

export const addTodoSchema = z.object({
  task: z.string().min(3, "Code must be at least 3 characters"),
});

export const todoSchema = z.object({
  TodoId: z.string(),
  UserId: z.string(),
  Task: z.string(),
  Done: z.string(),
  CreatedAt: z.string(),
  UpdatedAt: z.string(),
});

export type Todo = z.infer<typeof todoSchema>;
export type Todos = Todo[];
export type SignInSchema = z.infer<typeof signInSchema>;
export type SignUpSchema = z.infer<typeof signUpSchema>;
export type SignUpConfirmSchema = z.infer<typeof signUpConfirmSchema>;
export type TAddTodoSchema = z.infer<typeof addTodoSchema>;

export type Auth = {
  isAuthenticated: boolean;
  id: string;
  email: string;
  idToken: string;
  accessToken: string;
  refreshToken: string;
};
