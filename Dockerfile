# Use an official Node.js image to build the app
FROM node:18-alpine AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy all project files
COPY . .

# Build the React app
RUN npm run build

# Use a lightweight Nginx server to serve the built files
FROM nginx:alpine

# Copy built files to Nginx's public folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose the default Nginx port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
