import { Handler, SQSEvent, SQSRecord } from 'aws-lambda';

import { TodoService } from 'services';
import { TodoItem } from 'types';

const todoService = new TodoService(process.env.TABLE_NAME || '');

export const handler: Handler = async (event: SQSEvent): Promise<any> => {
  console.log({
    message: 'Event received',
    data: JSON.stringify(event),
  });

  const records: SQSRecord[] = event.Records;
  const promises = [];

  for (let record of records) {
    const messageBody = JSON.parse(record.body);
    const { UserId, Task }: TodoItem = JSON.parse(messageBody.Message);

    console.log({
      message: 'Record',
      data: JSON.stringify(messageBody),
    });

    promises.push(todoService.create(UserId, Task));
  }

  const result = await Promise.allSettled(promises);

  console.log({
    message: 'Result',
    data: JSON.stringify(result),
  });

  if (result.some((r) => r.status === 'rejected')) {
    // TODO: send it to the DLQ
  }

  const count = result.filter((r) => r.status === 'fulfilled').length;

  return `Created ${count} records into the Database`;
};
