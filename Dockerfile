FROM openjdk:21-jdk-slim

WORKDIR /minecraft

ENV MEMORY="6G"

COPY . .

RUN echo "eula=true" > eula.txt
RUN printf "online-mode=false\nserver-port=13488\n" > server.properties

ARG TEMPLATE_WORLD
ARG CORE_NAME
ENV TEMPLATE_WORLD=${TEMPLATE_WORLD:-0}
ENV CORE_NAME=${CORE_NAME:-purpur-1.21.4-2416.jar}
RUN bash install_templates.sh "$TEMPLATE_WORLD"
RUN bash copy_core.sh "$CORE_NAME"

EXPOSE 13488

CMD ["sh", "-c", "java -Xms$MEMORY -Xmx$MEMORY \
    -XX:+AlwaysPreTouch -XX:+DisableExplicitGC \
    -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem \
    -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC \
    -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 \
    -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 \
    -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 \
    -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 \
    -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 \
    -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 \
    -Dusing.aikars.flags=https://mcflags.emc.gs \
    -Daikars.new.flags=true -jar server.jar nogui"]