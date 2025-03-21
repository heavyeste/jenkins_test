# # Use an official Node runtime as a parent image
# FROM node:14 AS build

# # Set the working directory
# WORKDIR /app

# # Copy the package.json and package-lock.json files
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy the rest of the application files
# COPY . .

# # Build the Angular application
# RUN npm run build --prod

# # Use an official NGINX runtime as a parent image
# FROM nginx:alpine

# # Copy the Angular build output to the NGINX html directory
# COPY --from=build /app/dist /usr/share/nginx/html

# # Expose port 80
# EXPOSE 80

# # Start NGINX
# CMD ["nginx", "-g", "daemon off;"]
FROM nginx:alpine
# RUN ["apt-get", "update"]
# RUN ["apt-get", "install", "-y", "nano"]

# WORKDIR /usr/share/nginx/html
# Copia i file costruiti dall'immagine precedente
COPY dist/ /usr/share/nginx/html/

# Copia il file di configurazione di Nginx
# COPY nginx.conf /etc/nginx/nginx.conf

# Espone la porta 80
EXPOSE 80

# Avvia Nginx
CMD ["nginx", "-g", "daemon off;"]
