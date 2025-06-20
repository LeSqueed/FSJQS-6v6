# FSJQS 6v6 Source Code Structure

This directory contains the structured source code for the FSJQS 6v6 project.

## Directory Structure

```
src/
├── constants/        # Game constants and configuration values
├── heroes/           # Hero-specific implementations
│   ├── [hero_name]/  # Each hero has its own directory
│   │   ├── init.opy  # Main entry point for the hero
│   │   └── *.opy     # Ability-specific implementations
│   └── init.opy      # Central point including all hero init files
├── passives/         # Passive abilities by role
├── utilities/        # Shared utility functions and systems
└── main_logic.opy    # Core game logic
```

## Coding Standards

### File Organization

1. **Hero Implementation**: 
   - Each hero has its own directory: `heroes/[hero_name]/`
   - Each hero directory contains an `init.opy` file that includes all ability files
   - Ability files are named descriptively (e.g., `punch.opy`, `uppercut.opy`)

2. **File Headers**:
   All files should include a header with:
   ```
   #=======================================================================
   # [COMPONENT NAME]
   #=======================================================================
   # Brief description of the file's purpose
   # Additional relevant information
   #=======================================================================
   ```

3. **Variable Definitions**:
   - Variables should be defined at the top of the file
   - Include comments explaining their purpose

### Code Style

1. **Comments**:
   - Major code sections should have section headers: `# ---- SECTION NAME ----`
   - Complex operations should have explanatory comments
   - Multi-line operations should have line-by-line comments

2. **Rule Naming**:
   - Rules should have descriptive names with the format: `"[file_path]: Description"`
   - Example: `"[doomfist/uppercut.opy]: Control flow for Uppercut"`

3. **Code Formatting**:
   - Use consistent indentation
   - Break long operations across multiple lines for readability
   - Use clear parameter naming in complex functions

## Adding New Heroes

1. Create a new directory under `src/heroes/` with the hero's name
2. Create an `init.opy` file that includes all ability files
3. Create individual files for each ability
4. Add the hero to `src/heroes/init.opy`

## Recommended Workflow

1. **Implementing a New Hero**:
   ```
   mkdir src/heroes/new_hero
   # Create init.opy and ability files
   # Add to src/heroes/init.opy
   ```

2. **Modifying an Existing Hero**:
   - Edit the relevant ability file in `src/heroes/[hero_name]/`
   - If adding a new ability, create a new file and include it in the hero's `init.opy`

## Building

The build system is designed to handle this structure automatically. The main entry point remains `main.opy` at the root level, which includes `src/main_logic.opy`.

```
make build    # Compile without changing version
make patch    # Increment patch version and build
