FROM nginx:1.26.2
COPY index.html /usr/share/nginx/html/index.html
COPY images /usr/share/nginx/html/images/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]