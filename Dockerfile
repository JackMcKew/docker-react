# Build stage
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Run stage
FROM nginx

## Remove default nginx index page
RUN rm -rf /usr/share/nginx/html/*

EXPOSE 80

COPY --from=builder /app/build /user/share/nginx/html