
# Use a Node.js 16 base image
FROM node:16-alpine as builder

# Set the working directory to /app inside the container
WORKDIR /app

# Copy app files
COPY . .

# Install dependencies
RUN npm install

# Set environment variable
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL

# Build the app
RUN npm run build

# production environment
FROM nginx:stable-alpine as production
ENV NODE_ENV production
COPY --from=builder /app/build /usr/share/ngnx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start the app on port 80
CMD ["nginx", "-g", "daemon off;"]
