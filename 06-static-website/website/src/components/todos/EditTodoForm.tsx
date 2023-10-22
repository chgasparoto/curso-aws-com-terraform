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
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";

const EditTodoForm = ({ todoId }: { todoId: string }) => {
  const [open, setOpen] = useState(false);
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
      setOpen(false);
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
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Edit
          size="15"
          className="cursor-pointer text-slate-400 hover:text-slate-100"
          onClick={() => setOpen(true)}
        />
      </DialogTrigger>
      <DialogContent className="sm:max-w-[700px]">
        <DialogHeader>
          <DialogTitle>Edit todo task</DialogTitle>
          <DialogDescription>
            You can press "enter" key to save your edited task
          </DialogDescription>
        </DialogHeader>
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
      </DialogContent>
    </Dialog>
  );
};

export default EditTodoForm;
