# Miakamera

Cet outil permet de run VLC en tant que transcodeur de flux vidéo.

## Exemples d'utilisation

- Transcoder un flux RTSP en HTTP
- Enregistrer un flux vidéo
- Diffuser un flux vidéo

## Fonctionnalités

- ~~Redémarrage automatique régulier (tâche cron)~~
- Redémarrage automatique en cas de coupure du flux vidéo (healthcheck)
- Personnalisation complète des paramètres de lancement de VLC

## Installation

Le meilleur moyen d'installer cet outil est de le faire via Docker Compose.

```yaml
version: '3.1'

services:
  miakamera:
    image: ghcr.io/mathieu2301/miakamera:latest
    restart: always
    command:
      -I dummy
      -vvv rtsp://user:password@192.168.0.100:554/live/ch0
      --sout "#transcode{vcodec=MJPG,fps=1,vb=800,scale=Automatique,acodec=none,scodec=none}:standard{access=http{mime=multipart/x-mixed-replace;boundary=--7b3cc56e5f51db803f790dad720ed50a},mux=mpjpeg,dst=:80/}"
      --quiet
    expose: [80]
    ports: [80:80]
```
