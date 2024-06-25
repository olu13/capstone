# Use an official nginx image as the base image
FROM nginx:latest

# Copy static files to the nginx directory
COPY static /usr/share/nginx/page1.html
