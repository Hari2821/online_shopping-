FROM nginx:1.25-alpine

# Clean existing html
RUN rm -rf /usr/share/nginx/html/*

# Copy built frontend to NGINX web root
COPY build/ /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

