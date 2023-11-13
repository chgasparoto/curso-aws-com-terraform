import { Navigate, Outlet, useLocation } from "react-router-dom";

import { useAuthStore } from "@/store";

export const RequireAuth = () => {
  const location = useLocation();
  const { auth } = useAuthStore();

  return auth.isAuthenticated ? (
    <Outlet />
  ) : (
    <Navigate to="/sign-in" state={{ from: location }} replace />
  );
};
