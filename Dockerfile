FROM python:3.8-slim
LABEL weihuzhe="aigc"

# ENV DB_TYPE='Sqlite'
# ENV DB_HOST='127.0.0.1'
# ENV DB_PORT='3306'
# ENV DB_USER='KAMIFKA'
# ENV DB_PASSWORD='PASSWORD'
# ENV DB_DATABASE='KAMIFKA' 

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .
RUN chmod +x docker-entrypoint.sh

# EXPOSE 8000

# ENTRYPOINT [ "/usr/src/app/docker-entrypoint.sh" ]

# # ENTRYPOINT ["gunicorn","-k", "gevent", "--bind", "0.0.0.0:8000", "--workers", "8", "app:app"]


# ------------------------------------
# FROM baiyuetribe/kamifaka:latest
LABEL weihuzhe="aigc"
# Mysql \ PostgreSQL
ENV DB_TYPE='Mysql'

RUN sed -i "s|'postgresql+psycopg2://\${DB_USER}:\${DB_PASSWORD}@\${DB_HOST}:\${DB_PORT}/\${DB_DATABASE}'|'\`echo \$DATABASE_URL \| sed \'s/postgres/postgresql\\\+psycopg2/\'\`'|g" docker-entrypoint.sh && \
    sed -i '$d' docker-entrypoint.sh && \
    echo "gunicorn -k gevent --bind 0.0.0.0:\${PORT} --workers 4 app:app" >> docker-entrypoint.sh

EXPOSE $PORT

ENTRYPOINT [ "/usr/src/app/docker-entrypoint.sh" ]
