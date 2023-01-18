FROM node AS build

WORKDIR /app
COPY . .

RUN npm i && npm run build

# 多阶段构建，减小运行时镜像的体积
FROM nginx

# 使用nginx默认配置
# COPY --from=build /app/dist /usr/share/nginx/html

# 使用自定义 nginx.conf，解决 history 模式下刷新页面 404 的问题
COPY --from=build /app/dist /app
COPY nginx.conf /etc/nginx/nginx.conf

# 声明运行时容器提供服务的端口，并不会真的暴露端口，需要 -p 参数来映射端口，所以下面的声明省略也能构建镜像。
EXPOSE 80