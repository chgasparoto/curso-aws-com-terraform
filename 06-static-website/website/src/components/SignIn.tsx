import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { Link, useLocation, useNavigate } from "react-router-dom";
import { Auth } from "aws-amplify";

import { useAuthStore } from "@/store";
import { SignInSchema, signInSchema } from "@/lib/types";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { CardContent, CardFooter } from "@/components/ui/card";

export function SignIn() {
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
    reset,
    setError,
  } = useForm<SignInSchema>({
    resolver: zodResolver(signInSchema),
  });

  const { setAuth } = useAuthStore();
  const navigate = useNavigate();
  const location = useLocation();

  const onSubmit = async ({ email, password }: SignInSchema) => {
    try {
      const auth = await Auth.signIn(email, password);
      let from = location.state?.from?.pathname || "/";

      setAuth({
        id: auth.attributes.sub,
        email: auth.attributes.email,
        idToken: auth.signInUserSession.idToken.jwtToken,
        accessToken: auth.signInUserSession.accessToken.jwtToken,
        refreshToken: auth.signInUserSession.refreshToken.token,
        isAuthenticated: true,
      });

      reset();

      navigate(from, { replace: true });
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
              {errors.root?.serverError && (
                <p className="text-red-500">{`${errors.root?.serverError.message}`}</p>
              )}
            </div>
            <Button type="submit" disabled={isSubmitting}>
              Sign In
            </Button>
          </div>
        </form>
      </CardContent>
      <CardFooter className="flex gap-2 justify-center">
        <span>Not registered?</span>
        <Link to="/sign-up" className="text-blue-500">
          Sign Up
        </Link>
      </CardFooter>
    </>
  );
}
