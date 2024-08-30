@echo off

rem Request to run as Admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

rem Update ExecutionPolicy in PowerShell
powershell -Command "Get-ExecutionPolicy -List"

echo Set ExecutionPolicy Unrestricted on all scopes.
powershell -Command "Set-ExecutionPolicy Unrestricted -Scope MachinePolicy"
powershell -Command "Set-ExecutionPolicy Unrestricted -Scope UserPolicy"
powershell -Command "Set-ExecutionPolicy Unrestricted -Scope Process"
powershell -Command "Set-ExecutionPolicy Unrestricted -Scope CurrentUser"
powershell -Command "Set-ExecutionPolicy Unrestricted -Scope LocalMachine"
echo Ignore the errors! (Probably)

powershell -Command "Get-ExecutionPolicy -List"

pause