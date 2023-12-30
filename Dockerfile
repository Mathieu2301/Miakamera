FROM alpine:3.17.1

LABEL org.opencontainers.image.source=https://github.com/mathieu2301/miakamera

# install dependencies
RUN apk add --update vlc curl sudo

# create user
ARG USER=default
RUN adduser -D $USER \
  && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
  && chmod 0440 /etc/sudoers.d/$USER

USER $USER
WORKDIR /home/$USER

# configure entrypoint
COPY --chown=$USER:$USER entrypoint.sh entrypoint.sh
ENTRYPOINT ["/bin/ash", "entrypoint.sh"]

# expose port and configure healthcheck
EXPOSE 80
HEALTHCHECK --interval=5s --timeout=5s --start-period=10s --retries=2 \
  CMD curl -fI 0.0.0.0 || ash -c 'kill -s 15 -1 && (sleep 10; kill -s 9 -1)'
