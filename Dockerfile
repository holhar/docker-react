# Multi-Phase Dockerfile

# Build Phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# /app/build <-- contains the necessary data for the production code

# Run Phase
FROM nginx
# Copy over something from the other phase we've just been working on
#                               |- using nginx default dir for delivering web content
COPY --from=builder /app/build /usr/share/nginx/html
