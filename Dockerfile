FROM node:14-alpine

RUN mkdir /app
WORKDIR /app

COPY . .

RUN yarn
RUN yarn build

CMD ["yarn", "start"]