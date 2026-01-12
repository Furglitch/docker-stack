# Furglitch's Docker Stack

A curated collection of Docker Compose configurations for running personal media, web services, and supporting utilities.

Quick links

- Compose manifests: [`compose-media/`](/compose-media), [`compose-web/`](/compose-web), [`compose-util/`](/compose-util)
- Configs: [`config-media/`](/config-media), [`config-web/`](/config-web)

## Included apps

### Media Services
<p align="center">
<img width="50px" height="50px" src=".github/assets/icons/sh-plex.svg" title="Plex"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-tautulli.svg" title="Tautulli"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-kometa.svg" title="Kometa"/>
<br/>
<img width="50px" height="50px" src=".github/assets/icons/sh-radarr.svg" title="Radarr"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-sonarr.svg" title="Sonarr"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-bazarr.svg" title="Bazarr"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-prowlarr.svg" title="Prowlarr"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-recyclarr.svg" title="Recyclarr"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-tdarr.svg" title="Tdarr"/>
<br/>
<img width="50px" height="50px" src=".github/assets/icons/sh-gluetun.svg" title="Gluetun"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-sabnzbd.svg" title="SABnzbd"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-qbittorrent.svg" title="qBittorrent"/>
</p>

### Web Services
<p align="center">
<img width="50px" height="50px" src=".github/assets/icons/sh-homepage.svg" title="Homepage"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-vaultwarden.svg" title="VaultWarden"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-nextcloud.svg" title="Nextcloud"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-mealie.svg" title="Mealie"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-sillytavern.svg" title="SillyTavern"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-mediawiki.svg" title="MediaWiki"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-audiobookshelf.svg" title="Audiobookshelf"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-searxng.svg" title="SearXNG"/>
</p>

### Stack Utilities
<p align="center">
<img width="50px" height="50px" src=".github/assets/icons/sh-deunhealth.svg" title="DeUnhealth"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-watchtower.svg" title="Watchtower"/>
<img width="50px" height="50px" src=".github/assets/icons/sh-nginx-pm.svg" title="Nginx Proxy Manager"/>
</p>

## Installation
This stack is designed to be cloned to `home/user/docker` and be run from there. This is adjustable in the `.env` and `setup.sh` file.

Additionally, mounts at `/mnt/media` and `/mnt/cloud` are expected to be available, for media storage and cloud storage respectively. These can also be changed in the `.env` file.

Getting started

1. Clone the repo to your preferred location (examples assume `/home/user/docker`):

```bash
git clone --recurse-submodules https://github.com/Furglitch/docker-stack.git /home/user/docker
cd /home/user/docker
```

#### Quick Setup Script

```bash
./setup.sh [action] [compose]

action: --start | --restart | --stop | --clear
compose: media | web | all
```

- `--start`: runs `docker compose up -d` for the chosen compose file(s).
- `--restart`: runs `docker compose restart`.
- `--stop`: runs `docker compose stop`.
- `--clear`: runs `docker compose down`.

*Compose selection:*

- `media` — runs `compose-media/docker-compose.yaml` and copies `config-media/` into the target config folder.
- `web` — runs `compose-web/docker-compose.yaml` and copies `config-web/` into the target config folder.
- `all` — runs both compose files and copies both `config-media/` and `config-web/`.
- `compose-util/docker-compose.yaml` is always used by the script for utility containers.

*Examples:*

```bash
./setup.sh --start web       # Starts web stack only
./setup.sh --restart all     # Restarts all containers
./setup.sh --stop media      # Stops media stack only
./setup.sh --clear web       # Removes web stack
```

#### Update Script

```bash
./scripts/update.sh
```

This script pulls from the git repository without overwriting local changes in files that do not appear in those commits. (i.e. it will not overwrite `.env` unless there is a change on the remote repository.)

*Files you may need to edit after running update.sh:*

| App   | Path | Notes |
|-------|------|-------|
| `.env` | [.env](./.env) | Update local IP and public domain, SQL DB credentials, and Gluetun credentials |
| Web `docker-compose.yaml` | [compose-web/docker-compose.yaml](./compose-web/docker-compose.yaml) | Re-enable MediaWiki LocalSettings.php |
| Recyclarr | [config-media/recyclarr/recyclarr.yml](./config-media/recyclarr/recyclarr.yml) | Update URLs and API keys |
| Homepage `services.yaml` | [config-web/homepage/services.yaml](./config-web/homepage/services.yaml) | Update URLs and API keys |
| Kometa `config.yml` | [config-media/kometa/config.yml](./config-media/kometa/config.yml) | Update URLs and API keys |