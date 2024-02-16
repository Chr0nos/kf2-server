FROM steamcmd/steamcmd:ubuntu-22
LABEL MAINTAINER=snicolet@student.42.fr

WORKDIR $HOME

# Update SteamCMD and verify latest version
RUN steamcmd +quit

# Fetch the game files
RUN steamcmd +force_install_dir ${HOME}/kf2server +login anonymous +app_update 232130 validate +quit
RUN apt update -y && apt install -y wget lib32gcc-s1 libcurl4 && rm -rf /var/lib/apt/

WORKDIR ${HOME}/kf2server
COPY start.sh ${HOME}/kf2server/
ENTRYPOINT ["./start.sh"]
