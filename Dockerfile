FROM node as build

WORKDIR /app
COPY . .

RUN npm i --registry=https://registry.npmmirror.com

RUN npm run build

FROM nginx
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80