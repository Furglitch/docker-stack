# Furglitch's Docker Stack

A collection of docker compose files for deploying multiple services, such as Servarr related apps and other personal sites.


## Included Apps

### Media Services

| App            | Function                     |
|----------------|------------------------------|
| Plex           | Media server                 |
| Audiobookshelf | Book/audiobook server        |
| Sonarr         | TV Show management           |
| Radarr         | Movie management             |
| Bazarr         | Subtitle management          |
| Jellyseerr     | Media request management     |
| Tautulli       | Plex usage monitoring        |
| Kometa         | Plex metadata management     |

### Download Services

| App            | Function                     |
|----------------|------------------------------|
| SABnzbd        | Usenet downloader            |
| qBittorrent    | Torrent downloader           |
| Prowlarr       | Download indexer             |
| FlareSolverr   | Captcha solver               |

### Web Services

| App            | Function                     |
|----------------|------------------------------|
| nginx-pm       | Webhosting manager           |
| Homepage       | Home page / Sysmon           |
| VaultWarden    | Password manager             |
| Nextcloud      | Cloud storage                |
| Mealie         | Recipe management            |
| MediaWiki      | Wiki platform                |
| SillyTavern    | Chat front-end               |

### Stack Utilities

| App            | Function                     |
|----------------|------------------------------|
| Gluetun        | VPN client                   |
| DeUnhealth     | Container status monitor     |
| Watchtower     | Image update monitor         |

## Installation

The repo is meant to be installed within `/mnt/hoard`, allowing the included configuration files to take effect seamlessly.<br/>
If you wish to change the location, modify the `.env` file and `start.sh` script, then adjust the below installation commands as needed.

1. Clone the repository into /mnt/hoard:
	 ```bash
	 git clone https://github.com/furglitch/docker-stack.git /mnt/hoard
	 ```

2. Navigate to the project directory:
	 ```bash
	 cd /mnt/hoard
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

### Files that may need adjusting on install/updates

| App      | Path                           | Changes                   |
|----------|--------------------------------|---------------------------|
| .env     | /docker-compose/.env           | IP, Domain, Secrets       |
| Homepage | /config/homepage/services.yaml | Ports, API Keys, Passkeys |
| Kometa   | /config/kometa/config.yml      | Ports, API Keys           |

---

### Attribution
This repository's file structure and scripts were inspired by [thatg33khub/docker-compose-samples](https://github.com/thatg33khub/docker-compose-samples).
