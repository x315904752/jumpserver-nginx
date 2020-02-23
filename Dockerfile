FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
CMD envsubst '$LUNA_IP $LUNA_PORT $KOKO_IP $KOKO_PORT $GUACAMOLE_IP $GUACAMOLE_PORT $JMS_IP $JMS_WEB_PORT $JMS_WS_PORT' < /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'