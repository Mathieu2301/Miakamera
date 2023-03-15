FROM alpine:3.17.1
RUN apk add --update vlc

LABEL org.opencontainers.image.source=https://github.com/mathieu2301/miakamera

# create user
ARG USER=default
ENV HOME /home/$USER

# init cron job
ENV CRON="*/15 * * * *"
ENV RESTART="sudo pkill vlc"
RUN echo "$CRON $RESTART" > /var/spool/cron/crontabs/root

# install sudo as root
RUN apk add --update sudo

# add new user
RUN adduser -D $USER \
  && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
  && chmod 0440 /etc/sudoers.d/$USER

USER $USER
WORKDIR $HOME

COPY --chown=$USER:$USER entrypoint.sh $HOME/entrypoint.sh
ENTRYPOINT ["/bin/sh", "entrypoint.sh"]
