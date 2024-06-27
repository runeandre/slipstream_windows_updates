@echo off

rem Request to run as Admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

rem Set the current directory to be the one we run the scripts from
SET currentDir=%~dp0
cd /d %currentDir%

rem Split the ISO file
set windows=windows7x86

rem Start the DownloadUpdates script in PowerShell
powershell -f DownloadUpdates.ps1

pause