# Project Structure

## Root Level Organization
- **`cmd/`** - Main application entry points and helper tools
- **`internal/`** - Private Go packages (core application logic)
- **`data/`** - Static data files (patterns, strategies)
- **`web/`** - SvelteKit web interface
- **`scripts/`** - Build scripts, Docker configs, utilities
- **`docs/`** - Documentation and images

## Core Application (`cmd/`)
```
cmd/
├── fabric/           # Main CLI application
├── code_helper/      # Code analysis helper tool
├── to_pdf/          # LaTeX to PDF converter
└── generate_changelog/ # Changelog generation tool
```

## Internal Architecture (`internal/`)
```
internal/
├── cli/             # CLI interface and flag handling
├── core/            # Core business logic and plugin registry
├── domain/          # Domain models and business entities
├── plugins/         # Plugin system (AI vendors, strategies, templates)
├── server/          # HTTP server and API endpoints
├── tools/           # Utility tools (YouTube, converters, etc.)
└── util/            # Common utilities
```

## Data Organization (`data/`)
```
data/
├── patterns/        # 200+ AI prompt patterns (Markdown files)
└── strategies/      # Prompt strategies (JSON configs)
```

## Pattern Structure
Each pattern is a folder containing:
- `system.md` - Main system prompt (required)
- `user.md` - User prompt template (optional)
- `README.md` - Pattern documentation (optional)

## Web Interface (`web/`)
```
web/
├── src/
│   ├── lib/         # Svelte components and utilities
│   └── routes/      # SvelteKit routes
├── static/          # Static assets
└── myfiles/         # User content directory
```

## Configuration Locations
- **User config**: `~/.config/fabric/`
- **Patterns**: `~/.config/fabric/patterns/`
- **Custom patterns**: User-defined directory
- **Environment**: `.env` files in config directory

## Key Conventions
- Go packages follow standard Go project layout
- Patterns use Markdown for maximum readability
- Plugin system allows modular AI vendor integration
- Web and CLI share the same backend core
- All user data stored in standard config directories