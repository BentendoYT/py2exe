@echo off
title py2exe - Bentendo
chcp 65001 >nul

:: ===========================================================
::  py2exe - Simple Python to EXE Converter
::  Author : Bentendo
::  Version: 2.1
::  License: MIT
::  Description:
::      Batch interface for PyInstaller with enhanced options.
::
::		     github.com/BentendoYT
::
:: ===========================================================

:start
cls

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

if "%StartChoice%"=="1" (
    python -m PyInstaller --version >nul 2>&1
    if errorlevel 1 (
        echo.
        echo [!] PyInstaller is not installed!
        set /p install="Do you want to install it now? (y/n) >> "
        if /i "%install%"=="y" (
            echo.
            echo Installing PyInstaller...
            python -m pip install pyinstaller
            if errorlevel 1 (
                echo [!] Installation failed. Please install manually.
                pause
                goto start
            )
            echo [!] PyInstaller installed successfully.
            pause
        ) else (
            echo Exiting. PyInstaller is required to continue.
            pause
            exit
        )
    )
    goto Converter
)
if "%StartChoice%"=="2" exit

echo.
echo [!] Invalid input. [ "%StartChoice%" ] Please enter '1' or '2'.
pause
goto start


:Converter
cls
echo.
set /p file="Enter Python file (.py) >> "
if "%file%"=="" (
    echo [!] No file specified.
    pause
    goto start
)

set /p icon="Enter icon (.ico) [Leave blank for none] >> "
set /p removeConsole="Remove console window? (y/n) >> "

if "%removeConsole%"=="" (
    echo [!] No input given.
    pause
    goto start
)

if /i "%removeConsole%"=="y" (
    set removeConsoleOutput=no
) else (
    set removeConsoleOutput=yes
)

echo.
echo ═════════ Info ══════════
echo  File:     %file%
echo  Icon:     %icon%
echo  Console:  %removeConsoleOutput%
echo ═════════════════════════
echo.

set /p choice="Proceed? (y/n) >> "
if /i "%choice%"=="y" goto PyToExeConverter
if /i "%choice%"=="n" goto start

echo.
echo [!] Invalid input. [ "%choice%" ] Please enter 'y' or 'n'.
pause
goto start


:PyToExeConverter
cls
echo.
echo [^>] Starting conversion process...
echo.

if /i "%removeConsole%"=="y" (
    set consoleOption=--noconsole
) else (
    set consoleOption=
)

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
