FROM nginx:latest

COPY page1.html /usr/share/nginx/html/page1.html
COPY page2.html /usr/share/nginx/html/page2.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
