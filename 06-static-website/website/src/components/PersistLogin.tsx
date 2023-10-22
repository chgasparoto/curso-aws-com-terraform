import { Outlet } from "react-router-dom";
import { useState, useEffect } from "react";

import useRefreshToken from "@/hooks/useRefreshToken";
import { useAuthStore } from "@/store";

const PersistLogin = () => {
  const [isLoading, setIsLoading] = useState(true);
  const refresh = useRefreshToken();
  const auth = useAuthStore((store) => store.auth);

  useEffect(() => {
    const verifyRefreshToken = async () => {
      try {
        await refresh();
      } catch (err) {
        console.log(err);
      } finally {
        setIsLoading(false);
      }
    };

    !auth.idToken ? verifyRefreshToken() : setIsLoading(false);
  }, []);

  return <>{isLoading ? <p>Loading...</p> : <Outlet />}</>;
};

export default PersistLogin;
