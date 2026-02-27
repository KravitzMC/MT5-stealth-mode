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

for /f "delims=" %%i in ('powershell -ExecutionPolicy Bypass -File "selectfile.ps1"') do set selectedFile=%%i

set "FOUND_EXE=%selectedFile%"

if not defined FOUND_EXE (
    exit /b
)

set "INI=%~dp0common.ini"

if exist "%NSSM%" (
    echo Running: %NSSM%
    "%NSSM%" install MT5Service  "%FOUND_EXE%"
    "%NSSM%" set MT5Service AppDirectory  "%FOUND_DIR%
    "%NSSM%" set MT5Service AppParameters /config:"%INI%"
    "%NSSM%" set MT5Service AppExit Default Restart
    "%NSSM%" set MT5Service DisplayName MT5Service
    "%NSSM%" set MT5Service ObjectName LocalSystem
    "%NSSM%" set MT5Service Start SERVICE_AUTO_START
    "%NSSM%" set MT5Service Type SERVICE_INTERACTIVE_PROCESS
    "%NSSM%" start MT5Service

) else (
    echo ERROR: NSSM not found:
    echo %NSSM%
)

