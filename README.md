# Furglitch's Docker Stack

A collection of docker compose files for deploying multiple services, such as Servarr related apps and other personal sites.

## Included Apps

| App           | Function                     |
|---------------|------------------------------|
| Plex          | Media server                 |
| Sonarr        | TV Show management           |
| Radarr        | Movie management             |
| Readarr       | Book management              |
| Bazarr        | Subtitle management          |
| Prowlarr      | Download indexer             |
| FlareSolverr  | Captcha solver               |
| Jellyseerr    | Media request management     |
| Tautulli      | Plex usage monitoring        |
| Kometa        | Plex metadata management     |
| Gluetun       | VPN client                   |
| SABnzbd       | Usenet downloader            |
| qBittorrent   | Torrent downloader           |
| nginx-pm      | Webhosting manager           |
| Glance        | System monitoring            |
| VaultWarden   | Password manager             |
| Nextcloud     | Cloud storage                |
| Mealie        | Recipe management            |
| SillyTavern   | Chat front-end               |
| MediaWiki     | Wiki platform                |

## Installation

The repo is meant to be installed within `/mnt/share`, allowing the included configuration files to take effect seamlessly.<br/>
If you wish to change the location, modify the `.env` file and `start.sh` script, then adjust the below installation commands as needed.

1. Clone the repository into /mnt/share:
   ```bash
   git clone https://github.com/furglitch/docker-stack.git /mnt/share
   ```

2. Navigate to the project directory:
   ```bash
   cd /mnt/share
   ```

3. Ensure Docker is installed and running on your system.

4. Run the startup script:
   ```bash
   ./start.sh
   ```

 5. To grab updates without affecting unchanged files, run the update script:
    ```bash
    ./update.sh
    ```
    This should help avoid conflicts like removing API keys for *arr apps, but double check commits before running the script.

### Attribution
This repository's file structure and scripts were inspired by [thatg33khub/docker-compose-samples](https://github.com/thatg33khub/docker-compose-samples).
