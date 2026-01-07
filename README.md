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

#### Usage

```bash
./setup.sh [action]

action: --start | --restart | --stop | --clear
```

- `--start`: runs `docker compose up -d` for the chosen compose file(s).
- `--restart`: runs `docker compose restart`.
- `--stop`: runs `docker compose stop`.
- `--clear`: runs `docker compose down`.