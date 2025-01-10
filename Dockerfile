FROM steamcmd/steamcmd

ENV DEBIAN_FRONTEND=noninteractive

# install deps
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y apt-utils && \
    apt-get install -y \
        lib32gcc-s1 \
    && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# steam cmd and directory conf
ENV USER dayz
ENV BASE_DIR /dayz
ENV HOME ${BASE_DIR}/home
ENV SERVER_DIR ${BASE_DIR}/server
ENV STEAM_CMD_USER anonymous
ENV STEAM_CMD_PASSWORD=""

# base dirs
RUN mkdir -p ${BASE_DIR} && \
    groupadd dayz && \
    useradd -m -d ${HOME} -s /bin/bash -g dayz dayz && \
    mkdir -p ${SERVER_DIR}

# permissions
RUN chown -R dayz:dayz ${BASE_DIR} && \
    chown -R :dayz /usr/bin/steamcmd

# game
EXPOSE 2302/udp
EXPOSE 2303/udp
EXPOSE 2304/udp
EXPOSE 2305/udp
# steam
EXPOSE 8766/udp
EXPOSE 27016/udp
# rcon (preferred)
EXPOSE 2310

WORKDIR ${BASE_DIR}
VOLUME ${BASE_DIR}
USER dayz

# update steamcmd & validate user permissions
RUN steamcmd +quit

ENV APP_ID="223350"

# reset cmd & define entrypoint
CMD [ "start" ]
COPY entrypoint.sh /dayz/entrypoint.sh
ENTRYPOINT [ "/dayz/entrypoint.sh" ]
