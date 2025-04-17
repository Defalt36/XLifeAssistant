@echo off
cd /d %~dp0
wsl bash -c "source start && exec bash"
