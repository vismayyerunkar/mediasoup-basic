FROM node:16 AS stage-one

# Install DEB dependencies and others.
RUN \
	set -x \
	&& apt-get update \
	&& apt-get install -y net-tools build-essential python3 python3-pip valgrind

# # RUN mkdir -p /usr/src/app
# # WORKDIR /usr/src/app
# COPY . /usr/src/app
# COPY ./package.json /usr/src/app
# COPY . /usr/src/app

WORKDIR /usr/app
COPY package.json .

RUN npm install

# this needs the .dockerignore file so that that node modules in our root folder are not copied else it will create mediasoup worker conflicts
COPY . .  

# RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.2/zsh-in-docker.sh)"

CMD [ "node", "index.js" ]
# ENTRYPOINT ["tail", "-f", "/dev/null"]
