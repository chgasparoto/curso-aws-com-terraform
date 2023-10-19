"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = void 0;
const client_s3_1 = require("@aws-sdk/client-s3");
const client_sns_1 = require("@aws-sdk/client-sns");
const types_1 = require("types");
const client = {
    s3: new client_s3_1.S3Client(),
    sns: new client_sns_1.SNSClient(),
};
const isTodoItemValid = (item) => {
    const isValid = types_1.TodoItemDto.safeParse(item);
    return isValid.success;
};
const getFileContent = async (S3Client, bucket, filename) => {
    const params = {
        Bucket: bucket,
        Key: filename,
    };
    const command = new client_s3_1.GetObjectCommand(params);
    const file = await S3Client.send(command);
    return await file.Body?.transformToString();
};
const publishMessage = async (SNSClient, payload) => {
    const command = new client_sns_1.PublishCommand(payload);
    await SNSClient.send(command);
    return;
};
const handler = async (event) => {
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
    const { s3 } = event.Records[0];
    const content = await getFileContent(client.s3, s3.bucket.name, s3.object.key);
    console.log({
        message: 'File content retrieved',
        data: JSON.stringify(content),
    });
    const parsedContent = JSON.parse(content);
    let promises = [];
    for (let record of parsedContent) {
        const isValidRecord = types_1.TodoItemDto.safeParse(record);
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
        promises.push(publishMessage(client.sns, {
            Message: JSON.stringify(record),
            Subject: 'Data from S3',
            TopicArn: topicArn,
        }));
    }
    const result = await Promise.allSettled(promises);
    console.log({
        message: 'Messages published',
        data: JSON.stringify(result),
    });
    const count = result.filter((r) => r.status === 'fulfilled').length;
    return `Published ${count} messages to the Topic (${topicArn})`;
};
exports.handler = handler;
//# sourceMappingURL=index.js.map