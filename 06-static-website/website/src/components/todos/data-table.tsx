import { useState } from "react";
import {
  ColumnDef,
  ColumnFiltersState,
  RowData,
  SortingState,
  flexRender,
  getCoreRowModel,
  getFilteredRowModel,
  getPaginationRowModel,
  getSortedRowModel,
  useReactTable,
} from "@tanstack/react-table";

import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import AddTodoForm from "./AddTodoForm";
import { useTodoStore } from "@/store";
import useAxios from "@/hooks/useAxios";

interface DataTableProps<TData, TValue> {
  columns: ColumnDef<TData, TValue>[];
  data: TData[];
}

declare module "@tanstack/react-table" {
  interface TableMeta<TData extends RowData> {
    updateTask: (todoId: string, value: string) => void;
    deleteTodo: (todoId: string) => void;
    toggleTodo: (todoId: string) => void;
  }
}

export function DataTable<TData, TValue>({
  columns,
  data,
}: DataTableProps<TData, TValue>) {
  const [sorting, setSorting] = useState<SortingState>([]);
  const [columnFilters, setColumnFilters] = useState<ColumnFiltersState>([]);

  const axios = useAxios();
  const todos = useTodoStore((store) => store.todos);
  const updateTodoTask = useTodoStore((store) => store.updateTodoTask);
  const removeTodo = useTodoStore((store) => store.deleteTodo);
  const toggleTodoStatus = useTodoStore((store) => store.toggleTodo);

  const table = useReactTable({
    data,
    columns,
    getCoreRowModel: getCoreRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
    onSortingChange: setSorting,
    getSortedRowModel: getSortedRowModel(),
    onColumnFiltersChange: setColumnFilters,
    getFilteredRowModel: getFilteredRowModel(),
    state: {
      sorting,
      columnFilters,
    },
    meta: {
      updateTask: async (todoId, value) => {
        try {
          await axios.put("/v1/todos", {
            TodoId: todoId,
            Task: value,
          });
          updateTodoTask(todoId, value);
        } catch (err) {
          console.log({ err });
        }
      },
      deleteTodo: async (todoId) => {
        try {
          await axios.delete(`/v1/todos/${todoId}`);
          removeTodo(todoId);
        } catch (err) {
          console.log({ err });
        }
      },
      toggleTodo: async (todoId) => {
        toggleTodoStatus(todoId);
        try {
          await axios.put("/v1/todos", {
            TodoId: todoId,
            Done: todos[todoId].Done === "1" ? "0" : "1",
          });
        } catch (err) {
          console.log({ err });
          toggleTodoStatus(todoId);
        }
      },
    },
  });

  return (
    <div>
      <div className="flex items-center py-2 gap-3">
        <Input
          placeholder="Filter todos..."
          value={(table.getColumn("Task")?.getFilterValue() as string) ?? ""}
          onChange={(event) =>
            table.getColumn("Task")?.setFilterValue(event.target.value)
          }
          className="w-full"
        />
        <AddTodoForm />
      </div>

      <div className="rounded-md border">
        <Table>
          <TableHeader>
            {table.getHeaderGroups().map((headerGroup) => (
              <TableRow key={headerGroup.id}>
                {headerGroup.headers.map((header) => {
                  return (
                    <TableHead key={header.id}>
                      {header.isPlaceholder
                        ? null
                        : flexRender(
                            header.column.columnDef.header,
                            header.getContext()
                          )}
                    </TableHead>
                  );
                })}
              </TableRow>
            ))}
          </TableHeader>
          <TableBody>
            {table.getRowModel().rows?.length ? (
              table.getRowModel().rows.map((row) => (
                <TableRow
                  key={row.id}
                  data-state={row.getIsSelected() && "selected"}
                >
                  {row.getVisibleCells().map((cell) => (
                    <TableCell key={cell.id}>
                      {flexRender(
                        cell.column.columnDef.cell,
                        cell.getContext()
                      )}
                    </TableCell>
                  ))}
                </TableRow>
              ))
            ) : (
              <TableRow>
                <TableCell
                  colSpan={columns.length}
                  className="h-24 text-center"
                >
                  No results.
                </TableCell>
              </TableRow>
            )}
          </TableBody>
        </Table>

        {table.getRowModel().rows?.length > 10 ? (
          <div className="flex items-center justify-end space-x-2 p-4">
            <Button
              variant="outline"
              size="sm"
              onClick={() => table.previousPage()}
              disabled={!table.getCanPreviousPage()}
            >
              Previous
            </Button>
            <Button
              variant="outline"
              size="sm"
              onClick={() => table.nextPage()}
              disabled={!table.getCanNextPage()}
            >
              Next
            </Button>
          </div>
        ) : null}
      </div>
    </div>
  );
}
