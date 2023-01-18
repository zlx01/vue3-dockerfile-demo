FROM node AS build

WORKDIR /app
COPY . .

RUN npm i && npm run build

# 多阶段构建，减小运行时镜像的体积
FROM nginx
COPY --from=build /app/dist /usr/share/nginx/html

# 声明运行时容器提供服务的端口，并不会真的暴露端口，需要 -p 参数来映射端口，所以下面的声明省略也能构建镜像。
EXPOSE 80