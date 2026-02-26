@echo off
setlocal EnableDelayedExpansion

if defined PROCESSOR_ARCHITEW6432 (
    set "OS_ARCH=x64"
) else (
    if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
        set "OS_ARCH=x64"
    ) else (
        set "OS_ARCH=x86"
    )
)

set "BASE_DIR=%~dp0"
if "%BASE_DIR:~-1%"=="\" set "BASE_DIR=%BASE_DIR:~0,-1%"

if "%OS_ARCH%"=="x64" (
    set "NSSM=%BASE_DIR%\bin\x64\nssm.exe"
) else (
    set "NSSM=%BASE_DIR%\bin\x86\nssm.exe"
)

if exist "%NSSM%" (
    echo Running: %NSSM%
    "%NSSM%" remove MT5Service confirm

) else (
    echo ERROR: NSSM not found:
    echo %NSSM%
)

