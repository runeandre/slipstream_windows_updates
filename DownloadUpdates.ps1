Write-Host "######################################################"
Write-Host "#                                                    #"
Write-Host "# Download Windows Updates #"
Write-Host "#                                                    #"
Write-Host "######################################################"
Write-Host " "

Write-Host "Current directory: $($PWD)"
Write-Host " "

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
Write-Host " "

################
### Settings ###
################
$windows = "$($env:windows)"
$windows7_x86 = "windows7x86"
$windows7_x64 = "windows7x64"

# Windows 7
$folder_cwd_windows7 = "$($PWD)\Windows 7"
$folder_cwd_windows7_updates = "$($folder_cwd_windows7)\Updates"
$folder_cwd_windows7_sp1 = "$($folder_cwd_windows7)\Service Pack 1"
$folder_cwd_windows7_ie11 = "$($folder_cwd_windows7)\Internet Explorer 11"


if ($windows -eq $windows7_x86) {
	Write-Host " "
	Write-Host "Download Windows 7 x86 Updates"
	if(Test-Path -Path "$folder_cwd_windows7"){
		$folder_cwd_windows7_new_name = "$($folder_cwd_windows7)_$(([TimeSpan] (Get-Date).ToLongTimeString()).TotalMilliseconds)"
		
		Write-Host " "
		Write-Host "The folder ""$folder_cwd_windows7"" already exists!"
		Write-Host "Renaming it from ""$folder_cwd_windows7"" to ""$($folder_cwd_windows7_new_name)""."
		
		Rename-Item -Path "$folder_cwd_windows7" -NewName "$($folder_cwd_windows7_new_name)"

		mkdir "$($folder_cwd_windows7)"
	}else{
		mkdir "$($folder_cwd_windows7)"
	}
	
	if(-Not (Test-Path -Path "$folder_cwd_windows7_updates")){
		mkdir "$($folder_cwd_windows7_updates)"
		
		mkdir "$($folder_cwd_windows7_updates)\01"
		mkdir "$($folder_cwd_windows7_updates)\02"
		mkdir "$($folder_cwd_windows7_updates)\03"
		mkdir "$($folder_cwd_windows7_updates)\04"
		mkdir "$($folder_cwd_windows7_updates)\05"
		mkdir "$($folder_cwd_windows7_updates)\06"
		mkdir "$($folder_cwd_windows7_updates)\07"
		mkdir "$($folder_cwd_windows7_updates)\08"
		mkdir "$($folder_cwd_windows7_updates)\09"
		mkdir "$($folder_cwd_windows7_updates)\10"
	}
	
	if(-Not (Test-Path -Path "$folder_cwd_windows7_sp1")){
		mkdir "$($folder_cwd_windows7_sp1)"
	}
	
	if(-Not (Test-Path -Path "$folder_cwd_windows7_ie11")){
		mkdir "$($folder_cwd_windows7_ie11)"
	}
	
	#SP1
	Write-Host "Download Service Pack 1"
	Invoke-WebRequest "http://download.windowsupdate.com/msdownload/update/software/crup/2011/05/windows6.1-kb2533552-x86_f2061d1c40b34f88efbe55adf6803d278aa67064.msu" -OutFile "$($folder_cwd_windows7_sp1)\windows6.1-kb2533552-x86_f2061d1c40b34f88efbe55adf6803d278aa67064.msu"
	Invoke-WebRequest "http://download.windowsupdate.com/msdownload/update/software/svpk/2011/02/windows6.1-kb976932-x86_c3516bc5c9e69fee6d9ac4f981f5b95977a8a2fa.exe" -OutFile "$($folder_cwd_windows7_sp1)\windows6.1-kb976932-x86_c3516bc5c9e69fee6d9ac4f981f5b95977a8a2fa.exe"
	
	# Post SP1 Updates
	Write-Host "Download Post Service Pack 1 updates"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2015/04/windows6.1-kb3020369-x86_82e168117c23f7c479a97ee96c82af788d07452e.msu" -OutFile "$($folder_cwd_windows7_updates)\01\windows6.1-kb3020369-x86_82e168117c23f7c479a97ee96c82af788d07452e.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2016/05/windows6.1-kb3125574-v4-x86_ba1ff5537312561795cc04db0b02fbb0a74b2cbd.msu" -OutFile "$($folder_cwd_windows7_updates)\02\windows6.1-kb3125574-v4-x86_ba1ff5537312561795cc04db0b02fbb0a74b2cbd.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/03/windows6.1-kb4490628-x86_3cdb3df55b9cd7ef7fcb24fc4e237ea287ad0992.msu" -OutFile "$($folder_cwd_windows7_updates)\03\windows6.1-kb4490628-x86_3cdb3df55b9cd7ef7fcb24fc4e237ea287ad0992.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/09/windows6.1-kb4474419-v3-x86_0f687d50402790f340087c576886501b3223bec6.msu" -OutFile "$($folder_cwd_windows7_updates)\04\windows6.1-kb4474419-v3-x86_0f687d50402790f340087c576886501b3223bec6.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/09/windows6.1-kb4516655-x86_47655670362e023aa10ab856a3bda90aabeacfe6.msu" -OutFile "$($folder_cwd_windows7_updates)\05\windows6.1-kb4516655-x86_47655670362e023aa10ab856a3bda90aabeacfe6.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2019/09/windows6.1-kb4516065-x86_662c716c417149d39d5787b1ff849bf7e5c786c3.msu" -OutFile "$($folder_cwd_windows7_updates)\06\windows6.1-kb4516065-x86_662c716c417149d39d5787b1ff849bf7e5c786c3.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2019/10/windows6.1-kb4524157-x86_422970e6ce3ab31cb101e1b8bc38294b4d2ebee2.msu" -OutFile "$($folder_cwd_windows7_updates)\07\windows6.1-kb4524157-x86_422970e6ce3ab31cb101e1b8bc38294b4d2ebee2.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2020/01/windows6.1-kb4536952-x86_f3b49481187651f64f13a0369c86ad7caa83b190.msu" -OutFile "$($folder_cwd_windows7_updates)\08\windows6.1-kb4536952-x86_f3b49481187651f64f13a0369c86ad7caa83b190.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2020/01/windows6.1-kb4534310-x86_887a5caab59437e8f23aa5a4608950455bb37537.msu" -OutFile "$($folder_cwd_windows7_updates)\09\windows6.1-kb4534310-x86_887a5caab59437e8f23aa5a4608950455bb37537.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2020/01/windows6.1-kb4539601-x86_89f30861c9a5d65b68ed1e029a68cf59be39fc13.msu" -OutFile "$($folder_cwd_windows7_updates)\10\windows6.1-kb4539601-x86_89f30861c9a5d65b68ed1e029a68cf59be39fc13.msu"
	
	#IE11
	Write-Host "Download Internet Explorer 11"
	Invoke-WebRequest "http://download.microsoft.com/download/9/2/F/92FC119C-3BCD-476C-B425-038A39625558/IE11-Windows6.1-x86-en-us.exe" -OutFile "$($folder_cwd_windows7_ie11)\IE11-Windows6.1-x86-en-us.exe"
	Invoke-WebRequest "https://download.microsoft.com/download/b/6/b/b6bf1d9b-2568-406b-88e8-e4a218dea90a/windows6.1-kb2729094-v2-x86.msu" -OutFile "$($folder_cwd_windows7_ie11)\windows6.1-kb2729094-v2-x86.msu"
	Invoke-WebRequest "https://download.microsoft.com/download/a/0/b/a0ba0a59-1f11-4736-91c0-dfcb06224d99/windows6.1-kb2731771-x86.msu" -OutFile "$($folder_cwd_windows7_ie11)\windows6.1-kb2731771-x86.msu"
	Invoke-WebRequest "https://download.microsoft.com/download/C/9/6/C96CD606-3E05-4E1C-B201-51211AE80B1E/Windows6.1-KB3063858-x86.msu" -OutFile "$($folder_cwd_windows7_ie11)\Windows6.1-KB3063858-x86.msu"
	Invoke-WebRequest "https://download.microsoft.com/download/1/4/9/14936fe9-4d16-4019-a093-5e00182609eb/windows6.1-kb2670838-x86.msu" -OutFile "$($folder_cwd_windows7_ie11)\windows6.1-kb2670838-x86.msu"
	Invoke-WebRequest "https://download.microsoft.com/download/4/8/1/481c640e-d3ee-4adc-aa48-6d0ed2869d37/windows6.1-kb2786081-x86.msu" -OutFile "$($folder_cwd_windows7_ie11)\windows6.1-kb2786081-x86.msu"
	Invoke-WebRequest "https://download.microsoft.com/download/f/1/4/f1424ad7-f754-4b6e-b0da-151c7cbae859/windows6.1-kb2834140-v2-x86.msu" -OutFile "$($folder_cwd_windows7_ie11)\windows6.1-kb2834140-v2-x86.msu"
	Invoke-WebRequest "https://download.microsoft.com/download/3/9/d/39d85ca8-7bf3-47c1-9031-fd6e51d8bbeb/windows6.1-kb2888049-x86.msu" -OutFile "$($folder_cwd_windows7_ie11)\windows6.1-kb2888049-x86.msu"
	Invoke-WebRequest "https://download.microsoft.com/download/7/c/e/7ce5d2a0-3a08-427e-9aa9-8a79e47b87b9/windows6.1-kb2882822-x86.msu" -OutFile "$($folder_cwd_windows7_ie11)\windows6.1-kb2882822-x86.msu"
} elseif ($windows -eq $windows7_x64) {
	Write-Host " "
	Write-Host "Download Windows 7 x64 Updates"
	if(-Not (Test-Path -Path "$folder_cwd_windows7")){
		mkdir "$($folder_cwd_windows7)"
	}
	if(-Not (Test-Path -Path "$folder_cwd_windows7_updates")){
		mkdir "$($folder_cwd_windows7_updates)"
	}
	if(-Not (Test-Path -Path "$folder_cwd_windows7_sp1")){
		mkdir "$($folder_cwd_windows7_sp1)"
	}
	if(-Not (Test-Path -Path "$folder_cwd_windows7_ie11")){
		mkdir "$($folder_cwd_windows7_ie11)"
	}
	
	#SP1
	Write-Host "Download Service Pack 1"
	Invoke-WebRequest "http://download.windowsupdate.com/msdownload/update/software/crup/2011/05/windows6.1-kb2533552-x64_0ba5ac38d4e1c9588a1e53ad390d23c1e4ecd04d.msu" -OutFile "$($folder_cwd_windows7_sp1)\windows6.1-kb2533552-x64_0ba5ac38d4e1c9588a1e53ad390d23c1e4ecd04d.msu"
	Invoke-WebRequest "http://download.windowsupdate.com/msdownload/update/software/svpk/2011/02/windows6.1-kb976932-x64_74865ef2562006e51d7f9333b4a8d45b7a749dab.exe" -OutFile "$($folder_cwd_windows7_sp1)\windows6.1-kb976932-x64_74865ef2562006e51d7f9333b4a8d45b7a749dab.exe"
	
	# Post SP1 Updates
	Write-Host "Download Post Service Pack 1 updates"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2015/04/windows6.1-kb3020369-x64_5393066469758e619f21731fc31ff2d109595445.msu" -OutFile "$($folder_cwd_windows7_updates)\01\windows6.1-kb3020369-x64_5393066469758e619f21731fc31ff2d109595445.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2016/05/windows6.1-kb3125574-v4-x64_2dafb1d203c8964239af3048b5dd4b1264cd93b9.msu" -OutFile "$($folder_cwd_windows7_updates)\02\windows6.1-kb3125574-v4-x64_2dafb1d203c8964239af3048b5dd4b1264cd93b9.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/03/windows6.1-kb4490628-x64_d3de52d6987f7c8bdc2c015dca69eac96047c76e.msu" -OutFile "$($folder_cwd_windows7_updates)\03\windows6.1-kb4490628-x64_d3de52d6987f7c8bdc2c015dca69eac96047c76e.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/09/windows6.1-kb4474419-v3-x64_b5614c6cea5cb4e198717789633dca16308ef79c.msu" -OutFile "$($folder_cwd_windows7_updates)\04\windows6.1-kb4474419-v3-x64_b5614c6cea5cb4e198717789633dca16308ef79c.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/09/windows6.1-kb4516655-x64_8acf6b3aeb8ebb79973f034c39a9887c9f7df812.msu" -OutFile "$($folder_cwd_windows7_updates)\05\windows6.1-kb4516655-x64_8acf6b3aeb8ebb79973f034c39a9887c9f7df812.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2019/09/windows6.1-kb4516065-x64_40a6dff87423268e55a909d40a310ac66386be0d.msu" -OutFile "$($folder_cwd_windows7_updates)\06\windows6.1-kb4516065-x64_40a6dff87423268e55a909d40a310ac66386be0d.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2019/10/windows6.1-kb4524157-x64_0735a83d6d6849dc09c6bc430a8d0b1404b01dd3.msu" -OutFile "$($folder_cwd_windows7_updates)\07\windows6.1-kb4524157-x64_0735a83d6d6849dc09c6bc430a8d0b1404b01dd3.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2020/01/windows6.1-kb4536952-x64_87f81056110003107fa0e0ec35a3b600ef300a14.msu" -OutFile "$($folder_cwd_windows7_updates)\08\windows6.1-kb4536952-x64_87f81056110003107fa0e0ec35a3b600ef300a14.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2020/01/windows6.1-kb4534310-x64_4dc78a6eeb14e2eac1ede7381f4a93658c8e2cdc.msu" -OutFile "$($folder_cwd_windows7_updates)\09\windows6.1-kb4534310-x64_4dc78a6eeb14e2eac1ede7381f4a93658c8e2cdc.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2020/01/windows6.1-kb4539601-x64_fb3f59fb0b1d3a4abf4a35230aa88a06996c4a4a.msu" -OutFile "$($folder_cwd_windows7_updates)\10\windows6.1-kb4539601-x64_fb3f59fb0b1d3a4abf4a35230aa88a06996c4a4a.msu"
	
	#IE11
	Write-Host "Download Internet Explorer 11"
	Invoke-WebRequest "http://download.microsoft.com/download/7/1/7/7179A150-F2D2-4502-9D70-4B59EA148EAA/IE11-Windows6.1-x64-en-us.exe" -OutFile "$($folder_cwd_windows7_ie11)\IE11-Windows6.1-x64-en-us.exe"
	Invoke-WebRequest "https://download.microsoft.com/download/6/c/a/6ca15546-a46c-4333-b405-ab18785abb66/windows6.1-kb2729094-v2-x64.msu" -OutFile "$($folder_cwd_windows7_ie11)\windows6.1-kb2729094-v2-x64.msu"
	Invoke-WebRequest "https://download.microsoft.com/download/9/f/e/9fe868f6-a0e1-4f46-96e5-87d7b6573356/windows6.1-kb2731771-x64.msu" -OutFile "$($folder_cwd_windows7_ie11)\windows6.1-kb2731771-x64.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/msdownload/update/software/updt/2011/06/windows6.0-kb2533623-x64_23652360b903754d42b6b969d9ae79462343f7d4.msu" -OutFile "$($folder_cwd_windows7_ie11)\windows6.0-kb2533623-x64_23652360b903754d42b6b969d9ae79462343f7d4.msu"
	Invoke-WebRequest "https://download.microsoft.com/download/1/4/9/14936fe9-4d16-4019-a093-5e00182609eb/windows6.1-kb2670838-x64.msu" -OutFile "$($folder_cwd_windows7_ie11)\windows6.1-kb2670838-x64.msu"
	Invoke-WebRequest "https://download.microsoft.com/download/1/8/f/18f9ae2c-4a10-417a-8408-c205420c22c3/windows6.1-kb2786081-x64.msu" -OutFile "$($folder_cwd_windows7_ie11)\windows6.1-kb2786081-x64.msu"
	Invoke-WebRequest "https://download.microsoft.com/download/5/a/5/5a548bfe-adc5-414b-b6bd-e1ec27a8dd80/windows6.1-kb2834140-v2-x64.msu" -OutFile "$($folder_cwd_windows7_ie11)\windows6.1-kb2834140-v2-x64.msu"
	Invoke-WebRequest "https://download.microsoft.com/download/4/1/3/41321d2e-2d08-4699-a635-d9828aadb177/windows6.1-kb2888049-x64.msu" -OutFile "$($folder_cwd_windows7_ie11)\windows6.1-kb2888049-x64.msu"
	Invoke-WebRequest "https://download.microsoft.com/download/6/1/4/6141bfd5-40fd-4148-a3c9-e355338a9ac8/windows6.1-kb2882822-x64.msu" -OutFile "$($folder_cwd_windows7_ie11)\windows6.1-kb2882822-x64.msu"
}

Write-Host " "
Write-Host "Finished!"
Write-Host " "

Exit