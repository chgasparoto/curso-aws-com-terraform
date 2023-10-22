import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { Link, useNavigate } from "react-router-dom";
import { Auth } from "aws-amplify";

import { SignUpSchema, signUpSchema } from "@/lib/types";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { CardContent, CardFooter } from "@/components/ui/card";

import { useAuthStore } from "@/store";

const SignUp = () => {
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
    reset,
    setError,
  } = useForm<SignUpSchema>({
    resolver: zodResolver(signUpSchema),
  });

  const setEmail = useAuthStore((store) => store.setEmail);
  const navigate = useNavigate();

  const onSubmit = async ({ email, password }: SignUpSchema) => {
    try {
      await Auth.signUp({
        username: email,
        password,
        attributes: {
          email,
        },
      });

      setEmail(email);
      reset();
      navigate("/sign-up-confirm", { replace: true });
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
                id="email"
                type="email"
                placeholder="Email"
                {...register("email")}
              />
              {errors.email && (
                <p className="text-red-500">{`${errors.email.message}`}</p>
              )}
            </div>
            <div className="flex flex-col space-y-1.5">
              <Input
                id="password"
                type="password"
                placeholder="Password"
                {...register("password")}
              />
              {errors.password && (
                <p className="text-red-500">{`${errors.password.message}`}</p>
              )}
            </div>
            <div className="flex flex-col space-y-1.5">
              <Input
                id="confirmPassword"
                type="password"
                placeholder="Confirm Password"
                {...register("confirmPassword")}
              />
              {errors.confirmPassword && (
                <p className="text-red-500">{`${errors.confirmPassword.message}`}</p>
              )}
              {errors.root?.serverError && (
                <p className="text-red-500">{`${errors.root?.serverError.message}`}</p>
              )}
            </div>
            <Button type="submit" disabled={isSubmitting}>
              Sign Up
            </Button>
          </div>
        </form>
      </CardContent>
      <CardFooter className="flex gap-2 justify-center">
        <span>Already registered?</span>
        <Link to="/sign-in" className="text-blue-500">
          Sign In
        </Link>
      </CardFooter>
    </>
  );
};

export default SignUp;
