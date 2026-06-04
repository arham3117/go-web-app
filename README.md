# Go Web Application

A simple **Learn DevOps** website written in Go. It uses only the standard
library (`net/http`) to serve a small multi-page static site — Home, Courses,
About, and Contact — styled with a single shared, responsive stylesheet.

## Project structure

```
go-web-app/
├── main.go                     # HTTP server: routes + static asset serving
├── main_test.go                # Tests for the home page handler
├── go.mod
└── static/
    ├── home.html               # Landing page
    ├── courses.html            # Course / tutorial catalog
    ├── about.html              # About the author
    ├── contact.html            # Contact / community links
    └── assets/
        └── css/
            └── style.css       # Shared stylesheet for every page
```

### How routing works

`main.go` registers one handler per page and serves the matching HTML file
from the `static/` folder:

| Route        | Serves                  |
|--------------|-------------------------|
| `/`          | redirects to `/home`    |
| `/home`      | `static/home.html`      |
| `/courses`   | `static/courses.html`   |
| `/about`     | `static/about.html`     |
| `/contact`   | `static/contact.html`   |
| `/assets/…`  | files under `static/assets/` (CSS, etc.) |

The shared stylesheet is served from `static/assets/` and referenced by each
page as `/assets/css/style.css`.

## Prerequisites

- [Go](https://go.dev/dl/) **1.22 or newer** (developed with Go 1.22.5).

Check your version:

```bash
go version
```

## Run locally

From the project root, start the server:

```bash
go run main.go
```

You'll see:

```
Server starting on http://localhost:8080
```

Open <http://localhost:8080> in your browser — it redirects to the home page.
You can also visit the pages directly:

- <http://localhost:8080/home>
- <http://localhost:8080/courses>
- <http://localhost:8080/about>
- <http://localhost:8080/contact>

> **Note:** run the server from the project root. The handlers load the HTML
> and CSS using relative paths (e.g. `static/home.html`), so the working
> directory must be the repository root.

## Build a binary

To compile a standalone executable:

```bash
go build -o go-web-app .
./go-web-app
```

The server listens on `0.0.0.0:8080`.

## Run the tests

```bash
go test ./...
```

This verifies the home page handler returns `200 OK` with an HTML content type.

## Run with Docker (optional)

If you prefer a container, build and run with the official Go image:

```bash
docker run --rm -p 8080:8080 -v "$PWD":/app -w /app golang:1.22 go run main.go
```

Then open <http://localhost:8080>.
