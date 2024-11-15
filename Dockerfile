FROM node:20-alpine

# Install bash and gettext (for envsubst)
RUN apk add --no-cache bash gettext
#RUN apk add --no-cache g++ make py3-pip

# Set the working directory
WORKDIR /app

# Set default values for environment variables
ENV LISTEN_IP="0.0.0.0" \
    LISTEN_PORT=7801 \
    SERVER_IP="127.0.0.1" \
    SERVER_PORT=7701 \
    SERVER_NAME="Tera Private" \
    SERVER_ID=2800 \
    PUBLISHER="GF" \
    LANGUAGE="eu" \
    PATCH_VERSION="100.02" \
    PROTOCOL_VERSION=376012 \
    INTEGRITY=false

# Copy package files and install dependencies
#COPY package*.json ./
#RUN npm install -g node-gyp
#RUN npm install
#RUN npm rebuild tera-network-crypto

# Copy application files
COPY . .

# Copy the config template
COPY config.json.template /app/config.json.template

# Expose the necessary port
EXPOSE 7801

# Set environment variables and replace placeholders in the config.json file at container startup
CMD sh -c "envsubst < /app/config.json.template > /app/config.json && node --use-strict --harmony bin/index-cli.js"