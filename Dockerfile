# Stage 1: Build
FROM node:18 AS builder

WORKDIR /usr/src/app
COPY package*.json ./

RUN npm install
RUN npm install react-scripts -g

COPY . .
RUN npm run build

# Stage 2: NGINX
FROM nginx:1.25-alpine
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
