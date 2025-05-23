FROM openjdk:21-jdk-slim

RUN apt-get update && \
    apt-get install -y git

WORKDIR /minecraft

ENV MEMORY="6G"

COPY . .

ARG TEMPLATE_WORLD
ARG CORE_NAME
ENV TEMPLATE_WORLD=${TEMPLATE_WORLD:-0}
ENV CORE_NAME=${CORE_NAME:-purpur-1.21.4-2416.jar}

EXPOSE 13488

RUN chmod +x /minecraft/start.sh

CMD ["/minecraft/start.sh"]