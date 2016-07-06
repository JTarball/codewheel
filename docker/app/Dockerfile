FROM jtarball/docker-base:latest
# NOTE: docker-base useful environment variables
# ENV_TYPE
# APP_DIR
MAINTAINER James Tarball <james.tarball@gmail.com>

COPY src $APP_DIR

COPY docker-entrypoint.sh /entrypoint.sh
RUN sudo chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8080

CMD ["app"]
