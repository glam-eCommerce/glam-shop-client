# Use a Node.js 16 base image
FROM node:16-alpine as builder

# Set the working directory to /app inside the container
WORKDIR /app

# Copy app files
COPY package*.json ./
COPY public ./public
COPY src ./src

# Install dependencies
RUN npm install

# Build the app
RUN npm run build

# Run the app
FROM node:16-alpine as production

# Copy built assets from `builder` image
COPY --from=builder /app/build /app/build

# Expose port 80
EXPOSE 80

# Start the app on port 80
CMD ["npx", "serve", "-s", "-l", "80", "build"]
