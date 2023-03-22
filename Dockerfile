# ==== CONFIGURE =====
# Use a Node 16 base image
FROM node:16-alpine as builder

# Set the working directory to /app inside the container
WORKDIR /app

# Copy app files
COPY . .

# ==== BUILD =====
# Install dependencies (npm ci makes sure the exact versions in the lockfile gets installed)
RUN npm install

# # Set Environment variable
# ENV REACT_APP_API_URL=http://host.docker.internal:8000

# Build the app
RUN npm run build

# # ==== RUN WITHOUT NGINX =======
# # Set the env variable
# # ENV REACT_APP_API_URL=http://host.docker.internal:8000

# # Expose the port on which the app will be running (3000 is the default that `serve` uses)
# EXPOSE 80

# # Start the app
# CMD [ "npx", "http-server", "build" ]

# ==== RUN WITH NGINX =======
# Bundle static assets with nginx
FROM nginx:1.23.1-alpine as production

# Copy built assets from `builder` image
COPY --from=builder /app/build /usr/share/nginx/html

# Copy environment variables
COPY --from=builder /app/.env /usr/share/nginx/html/.env

# Add your nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]