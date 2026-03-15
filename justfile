# Run locally with Caddy on port 8080
dev:
    caddy file-server --listen :8080 --root .

# Build Docker image
build:
    docker build -t splashy .

# Run Docker image on port 8080
run: build
    docker run --rm -p 8080:8080 splashy
