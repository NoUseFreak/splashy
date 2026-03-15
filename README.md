<p align="center">
  <span style="font-size:64px"><b>
    <span style="color:#1e66f5">S</span><span style="color:#8839ef">p</span><span style="color:#ea76cb">l</span><span style="color:#fe640b">a</span><span style="color:#40a02b">s</span><span style="color:#7287fd">h</span><span style="color:#1e66f5">y</span>
  </b></span>
</p>

<p align="center">
  A clean start page with a configurable link inventory.
</p>

<p align="center">
  <a href="https://github.com/NoUseFreak/splashy/actions/workflows/publish.yml"><img src="https://github.com/NoUseFreak/splashy/actions/workflows/publish.yml/badge.svg" alt="Build"></a>
  <a href="https://github.com/NoUseFreak/splashy/pkgs/container/splashy"><img src="https://img.shields.io/badge/ghcr.io-splashy-blue?logo=docker&logoColor=white" alt="Docker"></a>
  <a href="https://github.com/NoUseFreak/splashy/pkgs/container/charts%2Fsplashy"><img src="https://img.shields.io/badge/Helm-chart-0f1689?logo=helm&logoColor=white" alt="Helm Chart"></a>
  <a href="https://github.com/NoUseFreak/splashy/releases/latest"><img src="https://img.shields.io/github/v/release/NoUseFreak/splashy?color=green&logo=github" alt="Release"></a>
  <a href="https://github.com/NoUseFreak/splashy/blob/main/LICENSE"><img src="https://img.shields.io/github/license/NoUseFreak/splashy" alt="License"></a>
</p>

---

## Features

- **Search box** — type and hit Enter to search with your preferred engine
- **Search engine choice** — pick from Google, Bing, DuckDuckGo, Brave, Ecosia, Startpage, or set a custom URL
- **Link suggestions** — autocomplete from a YAML-defined link inventory as you type
- **Keyboard navigation** — arrow keys to select suggestions, Enter to go, Escape to dismiss
- **Category grid** — all links displayed below the search box, grouped by category
- **Settings modal** — cog icon to choose search engine and show/hide categories, persisted in localStorage
- **Custom title & logo** — set a page title or image URL in `links.yaml`
- **Dark mode** — automatic, follows your OS preference
- **Static site** — no backend, just HTML + JS + a YAML file
- **Tiny Docker image** — Caddy on Alpine, under 50MB

## Quick Start

### Static file server

```bash
python3 -m http.server 8080
```

### Docker

```bash
docker run -p 8080:8080 ghcr.io/nousefreak/splashy:latest
```

Mount a custom link inventory:

```bash
docker run -p 8080:8080 -v ./links.yaml:/srv/links.yaml ghcr.io/nousefreak/splashy:latest
```

### Helm

```bash
helm install splashy oci://ghcr.io/nousefreak/charts/splashy
```

With custom links:

```bash
helm install splashy oci://ghcr.io/nousefreak/charts/splashy -f my-values.yaml
```

## Configuration

All configuration lives in `links.yaml`:

```yaml
title: My Start Page
# image: https://example.com/logo.png
# footer: My custom footer text
# editUrl: https://github.com/you/your-repo/edit/main/links.yaml

categories:
  - name: Work
    links:
      - title: Gmail
        url: https://mail.google.com
      - title: GitHub
        url: https://github.com

  - name: Dev
    links:
      - title: Stack Overflow
        url: https://stackoverflow.com
```

| Field                        | Description                                                |
| ---------------------------- | ---------------------------------------------------------- |
| `title`                      | Page title shown as a colorful logo and in the browser tab |
| `image`                      | Optional image URL that replaces the text logo             |
| `footer`                     | Optional footer text (defaults to "Splashy — your start page") |
| `editUrl`                    | Optional URL to edit `links.yaml` (shows "Missing a link?" in footer) |
| `categories[].name`          | Category heading                                           |
| `categories[].links[].title` | Display name for the link                                  |
| `categories[].links[].url`   | Target URL                                                 |

### Helm values

The `links` key in `values.yaml` accepts the full `links.yaml` content:

```yaml
links: |
  title: My Team Dashboard
  categories:
    - name: Internal
      links:
        - title: Wiki
          url: https://wiki.internal
```

See [`chart/splashy/values.yaml`](chart/splashy/values.yaml) for all available options including ingress, resources, and
replica count.

## Project Structure

```
.
├── index.html                  # Single-page app (HTML + CSS + JS)
├── links.yaml                  # Link inventory
├── Caddyfile                   # Web server config
├── Dockerfile                  # Container image
├── .dockerignore
├── .github/workflows/
│   └── publish.yml             # CI: Docker image + Helm chart
└── chart/splashy/              # Helm chart
    ├── Chart.yaml
    ├── values.yaml
    └── templates/
        ├── deployment.yaml
        ├── configmap.yaml
        ├── service.yaml
        ├── ingress.yaml
        └── NOTES.txt
```

## License

See [LICENSE](LICENSE) for details.
