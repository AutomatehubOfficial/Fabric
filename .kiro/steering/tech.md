# Technology Stack

## Primary Language & Runtime
- **Go 1.24+** - Main application language
- **Node.js/TypeScript** - Web interface (SvelteKit)

## Build System & Package Management
- **Go Modules** - Go dependency management
- **Nix Flakes** - Reproducible development environment
- **pnpm** - Node.js package manager for web interface
- **Docker** - Containerization support

## Key Dependencies
### Go Backend
- `github.com/jessevdk/go-flags` - CLI argument parsing
- `github.com/gin-gonic/gin` - HTTP web framework
- `github.com/mattn/go-sqlite3` - Database
- AI vendor SDKs: OpenAI, Anthropic, Google, AWS Bedrock, Ollama

### Web Frontend (SvelteKit)
- **SvelteKit** - Full-stack web framework
- **TailwindCSS** - Styling
- **Skeleton UI** - Component library
- **Vite** - Build tool

## Common Commands

### Development
```bash
# Setup development environment
fabric --setup

# Run with Nix (recommended)
nix develop
nix run

# Build from source
go install github.com/danielmiessler/fabric/cmd/fabric@latest

# Web interface development
cd web && pnpm install && pnpm dev
```

### Testing & Building
```bash
# Run Go tests
go test ./...

# Build binary
go build -o fabric ./cmd/fabric

# Docker build
docker build -f scripts/docker/Dockerfile .

# Web build
cd web && pnpm build
```

### Pattern Management
```bash
# Update patterns
fabric --updatepatterns

# List patterns
fabric --listpatterns

# Use pattern
fabric --pattern summarize
```

## Architecture Notes
- Modular plugin system for AI vendors
- SQLite for local data storage
- Patterns stored as Markdown files
- RESTful API server mode available