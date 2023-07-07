ARG BASE_IMAGE_NAME
ARG PROD_IMAGE_NAME

FROM $BASE_IMAGE_NAME as build

WORKDIR /usr/src/app

COPY . .

RUN npm run build

FROM $PROD_IMAGE_NAME as prod

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/dist ./dist

RUN chown node:node -R /usr/src/app/dist

USER node

EXPOSE 3000

CMD ["node", "dist/main"]