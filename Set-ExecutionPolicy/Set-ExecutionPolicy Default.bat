@echo off

rem Request to run as Admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

rem Update ExecutionPolicy in PowerShell
powershell -Command "Get-ExecutionPolicy -List"

echo Set ExecutionPolicy Unrestricted.
powershell -Command "Set-ExecutionPolicy Default"
echo Ignore the errors! (Probably)

powershell -Command "Get-ExecutionPolicy -List"

pause