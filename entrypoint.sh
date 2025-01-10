#!/bin/bash


function updateGame() {
    steamcmd \
        +login ${STEAM_CMD_USER} ${STEAM_CMD_PASSWORD} \
        +force_install_dir ${SERVER_DIR} \
        +app_update ${APP_ID} \
        ${EXTRA_UPDATE_ARGS} \
        +quit
}

function startGame() {
    cd ${SERVER_DIR}
    ./DayZServer \
        -config="serverDZ.cfg" \
    	-port=2302 \
    	-BEpath=battleye \
    	-profiles=profiles \
    	-dologs \
    	-adminlog \
    	-netlog \
    	-freezecheck
}

case "$1" in
    start)
        updateGame
        startGame
    ;;
    update)
        updateGame
    ;;
    *)
        exec "$@"
    ;;
esac
