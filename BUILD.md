# Build System Documentation

This project uses a Makefile-based build system for easy compilation and version management.

## Prerequisites

- Node.js and npm (for the existing overpy compilation)
- `make` (macOS/Linux have it by default, Windows users see below)

### Windows Users

**Option 1: Install make**
```bash
# Using Chocolatey
choco install make

# Using Scoop  
scoop install make
```

**Option 2: Use the batch file**
```cmd
# Use build.bat instead of make commands
build.bat help
build.bat build
build.bat patch
```

## Quick Start

```bash
# Show available commands
make help

# Build without version change
make build

# Version management
make version-patch    # 1.16.9 → 1.16.10
make version-minor    # 1.16.9 → 1.17.0  
make version-major    # 1.16.9 → 2.0.0

# Custom version
make version-custom VERSION=2.1.0

# Project status
make status

# Clean build artifacts
make clean
```

## Version Management

The build system automatically keeps these files in sync:

1. **package.json** - `"version": "1.16.9"`
2. **lobby/lobby.opy** - `"modeName": "6v6 Adjustments + Realth 1.16.9"`

When you run any version command, both files are updated and the project is compiled.

## Build Process

1. **Version Update** (if specified)
   - Updates `package.json` version field
   - Updates mode name in `lobby/lobby.opy`

2. **Compilation**
   - Reads `main.opy` and all included files
   - Compiles using overpy
   - Outputs to `workshop_code.txt`

## Available Commands

| Command | Description | Example |
|---------|-------------|---------|
| `make help` | Show help and current version | - |
| `make build` | Compile without version change | - |
| `make version-patch` | Increment patch (1.2.3 → 1.2.4) | - |
| `make version-minor` | Increment minor (1.2.3 → 1.3.0) | - |
| `make version-major` | Increment major (1.2.3 → 2.0.0) | - |
| `make version-custom VERSION=X.Y.Z` | Set specific version | `make version-custom VERSION=2.0.0` |
| `make clean` | Remove build artifacts | - |
| `make status` | Show project status | - |
| `make install` | Install npm dependencies | - |

### Aliases

- `make patch` = `make version-patch`
- `make minor` = `make version-minor`  
- `make major` = `make version-major`

## Output Files

- **workshop_code.txt** - Main build output (Overwatch Workshop code)
- **output/workshop_code.txt** - Backup location (if it exists)

## Migration from Old System

**Before:**
```bash
node build.js                    # Build without version
node build.js 1.2.3             # Build with version
```

**Now:**
```bash
make build                       # Build without version
make version-custom VERSION=1.2.3   # Build with version
make version-patch               # Auto-increment and build
```

## Troubleshooting

### "make: command not found" on Windows
- Install make: `choco install make`
- Or use: `.\build.bat` instead of `make` commands
- Or use Git Bash (includes make)

### Version mismatch between files
- Run `make status` to check current state
- Use `make version-custom VERSION=X.Y.Z` to force sync

### Build fails
- Check `make status` for Node.js/npm versions
- Try `make clean` then `make build`
- Ensure overpy submodule is properly initialized

## Cross-Platform Compatibility

- **macOS/Linux**: Use `make` commands directly
- **Windows with make**: Use `make` commands  
- **Windows without make**: Use `build.bat` commands
- **Git Bash**: Supports `make` commands
- **WSL**: Supports `make` commands
