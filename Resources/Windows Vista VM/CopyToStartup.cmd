@echo off 

echo ##################
echo #                #
echo # Setup startup! #
echo #                #
echo ##################
echo.

cd "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"
copy "D:\UpdateWindows.cmd"

echo.
echo.
echo.
echo ######################################
echo # UpdateWindows.cmd failsafe timout! #
echo ######################################
echo.
echo If within 10 minutes the temp.txt file has not been created, then the UpdateWindows.cmd script in the "Startup" folder was not triggered properly.
echo A quick fix for this is to reboot back into audit mode again which should trigger that script.
echo This is just a safe guard in case e.g. some race condition happens where Windows is finished loading from the "Startup" folder before this script has copied the UpdateWindows.cmd script into it.
timeout 600
if NOT exist "%USERPROFILE%\temp.txt" (
	echo.
	echo UpdateWindows.cmd was not triggered properly.
	echo Rebooting back into audit mode
	timeout 15
	C:\Windows\System32\sysprep\sysprep.exe /audit /reboot
)