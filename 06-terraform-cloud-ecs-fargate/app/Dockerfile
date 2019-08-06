FROM node:10.16-alpine
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY server.js package.json package-lock.json ./
RUN npm install --production
EXPOSE 3000
CMD [ "npm", "start" ]