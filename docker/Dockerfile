FROM node:16.19.1-alpine AS base-image

ENV CHECKSUM_DIRECTORY_PATH="/opt/node_builds"

ARG APP_USER_ID=1000
ARG APP_GROUP_ID=1000

RUN apk update && \
    apk add --no-cache shadow && \
    groupmod -g ${APP_GROUP_ID} node && \
    usermod -u ${APP_USER_ID} -g ${APP_GROUP_ID} node

WORKDIR /var/www

FROM base-image AS build-dev

COPY --chmod=0755 entrypoint.sh /entrypoint.sh

RUN mkdir -p ${CHECKSUM_DIRECTORY_PATH} && chown node:node -R ${CHECKSUM_DIRECTORY_PATH}

ENTRYPOINT ["/entrypoint.sh"]

USER node

CMD ["npm", "run", "start"]

