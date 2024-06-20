@echo off

rem Request to run as Admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

rem Set the current directory to be the one we run the scripts from
SET currentDir=%~dp0
cd /d %currentDir%

rem Add autounattend.xml to the ISO
rem set autounattend=true
rem Split the ISO file
rem set splitISO=true

rem Start the UpdateWindowsISO script in PowerShell
powershell -f UpdateWindowsISO.ps1

pause