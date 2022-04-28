@echo off
cd /d "%~dp0"

echo "Warning. This will restart your machine."
pause

wsl --install

shutdown /r