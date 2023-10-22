import { Auth } from "aws-amplify";

import { useAuthStore } from "@/store";

const useRefreshToken = () => {
  const setAuth = useAuthStore((store) => store.setAuth);

  const refresh = async () => {
    const currentSession = await Auth.currentSession();
    const idToken = currentSession.getIdToken();

    setAuth({
      id: idToken.payload.sub,
      email: idToken.payload.email,
      idToken: idToken.getJwtToken(),
      accessToken: idToken.getJwtToken(),
      refreshToken: currentSession.getRefreshToken().getToken(),
      isAuthenticated: true,
    });

    return idToken;
  };

  return refresh;
};

export default useRefreshToken;
