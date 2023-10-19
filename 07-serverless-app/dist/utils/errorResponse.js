"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.errorResponse = void 0;
const errorResponse = (message = { message: 'Internal server error' }, status = 500) => ({
    statusCode: status,
    body: JSON.stringify(message),
    headers: {
        'Content-Type': 'application/json',
    },
});
exports.errorResponse = errorResponse;
//# sourceMappingURL=errorResponse.js.map