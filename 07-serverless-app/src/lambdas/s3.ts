import { GetObjectCommand, S3Client } from '@aws-sdk/client-s3';
import {
  PublishCommand,
  PublishCommandInput,
  SNSClient,
} from '@aws-sdk/client-sns';
import { S3Event, S3EventRecord } from 'aws-lambda';
import { TodoItem, TodoItemSchema } from 'types';

const client = {
  s3: new S3Client(),
  sns: new SNSClient(),
};

const isTodoItemValid = (item: TodoItem): boolean => {
  const isValid = TodoItemSchema.safeParse(item);
  return isValid.success;
};

const getFileContent = async (
  S3Client: S3Client,
  bucket: string,
  filename: string,
): Promise<string> => {
  const params = {
    Bucket: bucket,
    Key: filename,
  };

  const command = new GetObjectCommand(params);
  const file = await S3Client.send(command);

  return await file.Body?.transformToString();
};

const publishMessage = async (
  SNSClient: SNSClient,
  payload: PublishCommandInput,
): Promise<void> => {
  const command = new PublishCommand(payload);
  await SNSClient.send(command);
  return;
};

export const handler = async (event: S3Event): Promise<string | boolean> => {
  if (process.env.DEBUG === 'true') {
    console.log({
      message: 'Event received',
      data: JSON.stringify(event),
    });
  }

  const topicArn = process.env.TOPIC_ARN;
  if (!topicArn) {
    const message = 'Topic not found';

    console.error({ message });
    throw new Error(message);
  }

  const { s3 } = event.Records[0] as S3EventRecord;
  const content = await getFileContent(
    client.s3,
    s3.bucket.name,
    s3.object.key,
  );

  console.log({
    message: 'File content retrieved',
    data: JSON.stringify(content),
  });

  const parsedContent: TodoItem[] = JSON.parse(content);
  let promises = [];

  for (let record of parsedContent) {
    const isValidRecord = TodoItemSchema.safeParse(record);

    if (isValidRecord.success === false) {
      console.log({
        message: 'Invalid record found',
        data: JSON.stringify({
          record,
          error: isValidRecord.error.message,
        }),
        error: isValidRecord.error,
      });
      continue;
    }

    promises.push(
      publishMessage(client.sns, {
        Message: JSON.stringify(record),
        Subject: 'Data from S3',
        TopicArn: topicArn,
      }),
    );
  }

  const result = await Promise.allSettled(promises);

  console.log({
    message: 'Messages published',
    data: JSON.stringify(result),
  });

  const count = result.filter((r) => r.status === 'fulfilled').length;

  return `Published ${count} messages to the Topic (${topicArn})`;
};
