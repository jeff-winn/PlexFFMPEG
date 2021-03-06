FROM plexinc/pms-docker:latest

RUN apt-get install curl -y
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install nodejs -y

WORKDIR /usr/src/plex-transcode-interceptor

COPY package*.json ./
COPY tsconfig*.json ./
COPY ./src src

RUN npm install
RUN npm run build-prod
RUN npm run pkg

RUN \
# Replace the transcoder
    cp -f ./bin/Plex\ Transcoder-linux /usr/lib/plexmediaserver/Plex\ Transcoder