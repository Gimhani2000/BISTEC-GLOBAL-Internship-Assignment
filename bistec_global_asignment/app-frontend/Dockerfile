FROM node:18-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Use Node.js to serve the frontend
FROM node:18-alpine
WORKDIR /app
COPY --from=build /app .
RUN npm install -g serve
EXPOSE 3000
CMD ["serve", "-s", "build"]