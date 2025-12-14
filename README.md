# Furglitch's Docker Stack

A collection of docker compose files for deploying multiple services, such as Servarr related apps and other personal sites.

## Included Apps

### Media Services

| App            | Function                     |
|----------------|------------------------------|
| Plex           | Media server                 |
| Tautulli       | Plex usage monitoring        |
| Posterizarr    | Plex poster manager          |
| Tdarr          | Media transcoder             |
| Radarr         | Movie management             |
| Sonarr         | TV Show management           |
| Bazarr         | Subtitle management          |
| Prowlarr       | Download indexer             |
| FlareSolverr   | Captcha solver               |
| Recyclarr      | TRaSH Guide syncer           |
| Gluetun        | Container VPN router         |
| SABnzbd        | Usenet downloader            |
| qBittorrent    | Torrent downloader           |

### Web Services

| App            | Function                     |
|----------------|------------------------------|
| Homepage       | Home page / Sysmon           |
| VaultWarden    | Password manager             |
| Nextcloud      | Cloud storage                |
| Mealie         | Recipe management            |
| SillyTavern    | AI Chat front-end            |
| MediaWiki      | Wiki platform                |
| Audiobookshelf | Book/audiobook server        |

### Stack Utilities

| App            | Function                     |
|----------------|------------------------------|
| DeUnhealth     | Container status monitor     |
| Watchtower     | Image update monitor         |

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
| .env      | [/.env](/.env)                                                                     | Domain info, Secrets       |
| Recyclarr | [/config-media/recyclarr/recyclarr.yml](/config-media/recyclarr/recyclarr.yml)     | Domain info, Secrets       |
| Homepage  | [/config-web/homepage/services.yaml](/config-web/homepage/services.yaml)           | Ports, API Keys, Passkeys  |
| MediaWiki | [/config-web/mediawiki/LocalSettings.php](/config-web/mediawiki/LocalSettings.php) | Server URL, Secrets        |