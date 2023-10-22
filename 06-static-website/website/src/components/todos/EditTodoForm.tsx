import { useState } from "react";
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { AxiosError } from "axios";
import { Check, Edit } from "lucide-react";

import { useTodoStore } from "@/store";
import { TAddTodoSchema, addTodoSchema } from "@/lib/types";
import useAxios from "@/hooks/useAxios";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { TodoTableDialog } from "./TodoTableDialog";

const EditTodoForm = ({ todoId }: { todoId: string }) => {
  const [isOpen, setIsOpen] = useState(false);
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
    reset,
    setError,
  } = useForm<TAddTodoSchema>({
    resolver: zodResolver(addTodoSchema),
  });

  const todos = useTodoStore((store) => store.todos);
  const updateTodoTask = useTodoStore((store) => store.updateTodoTask);
  const axios = useAxios();

  const onSubmit = async ({ task }: TAddTodoSchema) => {
    try {
      updateTodoTask(todoId, task);
      await axios.put("/v1/todos", {
        TodoId: todoId,
        Task: task,
        Done: todos[todoId].Done,
      });
      setIsOpen(false);
      reset();
    } catch (err) {
      console.log({ err });
      const error = err as AxiosError;

      setError("root.serverError", {
        type: error?.response?.status + "" || "400",
        message:
          (error?.response?.data as { message: string }).message ||
          error.message,
      });
    }
  };

  return (
    <TodoTableDialog
      isOpen={isOpen}
      trigger={
        <Edit
          size="15"
          className="cursor-pointer text-slate-400 hover:text-slate-100"
          onClick={() => setIsOpen(true)}
        />
      }
      title="Edit todo task"
      content={
        <form onSubmit={handleSubmit(onSubmit)}>
          <div className="flex items-center py-2 gap-5">
            <Input
              type="text"
              placeholder="Write down your new task here"
              defaultValue={todos[todoId].Task}
              className=""
              {...register("task")}
            />
            <Button type="submit" disabled={isSubmitting} className="">
              <Check />
            </Button>
          </div>
          {errors.task && (
            <p className="text-red-500">{`${errors.task.message}`}</p>
          )}
          {errors.root?.serverError && (
            <p className="text-red-500">{`${errors.root?.serverError.message}`}</p>
          )}
        </form>
      }
    />
  );
};

export default EditTodoForm;
