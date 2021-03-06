FROM node:alpine3.15
# setup workdir
WORKDIR /usr/src/app
# fix for npm
COPY package.json ./
RUN npm config rm proxy && npm config rm https-proxy && npm update npm -g
# copy the local "./" folders to the "/usr/src/app" fodler in the container
# install packages
RUN npm install --production
COPY . .
# open ports
EXPOSE 4200 4201
# start app
CMD ["node", "app.js"]

# copy the local package *.json files to the /app in the container
