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

if "%OS_ARCH%"=="x64" (
    set "TARGET_EXE=terminal64.exe"
) else (
    set "TARGET_EXE=terminal.exe"
)

for %%D in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if not defined FOUND_EXE (
        if exist "%%D:\" (
            
            if exist "%%D:\Program Files" (
                for /f "delims=" %%A in ('
                    where /r "%%D:\Program Files" terminal*.exe 2^>nul
                ') do (
                    set "FOUND_EXE=%%A"
                    for %%I in ("%%A") do set "FOUND_DIR=%%~dpI"
                    goto :FOUND
                )
            )
            
            if exist "%%D:\Program Files (x86)" (
                for /f "delims=" %%A in ('
                    where /r "%%D:\Program Files (x86)" terminal*.exe 2^>nul
                ') do (
                    set "FOUND_EXE=%%A"
                    for %%I in ("%%A") do set "FOUND_DIR=%%~dpI"
                    goto :FOUND
                )
            )

        )
    )
)

:FOUND

if defined FOUND_EXE (   
    echo Found:
    echo %FOUND_EXE%
) else (
    echo No terminal*.exe found in drives A-Z.
)

for /f "usebackq delims=" %%A in (`powershell -command "(Get-Item '%FOUND_EXE%').VersionInfo.FileDescription"`) do (   
    set "EXE_DESC=%%A"

    if /i "%%A"=="MetaTrader 5 Client Terminal" (
        echo Running: %NSSM%
        goto :MATCH_FOUND
    )
)

:MATCH_FOUND

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

