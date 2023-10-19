"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.successResponse = void 0;
const successResponse = (message, status = 200) => ({
    statusCode: status,
    body: JSON.stringify(message),
    headers: {
        'Content-Type': 'application/json',
    },
});
exports.successResponse = successResponse;
//# sourceMappingURL=successResponse.js.map