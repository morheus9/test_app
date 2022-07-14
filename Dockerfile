FROM node:17.3-alpine3.14
# setup workdir
WORKDIR /usr/src/app
# fix for npm
COPY package.json ./
RUN npm config rm proxy && npm config rm https-proxy && npm update npm -g
# copy the local "./" folders to the "/usr/src/app" fodler in the container
# install packages
RUN npm install
COPY . .
# add volume

# start app
CMD ["npm", "run"]

# copy the local package *.json files to the /app in the container
#
