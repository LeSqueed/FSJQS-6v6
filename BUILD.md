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

# Build
make build

# Project status
make status

# Clean build artifacts
make clean
```

## Build Process

2. **Compilation**
   - Reads `main.opy` and all included files
   - Compiles using overpy
   - Outputs full workshop file with settings to `output/workshop.txt`
   - Outputs a separate file with just the rules to `output/rules.txt`

## Available Commands

| Command | Description | Example |
|---------|-------------|---------|
| `make help` | Show help and current version | - |
| `make build` | Compile without version change | - |
| `make clean` | Remove build artifacts | - |
| `make status` | Show project status | - |
| `make install` | Install npm dependencies | - |

## Output Files

- **output/workshop.txt** - Main build output (Overwatch Workshop code)
- **output/rules.txt** - Just the rules. Included because a full import tends to be finicky after various updates.

## Troubleshooting

### "make: command not found" on Windows
- Install make: `choco install make`
- Or use: `.\build.bat` instead of `make` commands
- Or use Git Bash (includes make)

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
