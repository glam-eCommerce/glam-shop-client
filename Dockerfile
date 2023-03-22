
# ========= Build stage =========
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

# ========= Serve built files (static pages) using Serve =========
COPY --from=builder /app/build /build

# Expose port 80
EXPOSE 80

# Start the app on port 80
CMD ["npx", "serve", "-s", "build", "-l", "80"]
