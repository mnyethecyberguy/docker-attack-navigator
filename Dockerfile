FROM node:18-bullseye-slim as build-env

WORKDIR /src
ENV DEBIAN_FRONTEND noninteractive
ENV NODE_OPTIONS=--openssl-legacy-provider

RUN chown -R node:node ./

# Install packages and build
RUN apt update --fix-missing && \
    apt install -qqy --no-install-recommends ca-certificates git wget && \
    git clone https://github.com/mitre-attack/attack-navigator.git --branch v4.8.2 && \
    mkdir /src/nav-app && \
    mkdir /src/layers && \
    mv attack-navigator/nav-app/* /src/nav-app/ && \
    mv attack-navigator/layers/*.md /src/layers/ && \
    mv attack-navigator/*.md /src/ && \
    rm -rf attack-navigator

WORKDIR /src/nav-app

RUN npm install --unsafe-perm --legacy-peer-deps && \
    npm install -g @angular/cli && \
    ng build --output-path /tmp/output && \
    rm -rf /var/lib/apt/lists/*

USER node

# Build final container to serve static content.
FROM nginx:mainline-alpine
COPY --from=build-env /tmp/output /usr/share/nginx/html