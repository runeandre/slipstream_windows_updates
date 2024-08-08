Write-Host "############################"
Write-Host "#                          #"
Write-Host "# Download Windows Updates #"
Write-Host "#                          #"
Write-Host "############################"
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
$windows7_x86_esu = "windows7x86_esu"
$windows7_x64_esu = "windows7x64_esu"

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
		mkdir "$($folder_cwd_windows7_updates)\11"
		mkdir "$($folder_cwd_windows7_updates)\12"
	}
	
	if(-Not (Test-Path -Path "$folder_cwd_windows7_sp1")){
		mkdir "$($folder_cwd_windows7_sp1)"
	}
	
	if(-Not (Test-Path -Path "$folder_cwd_windows7_ie11")){
		mkdir "$($folder_cwd_windows7_ie11)"
	}
	
	Write-Host " "
	Write-Host "#####################################"
	Write-Host "# Downloading Windows 7 x86 Updates #"
	Write-Host "#####################################"
	Write-Host " "
	
	#SP1
	Write-Host "Download Service Pack 1"
	Invoke-WebRequest "http://download.windowsupdate.com/msdownload/update/software/crup/2011/05/windows6.1-kb2533552-x86_f2061d1c40b34f88efbe55adf6803d278aa67064.msu" -OutFile "$($folder_cwd_windows7_sp1)\windows6.1-kb2533552-x86_f2061d1c40b34f88efbe55adf6803d278aa67064.msu"
	Invoke-WebRequest "http://download.windowsupdate.com/msdownload/update/software/svpk/2011/02/windows6.1-kb976932-x86_c3516bc5c9e69fee6d9ac4f981f5b95977a8a2fa.exe" -OutFile "$($folder_cwd_windows7_sp1)\windows6.1-kb976932-x86_c3516bc5c9e69fee6d9ac4f981f5b95977a8a2fa.exe"
	
	# Updates
	Write-Host "Download Updates"
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
	
	# Additional updates
	Write-Host "Download additional Updates"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2016/09/windows6.1-kb3172605-x86_ae03ccbd299e434ea2239f1ad86f164e5f4deeda.msu" -OutFile "$($folder_cwd_windows7_updates)\11\windows6.1-kb3172605-x86_ae03ccbd299e434ea2239f1ad86f164e5f4deeda.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/msdownload/update/software/crup/2011/06/windows6.1-kb2552343-x86_539c92fad1e6453d4970cdf3621ef4ec42dc2060.msu" -OutFile "$($folder_cwd_windows7_updates)\11\windows6.1-kb2552343-x86_539c92fad1e6453d4970cdf3621ef4ec42dc2060.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2020/02/windows6.1-kb4537829-x86_6043573e1ad978eacd304089604a36ad5ee92731.msu" -OutFile "$($folder_cwd_windows7_updates)\11\windows6.1-kb4537829-x86_6043573e1ad978eacd304089604a36ad5ee92731.msu"
	
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2013/11/windows6.1-kb2900986-x86_a993e450237ad5109c06691b47cea6aedb86642f.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb2900986-x86_a993e450237ad5109c06691b47cea6aedb86642f.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2013/12/windows6.1-kb2862330-v2-x86_a6f3c9b5811bd869cf6834acb96c4a0232588c9b.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb2862330-v2-x86_a6f3c9b5811bd869cf6834acb96c4a0232588c9b.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2013/12/windows6.1-kb2912390-x86_235cde723bac4de224ab94eda3931adf8a2ba986.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb2912390-x86_235cde723bac4de224ab94eda3931adf8a2ba986.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/msdownload/update/software/secu/2012/05/windows6.1-kb2667402-v2-x86_eec6812d9c6f710a6c1e640e8b928c99f215f39e.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb2667402-v2-x86_eec6812d9c6f710a6c1e640e8b928c99f215f39e.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/msdownload/update/software/secu/2012/06/windows6.1-kb2698365-x86_d9f8e37cc61ab4abce802c29fe20a8e270321373.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb2698365-x86_d9f8e37cc61ab4abce802c29fe20a8e270321373.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2014/10/windows6.1-kb2984972-x86_0447ea81b8cfafde3f7454721070c6d6599c58d7.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb2984972-x86_0447ea81b8cfafde3f7454721070c6d6599c58d7.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2015/02/windows6.1-kb3035126-x86_65e46b3d10323cee458b2ed8906b4395a3407e55.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3035126-x86_65e46b3d10323cee458b2ed8906b4395a3407e55.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2015/03/windows6.1-kb3046269-x86_dad279443dc5e3446bb2b478252c90d5f115faf1.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3046269-x86_dad279443dc5e3446bb2b478252c90d5f115faf1.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2015/01/windows6.1-kb3031432-x86_6ba33eba05ec8fe744e2786f6b72965d119274d8.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3031432-x86_6ba33eba05ec8fe744e2786f6b72965d119274d8.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2015/05/windows6.1-kb3059317-x86_7dbad42dd71389bb65948b81220fc019d77c8b77.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3059317-x86_7dbad42dd71389bb65948b81220fc019d77c8b77.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2015/12/windows6.1-kb3110329-x86_88310fe80c3ef4690ab91a89c7af2c6d3baff7a3.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3110329-x86_88310fe80c3ef4690ab91a89c7af2c6d3baff7a3.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2016/04/windows6.1-kb3156016-x86_ea2cf88a256d4138109847ddc5cec66f3f660efa.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3156016-x86_ea2cf88a256d4138109847ddc5cec66f3f660efa.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2016/04/windows6.1-kb3155178-x86_9a1f15d917191a010d323e7e9dc7e6b211524ed6.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3155178-x86_9a1f15d917191a010d323e7e9dc7e6b211524ed6.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2016/05/windows6.1-kb3159398-x86_c4fa9c67178bef5dbcbd72cde2fe94f5126337e5.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3159398-x86_c4fa9c67178bef5dbcbd72cde2fe94f5126337e5.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2016/05/windows6.1-kb3161949-x86_0055d0d1e103d374e042f31ebdd26931853b882b.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3161949-x86_0055d0d1e103d374e042f31ebdd26931853b882b.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2017/05/windows6.1-kb4019990-x86_1365fb557d5e5917cbf59b507eac066ad89ea3f7.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb4019990-x86_1365fb557d5e5917cbf59b507eac066ad89ea3f7.msu"

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
		mkdir "$($folder_cwd_windows7_updates)\11"
		mkdir "$($folder_cwd_windows7_updates)\12"
	}
	
	if(-Not (Test-Path -Path "$folder_cwd_windows7_sp1")){
		mkdir "$($folder_cwd_windows7_sp1)"
	}
	
	if(-Not (Test-Path -Path "$folder_cwd_windows7_ie11")){
		mkdir "$($folder_cwd_windows7_ie11)"
	}
	
	Write-Host " "
	Write-Host "#####################################"
	Write-Host "# Downloading Windows 7 x64 Updates #"
	Write-Host "#####################################"
	Write-Host " "
	
	#SP1
	Write-Host "Download Service Pack 1"
	Invoke-WebRequest "http://download.windowsupdate.com/msdownload/update/software/crup/2011/05/windows6.1-kb2533552-x64_0ba5ac38d4e1c9588a1e53ad390d23c1e4ecd04d.msu" -OutFile "$($folder_cwd_windows7_sp1)\windows6.1-kb2533552-x64_0ba5ac38d4e1c9588a1e53ad390d23c1e4ecd04d.msu"
	Invoke-WebRequest "http://download.windowsupdate.com/msdownload/update/software/svpk/2011/02/windows6.1-kb976932-x64_74865ef2562006e51d7f9333b4a8d45b7a749dab.exe" -OutFile "$($folder_cwd_windows7_sp1)\windows6.1-kb976932-x64_74865ef2562006e51d7f9333b4a8d45b7a749dab.exe"
	
	# Updates
	Write-Host "Download Updates"
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
	
	# Additional updates
	Write-Host "Download additional Updates"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2016/09/windows6.1-kb3172605-x64_2bb9bc55f347eee34b1454b50c436eb6fd9301fc.msu" -OutFile "$($folder_cwd_windows7_updates)\11\windows6.1-kb3172605-x64_2bb9bc55f347eee34b1454b50c436eb6fd9301fc.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/msdownload/update/software/crup/2011/06/windows6.1-kb2552343-x64_a099df53b7dfafc6e88b59c555f21377b7e07478.msu" -OutFile "$($folder_cwd_windows7_updates)\11\windows6.1-kb2552343-x64_a099df53b7dfafc6e88b59c555f21377b7e07478.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2020/02/windows6.1-kb4537829-x64_b4f4c2cd38b45a81fe9278e97e72fc3f8dc1bb70.msu" -OutFile "$($folder_cwd_windows7_updates)\11\windows6.1-kb4537829-x64_b4f4c2cd38b45a81fe9278e97e72fc3f8dc1bb70.msu"
	
	Invoke-WebRequest "https://download.microsoft.com/download/E/C/5/EC5D4973-A233-4F48-A555-65DF1E6DDA99/Windows6.1-KB3018238-x64.msu" -OutFile "$($folder_cwd_windows7_updates)\12\Windows6.1-KB3018238-x64.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2013/11/windows6.1-kb2900986-x64_a56afda70b8208665280cb79d0a6704bb7dcc3bb.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb2900986-x64_a56afda70b8208665280cb79d0a6704bb7dcc3bb.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2013/12/windows6.1-kb2862330-v2-x64_c1a8b768d8c22640d0a80966d124f441eb625934.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb2862330-v2-x64_c1a8b768d8c22640d0a80966d124f441eb625934.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2013/12/windows6.1-kb2912390-x64_413ad3ebc0199bd6d0ec00aaa0a17c73a00b8c30.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb2912390-x64_413ad3ebc0199bd6d0ec00aaa0a17c73a00b8c30.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/msdownload/update/software/secu/2012/05/windows6.1-kb2667402-v2-x64_15c04bd5944cd9b34a294a25b96911057593c465.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb2667402-v2-x64_15c04bd5944cd9b34a294a25b96911057593c465.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/msdownload/update/software/secu/2012/06/windows6.1-kb2698365-x64_f3ad859582ad240c95b9ed867bc9b99e39d15ba9.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb2698365-x64_f3ad859582ad240c95b9ed867bc9b99e39d15ba9.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2014/08/windows6.1-kb2894844-x64_71b051d4b2eae12423868e28b0e5b04a9e10c048.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb2894844-x64_71b051d4b2eae12423868e28b0e5b04a9e10c048.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2014/10/windows6.1-kb2984972-x64_2545620eadc06a0a3fd426b5853b2e0b48187599.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb2984972-x64_2545620eadc06a0a3fd426b5853b2e0b48187599.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2015/01/windows6.1-kb3004375-v3-x64_c4f55f4d06ce51e923bd0e269af11126c5e7196a.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3004375-v3-x64_c4f55f4d06ce51e923bd0e269af11126c5e7196a.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2015/02/windows6.1-kb3035126-x64_ba6bf5118bc60be7f824c4dba9131185e4755646.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3035126-x64_ba6bf5118bc60be7f824c4dba9131185e4755646.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2015/03/windows6.1-kb3046269-x64_9cdabeb9c2a859414c27c4f981d6b1334aee0ad5.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3046269-x64_9cdabeb9c2a859414c27c4f981d6b1334aee0ad5.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2015/01/windows6.1-kb3031432-x64_e648abe279c8b0095a57271ffbab5d5d376da558.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3031432-x64_e648abe279c8b0095a57271ffbab5d5d376da558.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2015/05/windows6.1-kb3059317-x64_b68db33239bddcb59e881252cfc7b79d58a2f26b.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3059317-x64_b68db33239bddcb59e881252cfc7b79d58a2f26b.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2015/12/windows6.1-kb3110329-x64_4ed9eebee2938cf8c55550e2a7f196a409e80b76.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3110329-x64_4ed9eebee2938cf8c55550e2a7f196a409e80b76.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2016/04/windows6.1-kb3156016-x64_97fa9ecb5f3a03a0739c6baeea3d9371c1474a6a.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3156016-x64_97fa9ecb5f3a03a0739c6baeea3d9371c1474a6a.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2016/04/windows6.1-kb3155178-x64_5db0e41e4bb12253f5c9f9bc5c1431b1b6073bf8.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3155178-x64_5db0e41e4bb12253f5c9f9bc5c1431b1b6073bf8.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2016/05/windows6.1-kb3159398-x64_dc2b2c11af4b38b0b632bd7f6d683d57a93b711c.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3159398-x64_dc2b2c11af4b38b0b632bd7f6d683d57a93b711c.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2016/05/windows6.1-kb3161949-x64_e2372fb5746e9474cec6ef1710f8d58ec5c6c000.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb3161949-x64_e2372fb5746e9474cec6ef1710f8d58ec5c6c000.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2017/05/windows6.1-kb4019990-x64_35cc310e81ef23439ba0ec1f11d7b71dd34adfe5.msu" -OutFile "$($folder_cwd_windows7_updates)\12\windows6.1-kb4019990-x64_35cc310e81ef23439ba0ec1f11d7b71dd34adfe5.msu"

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
} elseif ($windows -eq $windows7_x86_esu) {
	Write-Host " "
	Write-Host "#########################################"
	Write-Host "# Downloading Windows 7 x86 ESU Updates #"
	Write-Host "#########################################"
	Write-Host " "
	
	Write-Host " "
	Write-Host "Remember that these updates are not supported by slipstreaming per default!!!"
	Write-Host "You will probably have to do some modifications in order for these to work."
	Write-Host " "
	
	Write-Host -NoNewLine 'Press any key to continue...';
	$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	Write-Host " "
	
	if(-Not (Test-Path -Path "$folder_cwd_windows7_updates")){
		mkdir "$($folder_cwd_windows7_updates)"
	}

	mkdir "$($folder_cwd_windows7_updates)\95"
	mkdir "$($folder_cwd_windows7_updates)\96"
	mkdir "$($folder_cwd_windows7_updates)\97"
	mkdir "$($folder_cwd_windows7_updates)\98"
	mkdir "$($folder_cwd_windows7_updates)\99"
	
	Write-Host "Download ESU Updates"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2020/04/windows6.1-kb4555449-x86_36683b4af68408ed268246ee3e89772665572471.msu" -OutFile "$($folder_cwd_windows7_updates)\95\windows6.1-kb4555449-x86_36683b4af68408ed268246ee3e89772665572471.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2020/07/windows6.1-kb4575903-x86_5905c774f806205b5d25b04523bb716e1966306d.msu" -OutFile "$($folder_cwd_windows7_updates)\96\windows6.1-kb4575903-x86_5905c774f806205b5d25b04523bb716e1966306d.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/09/windows6.1-kb5017397-x86_96b91eb53575a201d59b1a2b540aa15df0d23b3a.msu" -OutFile "$($folder_cwd_windows7_updates)\97\windows6.1-kb5017397-x86_96b91eb53575a201d59b1a2b540aa15df0d23b3a.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2023/01/windows6.1-kb5022338-x86_490dce532d299588e11abf3790ff1600482525cd.msu" -OutFile "$($folder_cwd_windows7_updates)\98\windows6.1-kb5022338-x86_490dce532d299588e11abf3790ff1600482525cd.msu"
	
	Write-Host "Download additional ESU Updates"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/uprl/2020/05/windows6.1-kb4557900-x86_72a6afb8cf994c3c8176cc9953e17e52c20b5016.msu" -OutFile "$($folder_cwd_windows7_updates)\99\windows6.1-kb4557900-x86_72a6afb8cf994c3c8176cc9953e17e52c20b5016.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/uprl/2020/09/windows6.1-kb4566371-x86_5f2f1263346a6a0158087fa71ef068540552d1d7.msu" -OutFile "$($folder_cwd_windows7_updates)\99\windows6.1-kb4566371-x86_5f2f1263346a6a0158087fa71ef068540552d1d7.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/uprl/2020/10/windows6.1-kb4578623-x86_11ffee2bac9f998623938836968a738d35af51df.msu" -OutFile "$($folder_cwd_windows7_updates)\99\windows6.1-kb4578623-x86_11ffee2bac9f998623938836968a738d35af51df.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/uprl/2021/04/windows6.1-kb4601275-x86_8f127a2ce3fa65c11f3824998e95da4d211f100c.msu" -OutFile "$($folder_cwd_windows7_updates)\99\windows6.1-kb4601275-x86_8f127a2ce3fa65c11f3824998e95da4d211f100c.msu"
} elseif ($windows -eq $windows7_x64_esu) {
	Write-Host " "
	Write-Host "#########################################"
	Write-Host "# Downloading Windows 7 x64 ESU Updates #"
	Write-Host "#########################################"
	Write-Host " "
	
	Write-Host " "
	Write-Host "Remember that these updates are not supported by slipstreaming per default!!!"
	Write-Host "You will probably have to do some modifications in order for these to work."
	Write-Host " "
	
	Write-Host -NoNewLine 'Press any key to continue...';
	$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	Write-Host " "
	
	if(-Not (Test-Path -Path "$folder_cwd_windows7_updates")){
		mkdir "$($folder_cwd_windows7_updates)"
	}

	mkdir "$($folder_cwd_windows7_updates)\95"
	mkdir "$($folder_cwd_windows7_updates)\96"
	mkdir "$($folder_cwd_windows7_updates)\97"
	mkdir "$($folder_cwd_windows7_updates)\98"
	mkdir "$($folder_cwd_windows7_updates)\99"
	
	Write-Host "Download ESU Updates"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2020/04/windows6.1-kb4555449-x64_92202202c3dee2f713f67adf6622851b998c6780.msu" -OutFile "$($folder_cwd_windows7_updates)\95\windows6.1-kb4555449-x64_92202202c3dee2f713f67adf6622851b998c6780.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2020/07/windows6.1-kb4575903-x64_b4d5cf045a03034201ff108c2802fa6ac79459a1.msu" -OutFile "$($folder_cwd_windows7_updates)\96\windows6.1-kb4575903-x64_b4d5cf045a03034201ff108c2802fa6ac79459a1.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/09/windows6.1-kb5017397-x64_2a9999bd20cb964869c59bb16841a76e14030a29.msu" -OutFile "$($folder_cwd_windows7_updates)\97\windows6.1-kb5017397-x64_2a9999bd20cb964869c59bb16841a76e14030a29.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2023/01/windows6.1-kb5022338-x64_75d100c03bcaee4b62d08004cc382337ed09d327.msu" -OutFile "$($folder_cwd_windows7_updates)\98\windows6.1-kb5022338-x64_75d100c03bcaee4b62d08004cc382337ed09d327.msu"

	Write-Host "Download additional ESU Updates"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/uprl/2020/05/windows6.1-kb4557900-x64_d627d0b8e7fa41a7604fa39b0fc63ed240ca9ad1.msu" -OutFile "$($folder_cwd_windows7_updates)\99\windows6.1-kb4557900-x64_d627d0b8e7fa41a7604fa39b0fc63ed240ca9ad1.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/uprl/2020/09/windows6.1-kb4566371-x64_d558c4dacfbea4e754788bf98db998a119d77305.msu" -OutFile "$($folder_cwd_windows7_updates)\99\windows6.1-kb4566371-x64_d558c4dacfbea4e754788bf98db998a119d77305.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/uprl/2020/10/windows6.1-kb4578623-x64_dcbc342c60cc1c6c4ca8559430008a8191e64455.msu" -OutFile "$($folder_cwd_windows7_updates)\99\windows6.1-kb4578623-x64_dcbc342c60cc1c6c4ca8559430008a8191e64455.msu"
	Invoke-WebRequest "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/uprl/2021/04/windows6.1-kb4601275-x64_00d4557308ead569110ca3455205375984afde76.msu" -OutFile "$($folder_cwd_windows7_updates)\99\windows6.1-kb4601275-x64_00d4557308ead569110ca3455205375984afde76.msu"
}

Write-Host " "
Write-Host "Finished!"
Write-Host " "

Exit