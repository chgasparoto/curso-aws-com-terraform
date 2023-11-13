export const headers = {
  'Content-Type': 'application/json',
  'Access-Control-Allow-Origin': process.env.CORS_ORIGINS.replaceAll("'", ''),
  'Access-Control-Allow-Credentials': process.env.CORS_CREDS.replaceAll(
    "'",
    '',
  ),
  'Access-Control-Allow-Methods': process.env.CORS_METHODS.replaceAll("'", ''),
  'Access-Control-Allow-Headers': process.env.CORS_HEADERS.replaceAll("'", ''),
};
