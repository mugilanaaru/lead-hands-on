FROM node:14-alpine as build
WORKDIR /app
ENV REACT_APP_API_BASE_URL=http://localhost:8080

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install
#RUN yarn install --frozen-lockfile


# Copy the rest of the application
COPY . .

# Build the application
#RUN yarn build
RUN npm run build

# Stage 2: Use nginx for serving the production environment
FROM nginx:alpine


# Copy the build files from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 8080

ENV PORT 8080

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
