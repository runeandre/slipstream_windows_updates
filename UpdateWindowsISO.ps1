Write-Host "######################################################"
Write-Host "#                                                    #"
Write-Host "# Update Windows.iso with Windows Updates using DISM #"
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
$program_files_x86 = ${Env:ProgramFiles(x86)}
$windows_system32 = [System.Environment]::SystemDirectory
$expand_exe = "$($windows_system32)\expand.exe"
$oscdimg_x86 = "$($program_files_x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\x86\Oscdimg\oscdimg.exe"
$oscdimg_x64 = "$($program_files_x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\oscdimg.exe"

# DVD
$folder_name_tmp = "tmp"
$folder_tmp = "$($PWD)\$($folder_name_tmp)"
$folder_win_dvd = "$($folder_tmp)\win_dvd"
$dvd_source_name = "Windows.iso"
$dvd_target_name = "Windows_DVD.iso"
$installFile = "install."

# Windows Updates
$folder_cwd_windows_updates = "$($PWD)\windows_updates"

# Windows 7 Updates
$folder_cwd_windows7_updates = "$($PWD)\windows7_updates"

# Windows 7 IE11
$folder_cwd_windows7_ie11 = "$($PWD)\windows7_ie11"
$folder_tmp_windows7_ie11 = "$($folder_tmp)\windows7_ie11"
$win7_ie11_x86 = "IE11-Windows6.1-x86-en-us.exe"
$win7_ie11_x64 = "IE11-Windows6.1-x64-en-us.exe"
$win7_ie11_support = "IE_SUPPORT_amd64_en-US.CAB"
$win7_ie11_spelling = "IE-Spelling-en.msu"
$win7_ie11_hyphenation = "IE-Hyphenation-en.msu"
$win7_ie11_iewin7 = "IE-Win7.CAB"

# Win7 SP1
$folder_tmp_windows7_sp1 = "$($folder_tmp)\windows7_sp1"
$folder_cwd_windows7_sp1 = "$($PWD)\windows7_sp1"
$win7_pre_sp1_x86 = "windows6.1-kb2533552-x86.msu"
$win7_pre_sp1_x64 = "windows6.1-kb2533552-x64.msu"
$win7_sp1_exe_x86 = "windows6.1-kb976932-x86.exe"
$win7_sp1_exe_x64 = "windows6.1-kb976932-x64.exe"
$win7_sp1_cab_x86 = "windows6.1-KB976932-X86.cab"
$win7_sp1_cab_x64 = "windows6.1-KB976932-X64.cab"
$win7_sp1_NestedMPPContent_cab = "NestedMPPContent.cab"
$win7_sp1_update_ses = "update.ses"
$win7_sp1_update_mum = "update.mum"
$win7_sp1_Windows7SP1_KB976933_amd64_mum = "Windows7SP1-KB976933~31bf3856ad364e35~amd64~~6.1.1.17514.mum"
$win7_sp1_KB976933_LangsCab0_cab = "KB976933-LangsCab0.cab"
$win7_sp1_KB976933_LangsCab1_cab = "KB976933-LangsCab1.cab"
$win7_sp1_KB976933_LangsCab2_cab = "KB976933-LangsCab2.cab"
$win7_sp1_KB976933_LangsCab3_cab = "KB976933-LangsCab3.cab"
$win7_sp1_KB976933_LangsCab4_cab = "KB976933-LangsCab4.cab"
$win7_sp1_KB976933_LangsCab5_cab = "KB976933-LangsCab5.cab"
$win7_sp1_KB976933_LangsCab6_cab = "KB976933-LangsCab6.cab"


### Set 32-bit or 64-bit settings ###

# For x86 32-bit systems
$oscdimg = $oscdimg_x86
$win7_sp1_exe = $win7_sp1_exe_x86
$win7_sp1_cab = $win7_sp1_cab_x86
$win7_pre_sp1 = $win7_pre_sp1_x86
$win7_ie11 = $win7_ie11_x86

# For x86 64-bit systems
if ([Environment]::Is64BitProcess) {
    $oscdimg = $oscdimg_x64
	$win7_sp1_exe = $win7_sp1_exe_x64
	$win7_sp1_cab = $win7_sp1_cab_x64
	$win7_pre_sp1 = $win7_pre_sp1_x64
	$win7_ie11 = $win7_ie11_x64
}


### Check if expand.exe exists ###
if (![System.IO.File]::Exists("$($expand_exe)")) {
	Write-Host " "
	Write-Host "Cannot find ""$($expand_exe)"" which is needed to extract from cab files"
	Write-Host " "

	Exit
}

### Install adksetup.exe to "$($program_files_x86)\Windows Kits\10\" if oscdimg is missing ###
Write-Host " "
if (![System.IO.File]::Exists($oscdimg)) {
    Write-Host "Install adksetup.exe in order to get oscdimg.exe"

    # Download adksetup.exe
    if (![System.IO.File]::Exists("$($PWD)\adksetup.exe")) {
        Write-Host "Download missing adksetup.exe setup file"
        Invoke-WebRequest https://go.microsoft.com/fwlink/?linkid=2271337 -OutFile adksetup.exe
    }

    # Silent install of adksetup.exe and DeploymentTools
    Write-Host "Silent adksetup.exe install to '$($program_files_x86)\Windows Kits\10\'"
    & "$($PWD)\adksetup.exe" /quiet /installpath "$($program_files_x86)\Windows Kits\10" /features OptionId.DeploymentTools
}
Write-Host "Location of oscdimg: $($oscdimg)"

### Full path to the ISO file
Write-Host " "
$isoPath = "$($PWD)\$($dvd_source_name)"
Write-Host "ISO file: $($isoPath)"

### Unmount the ISO if already mounted
$isoDrive = Get-DiskImage -ImagePath $isoPath
$isoDrive | Dismount-DiskImage | Out-Null

### Delete old files and folders
Write-Host " "
Write-Host "Delete old files and folders. (This can take a while due to many small files!)"
Remove-Item "$($PWD)\$($dvd_target_name)" -Force -Confirm:$false -ErrorAction SilentlyContinue
if(Test-Path -Path "$($folder_tmp)"){
	attrib -r -h "$($folder_tmp)" /s /d
	Remove-Item "$($folder_tmp)" -Recurse -Force -Confirm:$false -ErrorAction SilentlyContinue
}

# Has tmp been deleted, if not, try harder
# This might been required if the script was aborted, and wims not unmounted properly.
if(Test-Path -Path "$($folder_tmp)"){
	Write-Host " "
	Write-Host """$($folder_tmp)"" was not removed, let's try again after running ""dism /cleanup-wim"""
	Write-Host " "
	
	dism /cleanup-wim
	
	### Unmount the ISO if already mounted
	$isoDrive = Get-DiskImage -ImagePath $isoPath
	$isoDrive | Dismount-DiskImage | Out-Null
	
	if(Test-Path -Path "$($folder_tmp)"){
		attrib -r -h "$($folder_tmp)" /s /d
		Remove-Item "$($folder_tmp)" -Recurse -Force -Confirm:$false -ErrorAction SilentlyContinue
	}
	
	if(Test-Path -Path "$($folder_tmp)"){
		Write-Host " "
		Write-Host "################################################################################"
		Write-Host """$($folder_tmp)"" not removed! Please help! Maybe restart the PC and try again?"
		Write-Host "Maybe you need to close a terminal or something that is open in the tmp folder? "
		Write-Host "You can try running the command ""dism /cleanup-wim"" as an admin."
		Write-Host "################################################################################"
		Write-Host " "
		
		Exit
	}
}

### Mount ISO
$isoDrive = Mount-DiskImage -ImagePath $isoPath -PassThru | Get-Volume

### Get the DriveLetter currently assigned to the drive (a single [char])
$isoLetter = ($isoDrive | Get-Volume).DriveLetter
$isoDriveLetter = "$($isoLetter):\"
Write-Host "ISO drive letter: $($isoDriveLetter)"

### Check for sources\install.esd or wim
if ([System.IO.File]::Exists("$($isoDriveLetter)sources\install.esd")) {
	$installFile = "install.esd"
} elseif ([System.IO.File]::Exists("$($isoDriveLetter)sources\install.wim")) {
	$installFile = "install.wim"
} else {
    Write-Host " "
	Write-Host " "
	Write-Host "#############"
    Write-Host "### Error ###"
	Write-Host "#############"
    Write-Host " "
    Write-Host "Unable to find install.esd or install.wim in the ISO file $($isoPath) (Mounted to '$($isoDriveLetter)sources\')."
    Write-Host " "
	Write-Host "Have you provided an ISO with both 32-bit and 64-bit on it?"
    Write-Host "Use an ISO with only one architecture on it (32 OR 64-bit) as only this is supported by this script."
    Write-Host " "

	### Unmount ISO
	$isoDrive = Get-DiskImage -ImagePath "$($isoPath)"
	$isoDrive | Dismount-DiskImage | Out-Null

    Exit
}

##############################
### Select Windows version ###
##############################

# List Windows images 
$dvd_windows_info = Dism /Get-WimInfo /WimFile:"$($isoDriveLetter)sources\$($installFile)"
$dvd_windows_info_index = $dvd_windows_info | Select-String "Index :"
$dvd_windows_info_name = $dvd_windows_info | Select-String "Name :"

# Index array trimmed
$dvd_windows_info_index_trimmed = @()
foreach($info_index in $dvd_windows_info_index){
	$dvd_windows_info_index_trimmed += $info_index -Replace "Index : ",""
}

# Name array trimmed
$dvd_windows_info_name_trimmed = @()
foreach($info_name in $dvd_windows_info_name){
	$dvd_windows_info_name_trimmed += $info_name -Replace "Name : ",""
}

# Combined index and name in a hash
$dvd_windows_list = @{}
for($i=0;$i -lt $dvd_windows_info_index_trimmed.count; $i++){
	$dvd_windows_list.add($dvd_windows_info_index_trimmed[$i], $dvd_windows_info_name_trimmed[$i])
}

Write-Host " "
Write-Host "Select Windows version to update (the others will be removed!):"
foreach($info_index in $dvd_windows_info_index_trimmed){
	Write-Host "$($info_index) : $($dvd_windows_list[$info_index])"
}
Write-Host " "
[int]$selection = Read-Host "Press the number to select a Windows version"
if($dvd_windows_list.Keys -contains $selection){
	Write-Output "You chose: $selection"
}else{
	Write-Host "The key ""$selection"" is not valid!"
	
	### Unmount ISO
	$isoDrive = Get-DiskImage -ImagePath "$($isoPath)"
	$isoDrive | Dismount-DiskImage | Out-Null
	
	Exit
}

################################
### Windows version settings ###
################################
$dvd_windows_version_array = Dism /Get-ImageInfo /ImageFile:"$($isoDriveLetter)sources\$($installFile)" /index:$selection | Select-String "Name : Windows"
$dvd_architecture_array = Dism /Get-ImageInfo /ImageFile:"$($isoDriveLetter)sources\$($installFile)" /index:$selection | Select-String "Architecture : "

# Trim the start of the string array and save as string
$dvd_windows_version = $dvd_windows_version_array[0] -Replace "Name : ",""
$dvd_architecture = $dvd_architecture_array[0] -Replace "Architecture : ",""

# Add DVD Windows name to target ISO name
$dvd_target_name = "$($dvd_windows_version.replace(" ","_")).iso"

Write-Host " "
Write-Host "Name: $($dvd_windows_version)"
Write-Host "Architecture: $($dvd_architecture)"

$dvd_version_win7 = "7"
$dvd_version_win7_name = "Windows 7"
$dvd_version_win10 = "10"
$dvd_version_win10_name = "Windows 10"
$dvd_version_win11 = "11"
$dvd_version_win11_name = "Windows 11"

if ("$($dvd_windows_version)" -like "*$($dvd_version_win7_name)*"){
    $dvd_windows_version = $dvd_version_win7
} elseif ("$($dvd_windows_version)" -like "*$($dvd_version_win10_name)*"){
    $dvd_windows_version = $dvd_version_win10
} elseif ("$($dvd_windows_version)" -like "*$($dvd_version_win11_name)*"){
    $dvd_windows_version = $dvd_version_win11
} else {
	Write-Host " "
	Write-Host "Unsupported Windows version!"
	Write-Host " "
	
	### Unmount ISO
	$isoDrive = Get-DiskImage -ImagePath "$($isoPath)"
	$isoDrive | Dismount-DiskImage | Out-Null
	
	exit
}


##################################
### File and folder operations ###
##################################

### Delete old ISOs with the version in the name
Remove-Item "$($PWD)\$($dvd_target_name)" -Force -Confirm:$false -ErrorAction SilentlyContinue

### Create folders
if ($dvd_windows_version -eq $dvd_version_win7) {
	# Windows 7
	if(-Not (Test-Path -Path "$folder_cwd_windows7_sp1")){
		mkdir "$($folder_cwd_windows7_sp1)"
		
		Write-Host " "
		Write-Host "The folder ""$($folder_cwd_windows7_sp1)"" was missing and has been created."
		Write-Host "Please put the Windows 7 Service Pack 1 files $($win7_pre_sp1) and $($win7_sp1_exe) here if you need to add SP1."
		Write-Host "It must match the ISO architecture $($dvd_architecture)!"
		Write-Host " "
		Write-Host "Press any key to continue!"
		Write-Host " "
		
		Pause
	}

	if(-Not (Test-Path -Path "$folder_cwd_windows7_updates")){
		mkdir "$($folder_cwd_windows7_updates)"
		
		Write-Host " "
		Write-Host "The folder ""$($folder_cwd_windows7_updates)"" was missing and has been created."
		Write-Host "Please put the Windows 7 Updates (cab and msu files) here."
		Write-Host "They must match the ISO architecture $($dvd_architecture)!"
		Write-Host "You can create numbered sub-folders if you want to control the order the updates are applied in."
		Write-Host " "
		Write-Host "Press any key to continue!"
		Write-Host " "
		
		Pause
	}
	
	if(-Not (Test-Path -Path "$folder_cwd_windows7_ie11")){
		mkdir "$($folder_cwd_windows7_ie11)"
		
		Write-Host " "
		Write-Host "The folder ""$($folder_cwd_windows7_ie11)"" was missing and has been created."
		Write-Host "Please put the Windows 7 Internet Explorer 11 files (exe and msu files) here."
		Write-Host "They must match the ISO architecture $($dvd_architecture)!"
		Write-Host " "
		Write-Host "Press any key to continue!"
		Write-Host " "
		
		Pause
	}
} else {
	# All other versions of Windows
	if(-Not (Test-Path -Path "$folder_cwd_windows_updates")){
		mkdir "$($folder_cwd_windows_updates)"
		
		Write-Host " "
		Write-Host "The folder ""$($folder_cwd_windows_updates)"" was missing and has been created."
		Write-Host "Please put the Windows Updates (cab and msu files) here."
		Write-Host "They must match the ISO architecture $($dvd_architecture)!"
		Write-Host "You can create numbered folders if you want to control the order the updates are applied in."
		Write-Host " "
		Write-Host "Press any key to continue!"
		Write-Host " "
		
		Pause
	}
}

Write-Host " "
Write-Host "Creating the '$($folder_tmp)' and '$($folder_win_dvd)' folders"
mkdir "$($folder_win_dvd)"

### Copy CD content to the tmp\win_dvd folder
Write-Host " "
Write-Host "Copy Windows DVD files from '$($isoDriveLetter)' to '$($folder_win_dvd)' (This takes a while!)"
Copy-item -Force -Recurse "$($isoDriveLetter)*" -Destination "$($folder_win_dvd)" #-Verbose

### Unmount ISO
$isoDrive = Get-DiskImage -ImagePath "$($isoPath)"
$isoDrive | Dismount-DiskImage | Out-Null

### Read Write permissions
attrib -r -h "$($folder_tmp)\*.*" /s /d

# Remove the other Windows versions in the install image, from last to first to avoid index numbering issues
Write-Host " "
Write-Host "Remove the images not to be updated from the $($folder_win_dvd)\sources\$($installFile) file."
for($i=$dvd_windows_info_index_trimmed.count-1;$i -ge 0; $i--){
	$info_index = $dvd_windows_info_index_trimmed[$i]
	
	if($info_index -ne $selection){
		Write-Host "Remove the $($dvd_windows_list[$info_index]) image with index number $($info_index)."
		Remove-WindowsImage -ImagePath "$($folder_win_dvd)\sources\$($installFile)" -Index $info_index -CheckIntegrity
	}
}
#Reset selection since there is now only one image in the install image
$selection = 1


##################################
### Windows 7 - Service Pack 1 ###
##################################
if ($dvd_windows_version -eq $dvd_version_win7 -And [System.IO.File]::Exists("$($folder_cwd_windows7_sp1)\$($win7_sp1_exe)")) {
	mkdir "$($folder_tmp_windows7_sp1)"

	# Extract SP1
	Start-Process "$($folder_cwd_windows7_sp1)\$($win7_sp1_exe)" -ArgumentList @("-x:""$($folder_tmp_windows7_sp1)""") -NoNewWindow -Wait

	# Extract windows6.1-KB976932-X64.cab
	try { 
		Write-Host " "
		Write-Host "The command: $($expand_exe) -F:* ""$($folder_tmp_windows7_sp1)\$($win7_sp1_cab)"" ""$($folder_tmp_windows7_sp1)"""
		Write-Host " "
		cmd.exe /c "$($expand_exe) -F:* ""$($folder_tmp_windows7_sp1)\$($win7_sp1_cab)"" ""$($folder_tmp_windows7_sp1)"""
	} catch { 
		Write-host "Nope, don't have that, soz."
	}

	# Extract NestedMPPContent.cab
	try { 
		Write-Host " "
		Write-Host "The command: $($expand_exe) -F:* ""$($folder_tmp_windows7_sp1)\$($win7_sp1_NestedMPPContent_cab)"" ""$($folder_tmp_windows7_sp1)"""
		Write-Host " "
		cmd.exe /c "$($expand_exe) -F:* ""$($folder_tmp_windows7_sp1)\$($win7_sp1_NestedMPPContent_cab)"" ""$($folder_tmp_windows7_sp1)"""
	} catch { 
		Write-host "Nope, don't have that, soz."
	}

	## Update update.ses ##
	[xml]$xmlDoc = Get-Content "$($folder_tmp_windows7_sp1)\$($win7_sp1_update_ses)"
	foreach ($element in $xmlDoc.Session.Tasks) {
		Write-Host " "
		Write-Host "operationMode: $($element.operationMode)"
		if($element.operationMode -eq "OfflineInstall"){
			Write-Host " "
			Write-Host "update.ses"
			Write-Host "targetState: $($element.Phase.package.targetState)"
			
			$element.Phase.package.targetState = "Installed"
		}
	}
	$xmlDoc.Save("$($folder_tmp_windows7_sp1)\$($win7_sp1_update_ses)")

	## Update update.mum ##
	[xml]$xmlDoc = Get-Content "$($folder_tmp_windows7_sp1)\$($win7_sp1_update_mum)"
	Write-Host " "
	Write-Host "update.mum"
	Write-Host "allowedOffline: $($xmlDoc.assembly.package.packageExtended.allowedOffline)"
	$xmlDoc.assembly.package.packageExtended.allowedOffline = "true"
	$xmlDoc.Save("$($folder_tmp_windows7_sp1)\$($win7_sp1_update_mum)")

	## Update Windows7SP1-KB976933~31bf3856ad364e35~amd64~~6.1.1.17514.mum ##
	[xml]$xmlDoc = Get-Content "$($folder_tmp_windows7_sp1)\$($win7_sp1_Windows7SP1_KB976933_amd64_mum)"
	Write-Host " "
	Write-Host "Windows7SP1-KB976933~31bf3856ad364e35~amd64~~6.1.1.17514.mum"
	Write-Host "allowedOffline: $($xmlDoc.assembly.package.packageExtended.allowedOffline)"
	$xmlDoc.assembly.package.packageExtended.allowedOffline = "true"
	$xmlDoc.Save("$($folder_tmp_windows7_sp1)\$($win7_sp1_Windows7SP1_KB976933_amd64_mum)")

	# Extract KB976933-LangsCabX
	try { 
		Write-Host " "
		Write-Host "The command: $($expand_exe) -F:* $($folder_tmp_windows7_sp1)\KB976933-LangsCabX $($folder_tmp_windows7_sp1)"
		Write-Host " "
		cmd.exe /c "$($expand_exe) -F:* ""$($folder_tmp_windows7_sp1)\$($win7_sp1_KB976933_LangsCab0_cab)"" ""$($folder_tmp_windows7_sp1)"""
		cmd.exe /c "$($expand_exe) -F:* ""$($folder_tmp_windows7_sp1)\$($win7_sp1_KB976933_LangsCab1_cab)"" ""$($folder_tmp_windows7_sp1)"""
		cmd.exe /c "$($expand_exe) -F:* ""$($folder_tmp_windows7_sp1)\$($win7_sp1_KB976933_LangsCab2_cab)"" ""$($folder_tmp_windows7_sp1)"""
		cmd.exe /c "$($expand_exe) -F:* ""$($folder_tmp_windows7_sp1)\$($win7_sp1_KB976933_LangsCab3_cab)"" ""$($folder_tmp_windows7_sp1)"""
		cmd.exe /c "$($expand_exe) -F:* ""$($folder_tmp_windows7_sp1)\$($win7_sp1_KB976933_LangsCab4_cab)"" ""$($folder_tmp_windows7_sp1)"""
		cmd.exe /c "$($expand_exe) -F:* ""$($folder_tmp_windows7_sp1)\$($win7_sp1_KB976933_LangsCab5_cab)"" ""$($folder_tmp_windows7_sp1)"""
		cmd.exe /c "$($expand_exe) -F:* ""$($folder_tmp_windows7_sp1)\$($win7_sp1_KB976933_LangsCab6_cab)"" ""$($folder_tmp_windows7_sp1)"""
	} catch { 
		Write-host "Nope, don't have that, soz."
	}
}

######################################
## Windows 7 - Internet Explorer 11 ##
######################################
if ($dvd_windows_version -eq $dvd_version_win7 -And [System.IO.File]::Exists("$($folder_cwd_windows7_ie11)\$($win7_ie11)")) {
	mkdir "$($folder_tmp_windows7_ie11)"
	
	# Extract SP1
	Start-Process "$($folder_cwd_windows7_ie11)\$($win7_ie11)" -ArgumentList @("-x:""$($folder_tmp_windows7_ie11)""") -NoNewWindow -Wait
}



######################
### Update Windows ###
######################

### Windows 7 Service Pack 1 ###
if ($dvd_windows_version -eq $dvd_version_win7 -And [System.IO.File]::Exists("$($folder_cwd_windows7_sp1)\$($win7_sp1_exe)")) {
	# Create mount folder 
	mkdir "$($folder_tmp)\mount"
		
	# Mount
	dism /mount-wim /wimfile:"$($folder_win_dvd)\sources\$($installFile)" /index:$selection /mountdir:"$($folder_tmp)\mount"

	Write-Host " "
	Write-Host "Update ""$($folder_tmp)\mount"" with the update ""$($folder_cwd_windows7_sp1)\$($win7_pre_sp1)"""
	Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($folder_cwd_windows7_sp1)\$($win7_pre_sp1)"

	Write-Host " "
	Write-Host "Update ""$($folder_tmp)\mount"" with the updates from ""$($folder_tmp_windows7_sp1)"" (This can take a while!!!)"
	Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($folder_tmp_windows7_sp1)"

	# Unmount
	dism /unmount-image /mountdir:"$($folder_tmp)\mount" /commit
}


### Windows Updates ###
# Create mount folder if missing
if(-Not (Test-Path -Path "$($folder_tmp)\mount")){
	mkdir "$($folder_tmp)\mount"
}

# Update
if ($dvd_windows_version -eq $dvd_version_win7) {
	# Windows 7
	Get-ChildItem -Directory -Path "$($folder_cwd_windows7_updates)" | ForEach-Object {
		# Check that update folder is not empty
		if (Test-Path "$($_.FullName)\*") {
			# Mount
			dism /mount-wim /wimfile:"$($folder_win_dvd)\sources\$($installFile)" /index:$selection /mountdir:"$($folder_tmp)\mount"
			
			Write-Host " "
			Write-Host "Slipstream updates in the subfolder ""$($_.FullName)"" (This can take a while!!! Ignore missmatch errors!)"
			Write-Host "Dism /Image:""$($folder_tmp)\mount"" /Add-Package /PackagePath:""$($_.FullName)"""
			Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($_.FullName)"
			
			# Unmount
			dism /unmount-image /mountdir:"$($folder_tmp)\mount" /commit
		}
	}
	
	# Check that update folder is not empty
	if (Test-Path "$($folder_cwd_windows7_updates)\*") {
		# Mount
		dism /mount-wim /wimfile:"$($folder_win_dvd)\sources\$($installFile)" /index:$selection /mountdir:"$($folder_tmp)\mount"
		
		Write-Host " "
		Write-Host "Slipstream updates (This can take a while!!! Ignore missmatch errors!)"
		Write-Host "Dism /Image:""$($folder_tmp)\mount"" /Add-Package /PackagePath:""$($folder_cwd_windows7_updates)"""
		Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($folder_cwd_windows7_updates)"
		
		# Unmount
		dism /unmount-image /mountdir:"$($folder_tmp)\mount" /commit
	}
	
	# Check that update folder is not empty
	if (Test-Path "$($folder_cwd_windows7_ie11)\*") {
		# Mount
		dism /mount-wim /wimfile:"$($folder_win_dvd)\sources\$($installFile)" /index:$selection /mountdir:"$($folder_tmp)\mount"
		
		Write-Host " "
		Write-Host "Slipstream Internet Explorer 11 Prerequisites"
		Write-Host "Dism /Image:""$($folder_tmp)\mount"" /Add-Package /PackagePath:""$($folder_cwd_windows7_ie11)"""
		Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($folder_cwd_windows7_ie11)"
		
		# Unmount
		dism /unmount-image /mountdir:"$($folder_tmp)\mount" /commit
		
		# Mount
		dism /mount-wim /wimfile:"$($folder_win_dvd)\sources\$($installFile)" /index:$selection /mountdir:"$($folder_tmp)\mount"
		
		Write-Host " "
		Write-Host "Slipstream Internet Explorer 11"
		
		Write-Host "Dism /Image:""$($folder_tmp)\mount"" /Add-Package /PackagePath:""$($folder_tmp_windows7_ie11)\$($win7_ie11_support)"""
		Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($folder_tmp_windows7_ie11)\$($win7_ie11_support)"
		
		Write-Host "Dism /Image:""$($folder_tmp)\mount"" /Add-Package /PackagePath:""$($folder_tmp_windows7_ie11)\$($win7_ie11_spelling)"""
		Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($folder_tmp_windows7_ie11)\$($win7_ie11_spelling)"
		
		Write-Host "Dism /Image:""$($folder_tmp)\mount"" /Add-Package /PackagePath:""$($folder_tmp_windows7_ie11)\$($win7_ie11_hyphenation)"""
		Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($folder_tmp_windows7_ie11)\$($win7_ie11_hyphenation)"
		
		Write-Host "Dism /Image:""$($folder_tmp)\mount"" /Add-Package /PackagePath:""$($folder_tmp_windows7_ie11)\$($win7_ie11_iewin7)"""
		Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($folder_tmp_windows7_ie11)\$($win7_ie11_iewin7)"
		
		# Unmount
		dism /unmount-image /mountdir:"$($folder_tmp)\mount" /commit
	}
} else {
	# All other versions of Windows
	Get-ChildItem -Directory -Path "$($folder_cwd_windows_updates)" | ForEach-Object {
		# Check that update folder is not empty
		if (Test-Path "$($_.FullName)\*") {
			# Mount
			dism /mount-wim /wimfile:"$($folder_win_dvd)\sources\$($installFile)" /index:$selection /mountdir:"$($folder_tmp)\mount"
			
			Write-Host " "
			Write-Host "Slipstream updates in the subfolder ""$($_.FullName)"" (This can take a while!!! Ignore missmatch errors!)"
			Write-Host "Dism /Image:""$($folder_tmp)\mount"" /Add-Package /PackagePath:""$($_.FullName)"""
			Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($_.FullName)"
			
			# Unmount
			dism /unmount-image /mountdir:"$($folder_tmp)\mount" /commit
		}
	}
	
	# Check that update folder is not empty
	if (Test-Path "$($folder_cwd_windows_updates)\*") {
		# Mount
		dism /mount-wim /wimfile:"$($folder_win_dvd)\sources\$($installFile)" /index:$selection /mountdir:"$($folder_tmp)\mount"
		
		Write-Host " "
		Write-Host "Slipstream updates (This can take a while!!! Ignore missmatch errors!)"
		Write-Host "Dism /Image:""$($folder_tmp)\mount"" /Add-Package /PackagePath:""$($folder_cwd_windows_updates)"""
		Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($folder_cwd_windows_updates)"
		
		# Unmount
		dism /unmount-image /mountdir:"$($folder_tmp)\mount" /commit
	}
}


###################
### Create ISOs ###
###################
if ($dvd_windows_version -eq $dvd_version_win7) {
	# Windows 7 ISO
	& $oscdimg -m -o -h -u2 -udfver102 -b"$($folder_win_dvd)\boot\etfsboot.com" "$($folder_win_dvd)" "$($PWD)\$($dvd_target_name)"
} else {
	# ISO for all other versions of Windows (10 and 11 should work)
	& $oscdimg -m -o -u2 -udfver102 -bootdata:2#p0,e,b"$($folder_win_dvd)\boot\etfsboot.com"#pEF,e,b"$($folder_win_dvd)\efi\microsoft\boot\efisys.bin" "$($folder_win_dvd)" "$($PWD)\$($dvd_target_name)"
}

### Finished
Write-Host " "
Write-Host "Finished creating the Windows ISOs!"
Write-Host "Windows DVD: $($PWD)\$($dvd_target_name)"