# Multi-Phase Dockerfile

# Build Phase
#FROM node:alpine as builder <-- aws-ebs can not deal with this
FROM node:alpine
WORKDIR '/app'
#COPY package.json . <-- aws-ebs can not deal with this
COPY package*.json .
RUN npm install
COPY . .
RUN npm run build
# /app/build <-- contains the necessary data for the production code

# Run Phase
FROM nginx
EXPOSE 80
# Copy over something from the other phase we've just been working on
#                               |- using nginx default dir for delivering web content
COPY --from=0 /app/build /usr/share/nginx/html
