# .env variables
ARG MARIADB_IMAGE ${MARIADB_IMAGE}

FROM mariadb:${MARIADB_IMAGE}

ARG WORK_DIR ${WORK_DIR}

#set working directory
WORKDIR ${WORK_DIR}

# pacote para acompanhar o progresso de dump end restore
# apenas para desenvolvimento
# conesão ssh
#RUN apt update && apt install -y \
#    pv \
#    openssh-server
