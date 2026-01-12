# Furglitch's Docker Stack

A collection of docker compose files for deploying multiple services, such as Servarr related apps and other personal sites.

## Included Apps

### Media Services
<p>
<img width="80px" height="80px" src=".github/assets/icons/sh-plex.svg" title="Plex"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-tautulli.svg" title="Tautulli"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-posterizarr.svg" title="Posterizarr"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-tdarr.svg" title="Tdarr"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-radarr.svg" title="Radarr"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-sonarr.svg" title="Sonarr"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-bazarr.svg" title="Bazarr"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-prowlarr.svg" title="Prowlarr"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-flaresolverr.svg" title="FlareSolverr"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-recyclarr.svg" title="Recyclarr"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-gluetun.svg" title="Gluetun"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-sabnzbd.svg" title="SABnzbd"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-qbittorrent.svg" title="qBittorrent"/>
</p>

### Web Services

<p>
<img width="80px" height="80px" src=".github/assets/icons/sh-homepage.svg" title="Homepage"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-vaultwarden.svg" title="VaultWarden"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-nextcloud.svg" title="Nextcloud"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-mealie.svg" title="Mealie"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-sillytavern.svg" title="SillyTavern"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-mediawiki.svg" title="MediaWiki"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-audiobookshelf.svg" title="Audiobookshelf"/>
</p>

### Stack Utilities

<p>
<img width="80px" height="80px" src=".github/assets/icons/sh-deunhealth.svg" title="DeUnhealth"/>
<img width="80px" height="80px" src=".github/assets/icons/sh-watchtower.svg" title="Watchtower"/>
</p>

## Installation

This stack is designed to be cloned to `/home/user/docker` and run from there.
```bash
git clone --recurse-submodules https://github.com/Furglitch/docker-stack.git /home/user/docker
```
Additionally, SMB shares are expected to be mounted at `/mnt/media` and `/mnt/cloud`, for Plex media and Nextcloud cloud storage respectively.


#### Usage

```bash
./setup.sh [action] [compose]

action: --start | --restart | --stop | --clear
compose: media | web | all
```

- `--start`: runs `docker compose up -d` for the chosen compose file(s).
- `--restart`: runs `docker compose restart`.
- `--stop`: runs `docker compose stop`.
- `--clear`: runs `docker compose down`.

**Compose selection**
- `media` — runs `compose-media/docker-compose.yaml` and copies `config-media` into the target config folder.
- `web` — runs `compose-web/docker-compose.yaml` and copies `config-web` into the target config folder.
- `all` — runs both compose files and copies both `config-media` and `config-web`.
- The script also runs `compose-util/docker-compose.yaml` for all actions automatically.

**Examples**

```bash
./setup.sh --start web # Starts web stack only
./setup.sh --restart all # Restarts all containers
./setup.sh --stop media # Stops media stack only
./setup.sh --clear web # Deletes web stack only
```

### Files that may need adjusting on install/updates

| App       | Path                                                                               | Changes                    |
|-----------|------------------------------------------------------------------------------------|----------------------------|
| .env      | [.env](./.env)                                                                     | Update PUID/PGID, timezone |