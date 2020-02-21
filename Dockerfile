FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/jms.conf
CMD envsubst '$LUNA_IP $LUNA_PORT $COCO_IP $COCO_PORT $GUACAMOLE_IP $GUACAMOLE_PORT $JMS_IP $JMS_PORT ' < /etc/nginx/conf.d/jms.conf > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'