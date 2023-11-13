import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { AxiosError } from "axios";
import { Check, Plus } from "lucide-react";

import { useTodoStore } from "@/store";
import { TAddTodoSchema, addTodoSchema } from "@/lib/types";
import useAxios from "@/hooks/useAxios";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";

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
    <Dialog>
      <DialogTrigger asChild>
        <Button>
          <Plus />
        </Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-[700px]">
        <DialogHeader>
          <DialogTitle>Add new todo</DialogTitle>
          <DialogDescription>
            You can press "enter" key to add new todos
          </DialogDescription>
        </DialogHeader>
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
      </DialogContent>
    </Dialog>
  );
};

export default AddTodoForm;
