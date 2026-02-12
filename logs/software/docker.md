# Docker Installation Log

## Installation Date
2026-02-12

## Installation Command
```bash
sudo apt-get install -y docker.io docker-compose
sudo systemctl start docker
sudo usermod -aG docker $USER
```

## Version
- Docker: 28.2.2
- Docker Compose: 1.29.2

## Important Commands
```bash
# Check Docker status
docker --version
docker-compose --version

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Run Docker without sudo (after logout/login)
docker run hello-world

# List containers
docker ps -a

# List images
docker images
```

## Notes
- Docker service is enabled and started
- User added to docker group
- Note: docker-compose v1 has Python 3.12 compatibility issues, consider using `docker compose` (v2) instead
