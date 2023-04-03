
# Use a Node.js 16 base image
FROM node:16-alpine

# Set the working directory to /app inside the container
WORKDIR /app

# Copy app files
COPY . .

# Install dependencies
RUN npm install

# Set environment variable
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL
ARG REDIS_HOST
ENV REDIS_HOST=$REDIS_HOST
ARG REDIS_PORT
ENV REDIS_PORT=$REDIS_PORT

# Build the app
RUN npm run build

# Expose port 80
EXPOSE 80

# Start the app on port 80
CMD ["npx", "serve", "-s", "build", "-l", "80"]
