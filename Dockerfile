FROM node:17.3-alpine3.14
# setup workdir
WORKDIR /usr/src/app
# fix for npm
RUN npm config rm proxy && npm config rm https-proxy && npm update npm -g
# copy the local "./" folders to the "/usr/src/app" fodler in the container
COPY . .
# install packages
RUN npm install
VOLUME . /usr/src/app
# add volume
EXPOSE 4200 4201
# start app
CMD ["npm", "start"]

# copy the local package *.json files to the /app in the container
# COPY package.json ./
