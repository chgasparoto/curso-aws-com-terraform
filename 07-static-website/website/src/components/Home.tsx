import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { AxiosError } from "axios";

import { useAuthStore, useTodoStore } from "@/store";
import { StoreRecordToTodos } from "@/lib/utils";

import useAxios from "@/hooks/useAxios";
import useLogout from "@/hooks/useLogout";

import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { DataTable } from "@/components/todos/data-table";
import { columns } from "@/components/todos/columns";
import { Skeleton } from "@/components/ui/skeleton";
import { Separator } from "@/components/ui/separator";

export const Home = () => {
  const [isLoading, setIsLoading] = useState(true);

  const auth = useAuthStore((store) => store.auth);
  const todos = useTodoStore((store) => store.todos);
  const setTodos = useTodoStore((store) => store.setTodos);
  const axios = useAxios();
  const location = useLocation();
  const logout = useLogout();
  const navigate = useNavigate();

  useEffect(() => {
    let isMounted = true;
    const controller = new AbortController();

    const fetchTodos = async () => {
      try {
        const response = await axios.get("/v1/todos", {
          signal: controller.signal,
        });

        isMounted && setTodos(response.data);
      } catch (err) {
        console.log({ err });

        if (err instanceof AxiosError && err.name !== "CanceledError") {
          if (err.response?.status === 401) {
            navigate("/sign-in", { state: { from: location }, replace: true });
          }
        }
      } finally {
        setIsLoading(false);
      }
    };

    fetchTodos();

    return () => {
      isMounted = false;
      controller.abort();
      setTodos([]);
    };
  }, []);

  const handleLogoutClick = () => {
    logout();
    navigate("/sign-in");
  };

  return (
    <div className="flex justify-center h-screen">
      <div className="p-4 rounded-lg">
        <Card className="w-[700px]">
          <CardHeader>
            <CardTitle>Terraform Todo</CardTitle>
            <CardDescription>
              A simple todo app built with Terraform and React.js
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="flex items-center justify-between">
              Welcome {auth.email}!
              <Button variant="secondary" onClick={handleLogoutClick}>
                Sign out
              </Button>
            </div>
          </CardContent>
        </Card>

        <Separator className="my-5" />

        {isLoading ? (
          <div className="flex items-center space-x-4 my-5">
            <div className="space-y-2 w-full">
              <Skeleton className="h-4 w-full" />
              <Skeleton className="h-4 w-full" />
              <Skeleton className="h-4 w-full" />
            </div>
          </div>
        ) : (
          <div className="mx-auto">
            <DataTable columns={columns} data={StoreRecordToTodos(todos)} />
          </div>
        )}
      </div>
    </div>
  );
};
