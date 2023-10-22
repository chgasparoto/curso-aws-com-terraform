import { Outlet } from "react-router-dom";
import {
  Card,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";

const FormLayout = () => {
  return (
    <>
      <div className="flex items-center justify-center h-screen">
        <div className="p-4 rounded-lg">
          <Card className="w-[350px]">
            <CardHeader>
              <CardTitle>Terraform Todo</CardTitle>
              <CardDescription>
                A simple todo app built with Terraform and React.js
              </CardDescription>
            </CardHeader>
            <Outlet />
          </Card>
        </div>
      </div>
    </>
  );
};

export default FormLayout;
