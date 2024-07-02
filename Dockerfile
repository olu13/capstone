FROM nginx:latest
# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Copy HTML files from your local machine to the container
COPY index.html ./

# Install curl for making HTTP requests (or any other package you need)
RUN apt-get update && apt-get install -y curl

# Expose port 80 to allow incoming traffic
EXPOSE 80

# Start Nginx server when the container starts
CMD ["nginx", "-g", "daemon off;"]

