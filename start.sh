#!/bin/sh
export LD_LIBRARY_PATH=/root/.local/share/Steam/steamcmd/linux32:.

sed -i "s/^GameLength=.*/GameLength=${KF_GAME_LENGTH}\r/" "${HOME}/kf2server/KFGame/Config/DefaultGame.ini"

if [ ${KF_WEBADMIN_PORT} ]; then
    sed -i "s/^bEnabled=.*/bEnabled=true\r/" "${HOME}/kf2server/KFGame/Config/DefaultWeb.ini"
    sed -i "s/^ListenPort=.*/ListenPort=${KF_WEBADMIN_PORT}\r/" "${HOME}/kf2server/KFGame/Config/DefaultWeb.ini"
    ListenPort=8080
fi

if [ ${KF_SERVER_NAME} ]; then
    sed -i "s/^ServerName=.*/ServerName=${KF_SERVER_NAME}\r/" "${HOME}/kf2server/KFGame/Config/DefaultGame.ini"
fi

if [ "${KF_DISABLE_TAKEOVER}" == "true" ]; then
    sed -i "s/^bUsedForTakeover=.*/bUsedForTakeover=FALSE\r/" "${HOME}/kf2server/KFGame/Config/DefaultEngine.ini.ini"
fi

${HOME}/kf2server/Binaries/Win64/KFGameSteamServer.bin.x86_64 ${KF_MAP}?Game=KFGameContent.KFGameInfo_${KF_GAMEMODE}?Difficulty=${KF_DIFFICULTY}?AdminPassword=${KF_WEBADMIN_PASSWORD}?WebAdminPort=${KF_WEBADMIN_PORT}?ServerName=${KF_SERVER_NAME} -port ${KF_PORT}
