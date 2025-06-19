@echo off
if "%1"=="" (
    echo FSJQS 6v6 Build System - Windows
    echo ================================
    echo.
    echo Usage: build.bat [command] [options]
    echo.
    echo Commands:
    echo   help                    Show this help
    echo   build                   Compile without version change
    echo   patch                   Increment patch version and build
    echo   minor                   Increment minor version and build  
    echo   major                   Increment major version and build
    echo   version [VERSION]       Set custom version and build
    echo   clean                   Clean build artifacts
    echo   status                  Show project status
    echo.
    echo Examples:
    echo   build.bat build
    echo   build.bat patch
    echo   build.bat version 2.0.0
    echo.
    echo Note: Install 'make' for better experience: choco install make
    goto :eof
)

if "%1"=="help" (
    call %0
    goto :eof
)

if "%1"=="build" (
    echo Building project...
    node build.js
    goto :eof
)

if "%1"=="patch" (
    echo Incrementing patch version...
    for /f "tokens=*" %%i in ('npm version patch --no-git-tag-version') do set NEW_VERSION=%%i
    set NEW_VERSION=%NEW_VERSION:v=%
    echo Updated to version: %NEW_VERSION%
    node build.js %NEW_VERSION%
    goto :eof
)

if "%1"=="minor" (
    echo Incrementing minor version...
    for /f "tokens=*" %%i in ('npm version minor --no-git-tag-version') do set NEW_VERSION=%%i
    set NEW_VERSION=%NEW_VERSION:v=%
    echo Updated to version: %NEW_VERSION%
    node build.js %NEW_VERSION%
    goto :eof
)

if "%1"=="major" (
    echo Incrementing major version...
    for /f "tokens=*" %%i in ('npm version major --no-git-tag-version') do set NEW_VERSION=%%i
    set NEW_VERSION=%NEW_VERSION:v=%
    echo Updated to version: %NEW_VERSION%
    node build.js %NEW_VERSION%
    goto :eof
)

if "%1"=="version" (
    if "%2"=="" (
        echo Error: Please specify version. Example: build.bat version 1.2.3
        goto :eof
    )
    echo Setting version to %2...
    npm version %2 --no-git-tag-version >nul
    echo Updated to version: %2
    node build.js %2
    goto :eof
)

if "%1"=="clean" (
    echo Cleaning build artifacts...
    if exist workshop_code.txt del workshop_code.txt
    if exist output\workshop_code.txt del output\workshop_code.txt
    echo Clean complete
    goto :eof
)

if "%1"=="status" (
    echo Project Status
    echo ==============
    for /f "tokens=*" %%i in ('node -p "require('./package.json').version"') do set CURRENT_VERSION=%%i
    echo Current version: %CURRENT_VERSION%
    echo Build script: node build.js
    node --version
    npm --version
    if exist workshop_code.txt (
        echo Build output: workshop_code.txt ^(exists^)
    ) else (
        echo Build output: workshop_code.txt ^(missing^)
    )
    goto :eof
)

echo Unknown command: %1
echo Run 'build.bat help' for usage information
