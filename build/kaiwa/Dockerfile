FROM node:9

# Get the source code
RUN apt-get install git
RUN git clone https://github.com/ForNeVeR/Kaiwa /usr/src/app

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
ENV NODE_ENV development
RUN npm install

# Place the configuration
COPY files/dev_config.json ./

# Install the application
RUN npm run compile

ADD files/start.sh /start.sh

EXPOSE 8000
CMD [ "/start.sh" ]
