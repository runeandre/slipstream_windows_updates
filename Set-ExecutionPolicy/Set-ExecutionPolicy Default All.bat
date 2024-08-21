@echo off

rem Request to run as Admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

rem Update ExecutionPolicy in PowerShell
powershell -Command "Get-ExecutionPolicy -List"

echo Set ExecutionPolicy Default on all scopes.
powershell -Command "Set-ExecutionPolicy Default -Scope MachinePolicy"
powershell -Command "Set-ExecutionPolicy Default -Scope UserPolicy"
powershell -Command "Set-ExecutionPolicy Default -Scope Process"
powershell -Command "Set-ExecutionPolicy Default -Scope CurrentUser"
powershell -Command "Set-ExecutionPolicy Default -Scope LocalMachine"
echo Ignore the errors! (Probably)

powershell -Command "Get-ExecutionPolicy -List"

pause