export const config = {
  Auth: {
    region: import.meta.env.VITE_AWS_REGION,
    userPoolId: import.meta.env.VITE_COGNITO_USER_POOL_ID,
    userPoolWebClientId: import.meta.env.VITE_COGNITO_USER_POOL_CLIENT_ID,
    // cookieStorage: {
    //   domain: `.${import.meta.env.VITE_DOMAIN}`,
    //   path: "/",
    //   expires: 30,
    //   sameSite: "lax",
    //   secure: true,
    // },
  },
};
