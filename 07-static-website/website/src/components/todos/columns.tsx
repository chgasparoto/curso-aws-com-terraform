import { ColumnDef } from "@tanstack/react-table";
import { ArrowUpDown, Trash } from "lucide-react";

import { Todo } from "@/lib/types";

import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { Label } from "@/components/ui/label";
import EditTodoForm from "./EditTodoForm";

export const columns: ColumnDef<Todo>[] = [
  {
    accessorKey: "Task",
    header: ({ column }) => {
      return (
        <Button
          variant="ghost"
          onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
        >
          Task
          <ArrowUpDown className="ml-2 h-4 w-4" />
        </Button>
      );
    },
    cell: ({ row }) => {
      return (
        <Popover>
          <PopoverTrigger asChild>
            <div className="cursor-pointer">{row.original.Task}</div>
          </PopoverTrigger>
          <PopoverContent className="w-200">
            <div className="grid gap-4">
              <div className="space-y-2">
                <h4 className="font-medium leading-none">
                  {row.original.Task}
                </h4>
                <p className="text-sm text-muted-foreground">
                  Data as is stored in the dabase
                </p>
              </div>
              <div className="grid gap-2">
                <div className="grid grid-cols-3 items-center gap-4">
                  <Label htmlFor="width">TodoId</Label>
                  <span className="col-span-2 h-8">{row.original.TodoId}</span>
                </div>
                <div className="grid grid-cols-3 items-center gap-4">
                  <Label htmlFor="width">UserId</Label>
                  <span className="col-span-2 h-8">{row.original.UserId}</span>
                </div>
                <div className="grid grid-cols-3 items-center gap-4">
                  <Label htmlFor="width">Done</Label>
                  <span className="col-span-2 h-8">{row.original.Done}</span>
                </div>
                <div className="grid grid-cols-3 items-center gap-4">
                  <Label htmlFor="width">CreatedAt</Label>
                  <span className="col-span-2 h-8">
                    {row.original.CreatedAt}
                  </span>
                </div>
                <div className="grid grid-cols-3 items-center gap-4">
                  <Label htmlFor="width">UpdatedAt</Label>
                  <span className="col-span-2 h-8">
                    {row.original.UpdatedAt}
                  </span>
                </div>
              </div>
            </div>
          </PopoverContent>
        </Popover>
      );
    },
  },
  {
    accessorKey: "Done",
    header: ({ column }) => {
      return (
        <Button
          variant="ghost"
          onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
        >
          Completed
          <ArrowUpDown className="ml-2 h-4 w-4" />
        </Button>
      );
    },
    cell: ({ row, table }) => {
      return (
        <div className="text-center font-medium">
          <Badge
            variant={row.original.Done === "1" ? "default" : "destructive"}
            className="cursor-pointer"
            onClick={() => {
              table.options.meta?.toggleTodo(row.original.TodoId);
            }}
          >
            {row.original.Done === "1" ? "Yes" : "No"}
          </Badge>
        </div>
      );
    },
  },
  {
    id: "actions",
    header: () => "Actions",
    cell: ({ table, row }) => {
      return (
        <div className="flex items-center justify-center gap-2">
          <EditTodoForm todoId={row.original.TodoId} />
          <Trash
            size="15"
            className="cursor-pointer text-slate-400 hover:text-slate-100"
            onClick={() => table.options.meta?.deleteTodo(row.original.TodoId)}
          />
        </div>
      );
    },
  },
];
