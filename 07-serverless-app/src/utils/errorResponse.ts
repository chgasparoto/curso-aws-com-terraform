import { headers } from './commonHeaders';

export const errorResponse = (
  message: any = { message: 'Internal server error' },
  status: number = 500,
) => ({
  statusCode: status,
  body: JSON.stringify(message),
  headers,
});
