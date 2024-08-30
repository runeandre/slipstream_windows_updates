@echo off 

echo ##################
echo #                #
echo # Update Windows #
echo #                #
echo ##################
echo.

echo.
echo Set power configuration to High Performance (we don't want Windows to sleep etc)
powercfg -s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

rem Find OS version so that we know what service packs have been installed.
systeminfo | findstr /B /C:"OS Version" > "%USERPROFILE%\temp.txt"
set /p version=<"%USERPROFILE%\temp.txt"

echo.
echo %version%

echo.
echo Close sysprep (Ignore errors about not found)
taskkill /f /im sysprep.exe

rem Install Service Pack 1
If NOT "%version%"=="%version:6000=%" (
    echo.
    echo Installing Service Pack 1
    START /WAIT D:\<service_pack_1_exe> /unattend /norestart
	
	echo.
	echo Reboot back into audit mode
    C:\Windows\System32\sysprep\sysprep.exe /audit /reboot
)

rem Install Service Pack 2
If NOT "%version%"=="%version:Service Pack 1=%" (
	echo.
	echo Service Pack 1 cleanup tool
	START /WAIT C:\Windows\System32\vsp1cln.exe /quiet

	echo.
	echo Installing Service Pack 2
	START /WAIT D:\<service_pack_2_exe> /unattend /norestart
	
	echo.
	echo Reboot back into audit mode
	C:\Windows\System32\sysprep\sysprep.exe /audit /reboot
)

rem Final cleanup, generalizing and shutdown.
If NOT "%version%"=="%version:Service Pack 2=%" (
	echo.
	echo Service Pack 2 cleanup tool
	START /WAIT C:\Windows\System32\compcln.exe /quiet
	
	echo.
	echo Delete temp script files
	del "%USERPROFILE%\temp.txt"
	cd "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"
	del "UpdateWindows.cmd"
	
	echo.
	echo Finished, now generalizing and shutting down!
	
	timeout 10
	
	C:\Windows\System32\sysprep\sysprep.exe /oobe /generalize /shutdown
)

echo.
echo Hmmmm! Something is wrong, it should not reach this part of the script!

timeout 600
