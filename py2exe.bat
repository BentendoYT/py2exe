@echo off
title py2exe - Bentendo
chcp 65001 >nul

:: ===========================================================
::  py2exe - Simple Python to EXE Converter
::  Author : Bentendo
::  Version: 2.3
::  License: MIT
::  Description:
::      Batch interface for PyInstaller with enhanced options.
::      Supports Drag & Drop.
::		     github.com/BentendoYT
:: ===========================================================

:: Prüfen, ob Datei per Drag & Drop übergeben wurde
if not "%~1"=="" (
    set "file=%~1"
    goto QuickConvert
)

:start
cls
color 0F

echo.
echo.
echo [38;2;0;255;255m██████╗ ██╗   ██╗    ██████╗     ███████╗██╗  ██╗███████╗
echo [38;2;30;220;255m██╔══██╗╚██╗ ██╔╝    ╚════██╗    ██╔════╝╚██╗██╔╝██╔════╝
echo [38;2;60;180;255m██████╔╝ ╚████╔╝      █████╔╝    █████╗   ╚███╔╝ █████╗  
echo [38;2;90;140;255m██╔═══╝   ╚██╔╝      ██╔═══╝     ██╔══╝   ██╔██╗ ██╔══╝  
echo [38;2;120;100;255m██║        ██║       ███████╗    ███████╗██╔╝ ██╗███████╗
echo [38;2;150;60;255m╚═╝        ╚═╝       ╚══════╝    ╚══════╝╚═╝  ╚═╝╚══════╝
echo.
echo.
echo    ╔════════════════════╗
echo    ║  COMMANDS:         ║
echo    ║                    ║
echo    ║  1. Start py2exe   ║
echo    ║  2. Exit           ║
echo    ╚════════════════════╝ 
echo.
echo.

set /p StartChoice=">> "

if "%StartChoice%"=="1" goto AskFile
if "%StartChoice%"=="2" exit

echo.
echo [!] Invalid input. Please enter '1' or '2'.
pause
goto start

:AskFile
cls
set /p file="Enter Python file (.py) >> "
if "%file%"=="" (
    echo [!] No file specified.
    pause
    goto start
)

:QuickConvert
if not exist "%file%" (
    echo [38;2;150;60;255m[!] File not found: %file%
    pause
    goto start
)

python -m PyInstaller --version >nul 2>&1
if errorlevel 1 (
    echo [38;2;150;60;255m[!] PyInstaller is not installed!
    goto AskInstall
)

:AskIcon
cls
set /p icon="[38;2;150;60;255mEnter icon (.ico) [Leave blank for none] >> "
set /p removeConsole="Remove console window? (y/n) >> "

if "%removeConsole%"=="" (
    echo [!] No input given.
    pause
    goto start
)

if /i "%removeConsole%"=="y" (
    set consoleOption=--noconsole
) else (
    set consoleOption=
)

echo.
echo ═════════ Info ══════════
echo  File:     %file%
echo  Icon:     %icon%
echo  Console:  %removeConsole%
echo ═════════════════════════
echo.

set /p choice="Proceed? (y/n) >> "
if /i "%choice%"=="n" goto start

cls
echo.
echo [^>] Starting conversion process...
echo.

if "%icon%"=="" (
    python -m PyInstaller -F %consoleOption% "%file%"
) else (
    python -m PyInstaller -F -i "%icon%" %consoleOption% "%file%"
)

echo.
echo [!] Conversion finished successfully.
echo [^>] Output is located in the "dist" folder.
echo.
pause
goto start

:AskInstall
set /p install="Do you want to install it now? (y/n) >> "
if /i "%install%"=="y" (
    cls
    echo Installing PyInstaller...
    python -m pip install --upgrade pip
    python -m pip install pyinstaller
    python -m PyInstaller --version >nul 2>&1
    if errorlevel 1 (
        echo [!] Installation failed. Please install manually.
        pause
        goto start
    )
    echo [38;2;150;60;255m[!] PyInstaller installed successfully.
    pause
    goto QuickConvert
) else (
    echo Exiting. PyInstaller is required to continue.
    pause
    exit
)
