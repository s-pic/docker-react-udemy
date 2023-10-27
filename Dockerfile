FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# first block gets terminated by the following FROM statement
FROM nginx
# used by elastic beanstalk to expose port to incoming traffic
EXPOSE 80
# copy from first phase called builder. all the rest gets dumped!
COPY --from=builder /app/build /usr/share/nginx/html
# nginx image will start automatically