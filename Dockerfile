
# Use a Node.js 16 base image
FROM node:16-alpine

# Set the working directory to /app inside the container
WORKDIR /app

# Copy app files
COPY . .

# Install dependencies
RUN npm install

# Build the app
RUN npm run build

# Copy build files to /app
COPY build /app/build

# Expose port 80
EXPOSE 80

# Start the app on port 80
CMD ["npx", "serve", "-s", "build", "-l", "80"]
