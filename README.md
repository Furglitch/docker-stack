# Furglitch's Docker Stack (Game Branch)

A collection of docker compose files for deploying game servers.

## Included Apps

| App            | Function                     |
|----------------|------------------------------|
| Pterodactyl     | Game server management       |

## Installation

This stack is designed to be cloned to `/home/user/docker` and run from there.
```bash
git clone https://github.com/Furglitch/docker-stack.git -b docker-game /home/user/docker
```

#### Prerequisites

You will need to create the 'pterodactyl' and 'pterodactyl_nw' networks first:
```bash
docker network create pterodactyl pterodactyl_nw
```

#### Usage

It's recommended to follow the instructions by EdyTheCow, starting at '[Setting up Panel](https://github.com/EdyTheCow/docker-pterodactyl/tree/master?tab=readme-ov-file#setting-up-panel)', as this stack doesn't contain traefik.

Instead of using `docker compose` commands directly, you can use the provided `setup.sh` script:

```bash
./setup.sh [action] [compose]

action: --start | --restart | --stop | --clear
compose: panel | wings
```

- `--start`: runs `docker compose up -d` for the specified compose file.
- `--restart`: runs `docker compose restart` for the specified compose file.
- `--stop`: runs `docker compose stop` for the specified compose file.
- `--clear`: runs `docker compose down` for the specified compose file.

---

<sub>Based on [EdyTheCow/docker-pterodactyl](https://github.com/EdyTheCow/docker-pterodactyl)</sub>