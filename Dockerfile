FROM node:10 as lina-build
WORKDIR /data
ADD ./jms_lina/package.json /data/package.json
ADD ./jms_lina/yarn.lock /data/yarn.lock
RUN yarn
ADD ./jms_lina /data
RUN yarn build:prod


FROM node:10 as luna-build
WORKDIR /data
ADD ./jms_luna2/package.json /data/package.json
ADD ./jms_luna2/package-lock.json /data/package-lock.json
RUN npm i
ADD ./jms_luna2 /data
RUN npm run-script build

FROM nginx:alpine
COPY --from=lina-build /data/lina /opt/lina/
COPY --from=luna-build /data/luna /opt/luna/
COPY ./jms_luna2/src/assets/i18n /opt/luna/i18n
COPY ./jms_luna2/nginx.conf /etc/nginx/conf.d/luna.conf
COPY ./jms_lina/nginx.conf /etc/nginx/conf.d/lina.conf
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
CMD envsubst '$KOKO_IP $KOKO_PORT $GUACAMOLE_IP $GUACAMOLE_PORT $JMS_IP $JMS_WEB_PORT $JMS_WS_PORT' < /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
