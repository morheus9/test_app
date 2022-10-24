FROM node:alpine3.15
WORKDIR /usr/src/app
COPY package.json .
RUN npm config rm proxy && npm config rm https-proxy && npm update npm -g && npm install --production; rm -rf /var/cache/apt
COPY . .
EXPOSE 4200 4201
USER node
CMD ["node", "app.js"]
