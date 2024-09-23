ARG NODEJS_VERSION=20

##### Stage 1

FROM node:$NODEJS_VERSION-alpine AS builder

RUN apk add --no-cache alpine-sdk=~1 python3=~3 && \
    adduser -D builder && \
    chown -R builder:builder /home/builder/

USER builder
WORKDIR /home/builder/build

COPY . .

RUN yarn install --frozen-lockfile && yarn build

##### Stage 2

FROM node:$NODEJS_VERSION-alpine

RUN apk add --no-cache aws-cli=~2 jq=~1 && \
    adduser -D lisk && \
    chown -R lisk:lisk /home/lisk/

USER lisk
WORKDIR /home/lisk/across-relayer

COPY --chown=lisk:lisk --from=builder /home/builder/build/dist/ ./dist/
COPY --chown=lisk:lisk --from=builder /home/builder/build/node_modules/ ./node_modules/
COPY --chown=lisk:lisk --from=builder /home/builder/build/config/ ./config/
