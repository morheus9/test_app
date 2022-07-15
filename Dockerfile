FROM node:17.3-alpine3.14
# setup workdir
WORKDIR /usr/src/app
# fix for npm
COPY package.json ./
RUN npm config rm proxy && npm config rm https-proxy && npm update npm -g
# copy the local "./" folders to the "/usr/src/app" fodler in the container
# install packages
RUN npm install --production
COPY . .
# add volume
EXPOSE 4200
# start app
RUN export PORT=4200
CMD ["node", "app.js"]

# copy the local package *.json files to the /app in the container
#
