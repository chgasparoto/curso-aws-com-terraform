import { Amplify } from "aws-amplify";
import { BrowserRouter, Route, Routes } from "react-router-dom";

import { ThemeProvider } from "@/components/theme-provider";
import { Home } from "@/components/Home";
import { SignIn } from "@/components/SignIn";
import SignUp from "@/components/SignUp";
import SignUpConfirm from "@/components/SignUpConfirm";
import { RequireAuth } from "@/components/RequiredAuth";
import PersistLogin from "@/components/PersistLogin";
import FormLayout from "@/components/FormLayout";

import { config } from "@/config";

Amplify.configure(config);

function App() {
  return (
    <BrowserRouter>
      <ThemeProvider defaultTheme="dark" storageKey="vite-ui-theme">
        <Routes>
          <Route element={<PersistLogin />}>
            <Route element={<RequireAuth />}>
              <Route path="/" element={<Home />} />
            </Route>
          </Route>
          <Route element={<FormLayout />}>
            <Route path="/sign-in" element={<SignIn />} />
            <Route path="/sign-up" element={<SignUp />} />
            <Route path="/sign-up-confirm" element={<SignUpConfirm />} />
          </Route>
        </Routes>
      </ThemeProvider>
    </BrowserRouter>
  );
}

export default App;
