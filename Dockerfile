
FROM  node:25-alpine AS sample

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build


FROM nginx:1.28.0-alpine

COPY  --from=sample /app/build /usr/share/nginx/html



