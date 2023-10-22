import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { useNavigate } from "react-router-dom";
import { Auth } from "aws-amplify";

import { useAuthStore } from "@/store";
import { SignUpConfirmSchema, signUpConfirmSchema } from "@/lib/types";

import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { CardContent } from "@/components/ui/card";

const SignUpConfirm = () => {
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
    reset,
    setError,
  } = useForm<SignUpConfirmSchema>({
    resolver: zodResolver(signUpConfirmSchema),
  });

  const auth = useAuthStore((store) => store.auth);
  const navigate = useNavigate();

  const onSubmit = async ({ code }: SignUpConfirmSchema) => {
    try {
      await Auth.confirmSignUp(auth.email, code);

      reset();
      navigate("/sign-in", { replace: true });
    } catch (err) {
      console.log({ err });
      setError("root.serverError", {
        type: "400",
        message: (err as Error).message,
      });
    }
  };

  return (
    <>
      <CardContent>
        <form
          onSubmit={handleSubmit(onSubmit)}
          className="flex flex-col gap-y-2"
        >
          <div className="grid w-full items-center gap-4">
            <div className="flex flex-col space-y-1.5">
              <Input
                id="code"
                type="text"
                placeholder="Code"
                {...register("code")}
              />
              {errors.code && (
                <p className="text-red-500">{`${errors.code.message}`}</p>
              )}
              {errors.root?.serverError && (
                <p className="text-red-500">{`${errors.root?.serverError.message}`}</p>
              )}
            </div>
            <Button type="submit" disabled={isSubmitting}>
              Confirm code
            </Button>
          </div>
        </form>
      </CardContent>
    </>
  );
};

export default SignUpConfirm;
