# Use a Node.js 16 base image
FROM node:16-alpine as builder

# Set the working directory to /app inside the container
WORKDIR /app

# Copy app files
COPY . .

# Install dependencies
RUN npm install

# Build the app
RUN npm run build

# Expose the port on which the app will be running (3000 is the default that `http-server` uses)
EXPOSE 3000

# Start the app on port 80
CMD ["npx", "http-server", "build"]
