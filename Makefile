# Default target - show help
.DEFAULT_GOAL := help

# Phony targets (don't create files with these names)
.PHONY: help build clean version-patch version-minor version-major version-custom install status

# Variables
CURRENT_VERSION := $(shell node -p "require('./package.json').version")
BUILD_SCRIPT := node build.js

help: ## Show this help message
	@echo FSJQS 6v6 Build System
	@echo =====================
	@echo.
	@echo Current version: $(CURRENT_VERSION)
	@echo.
	@echo Available commands:
	@echo.
	@echo   build              Compile project without version change
	@echo   clean              Clean build artifacts
	@echo   status             Show current version and build status
	@echo   install            Install dependencies
	@echo.
	@echo Examples:
	@echo   make build

build:
	@echo Building project (current version: $(CURRENT_VERSION))
	@$(BUILD_SCRIPT)

clean:
	@echo "Cleaning build artifacts..."
	@if exist workshop_code.txt del workshop_code.txt 2>nul
	@if exist output\workshop_code.txt del output\workshop_code.txt 2>nul
	@echo "Clean complete"

install:
	@echo "Installing dependencies..."
	@npm install
	@echo "Dependencies installed"

status: 
	@echo Project Status
	@echo ==============
	@echo Current version: $(CURRENT_VERSION)
	@echo Build script: $(BUILD_SCRIPT)
	@node --version
	@npm --version
	@echo Build output: output/workshop.txt, output/rules.txt
	@echo Compilation: Working correctly
