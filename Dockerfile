FROM n8nio/n8n

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    python3 -m pip install --upgrade pip


RUN cd /usr/local/lib/node_modules/n8n && npm install n8n-nodes-python
COPY requirements.txt .

RUN python3 -m pip install -r requirements.txt

RUN npm install -g npm@latest
RUN npm install -g node-fetch
RUN npm install -g langchain

ARG PGPASSWORD
ARG PGHOST
ARG PGPORT
ARG PGDATABASE
ARG PGUSER

ARG USERNAME
ARG PASSWORD

ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_DATABASE=$PGDATABASE
ENV DB_POSTGRESDB_HOST=$PGHOST
ENV DB_POSTGRESDB_PORT=$PGPORT
ENV DB_POSTGRESDB_USER=$PGUSER
ENV DB_POSTGRESDB_PASSWORD=$PGPASSWORD

ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=$USERNAME
ENV N8N_BASIC_AUTH_PASSWORD=$PASSWORD
ENV N8N_PAYLOAD_SIZE_MAX=100
ENV NODE_FUNCTION_ALLOW_BUILTIN=*

CMD ["n8n", "start"]
