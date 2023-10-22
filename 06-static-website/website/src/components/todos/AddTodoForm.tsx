import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { AxiosError } from "axios";
import { Check, Plus } from "lucide-react";

import { useTodoStore } from "@/store";
import { TAddTodoSchema, addTodoSchema } from "@/lib/types";
import useAxios from "@/hooks/useAxios";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { TodoTableDialog } from "./TodoTableDialog";

const AddTodoForm = () => {
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
    reset,
    setError,
  } = useForm<TAddTodoSchema>({
    resolver: zodResolver(addTodoSchema),
  });

  const addTodo = useTodoStore((store) => store.addTodo);
  const axios = useAxios();

  const onSubmit = async ({ task }: TAddTodoSchema) => {
    try {
      const response = await axios.post("/v1/todos", { Task: task });
      addTodo(response.data);
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
      trigger={
        <Button>
          <Plus />
        </Button>
      }
      title="Add new todo"
      content={
        <form onSubmit={handleSubmit(onSubmit)}>
          <div className="flex items-center py-2 gap-5">
            <Input
              type="text"
              placeholder="Write down your new task here"
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

export default AddTodoForm;
