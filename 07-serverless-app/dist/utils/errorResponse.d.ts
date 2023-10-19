export declare const errorResponse: (message?: any, status?: number) => {
    statusCode: number;
    body: string;
    headers: {
        'Content-Type': string;
    };
};
