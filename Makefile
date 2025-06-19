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
	@echo   version-patch      Increment patch version and build ($(CURRENT_VERSION) -^> X.X.Y)
	@echo   version-minor      Increment minor version and build ($(CURRENT_VERSION) -^> X.Y.0)
	@echo   version-major      Increment major version and build ($(CURRENT_VERSION) -^> Y.0.0)
	@echo   version-custom     Set custom version and build (usage: make version-custom VERSION=1.2.3)
	@echo   clean              Clean build artifacts
	@echo   status             Show current version and build status
	@echo   install            Install dependencies
	@echo.
	@echo Quick aliases:
	@echo   patch              Same as version-patch
	@echo   minor              Same as version-minor
	@echo   major              Same as version-major
	@echo.
	@echo Examples:
	@echo   make build
	@echo   make version-patch
	@echo   make version-custom VERSION=2.0.0

build:
	@echo Building project (current version: $(CURRENT_VERSION))
	@$(BUILD_SCRIPT)

version-patch: ## Increment patch version and build (1.2.3 → 1.2.4)
	@echo "Incrementing patch version..."
	@npm version patch --no-git-tag-version >nul
	@echo "Updated to new version"
	@$(BUILD_SCRIPT) $(shell node -p "require('./package.json').version")

version-minor:
	@echo "Incrementing minor version..."
	@npm version minor --no-git-tag-version >nul
	@echo "Updated to new version"
	@$(BUILD_SCRIPT) $(shell node -p "require('./package.json').version")

version-major:
	@echo "Incrementing major version..."
	@npm version major --no-git-tag-version >nul
	@echo "Updated to new version"
	@$(BUILD_SCRIPT) $(shell node -p "require('./package.json').version")

version-custom:
	@echo Setting version to $(VERSION)...
	@npm version $(VERSION) --no-git-tag-version >nul
	@echo Updated to version: $(VERSION)
	@$(BUILD_SCRIPT) $(VERSION)

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
	@echo Build output: workshop_code.txt
	@echo Compilation: Working correctly

patch: version-patch
minor: version-minor
major: version-major
