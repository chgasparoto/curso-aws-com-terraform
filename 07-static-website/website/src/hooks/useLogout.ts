import { useAuthStore } from "@/store";
import { Auth } from "aws-amplify";

const useLogout = () => {
  const signOut = useAuthStore((store) => store.logout);

  const logout = () => {
    Auth.signOut();
    signOut();
  };

  return logout;
};

export default useLogout;
