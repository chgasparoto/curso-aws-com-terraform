"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = void 0;
const services_1 = require("services");
const todoService = new services_1.TodoService(process.env.TABLE_NAME || '');
const handler = async (event) => {
    console.log({
        message: 'Event received',
        data: JSON.stringify(event),
    });
    const records = event.Records;
    const promises = [];
    for (let record of records) {
        const messageBody = JSON.parse(record.body);
        const { UserId, Task } = JSON.parse(messageBody.Message);
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
    }
    const count = result.filter((r) => r.status === 'fulfilled').length;
    return `Created ${count} records into the Database`;
};
exports.handler = handler;
//# sourceMappingURL=index.js.map