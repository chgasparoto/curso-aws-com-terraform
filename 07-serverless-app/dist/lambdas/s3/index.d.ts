import { S3Event } from 'aws-lambda';
export declare const handler: (event: S3Event) => Promise<string | boolean>;
