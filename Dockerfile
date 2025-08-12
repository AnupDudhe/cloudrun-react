# Stage 1: Build React app from GitHub repo
FROM node:18 AS build
WORKDIR /app

# Clone a default create-react-app repo
RUN git clone https://github.com/facebook/create-react-app.git react-source
WORKDIR /app/react-source
# Install dependencies
RUN npm install
# Build the default app
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine
# Clean default nginx html
RUN rm -rf /usr/share/nginx/html/*
# Copy build files from previous stage
COPY --from=build /app/react-source/build /usr/share/nginx/html
# Change Nginx to listen on port 8080 for Cloud Run
RUN sed -i 's/80/8080/' /etc/nginx/conf.d/default.conf
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
