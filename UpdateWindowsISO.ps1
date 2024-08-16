## Logging
Write-Host "Logging to: $($PWD)\log.txt"
$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path "$($PWD)\log.txt" -append
Write-Host " "

## Check what OS version we are using
$windows_version = [System.Environment]::OSVersion.Version.Major
[bool] $windows8_or_higher = 1
if ($windows_version -lt "8"){
	$windows8_or_higher = 0
}

Write-Host "######################################################"
Write-Host "#                                                    #"
Write-Host "# Update Windows.iso with Windows Updates using DISM #"
Write-Host "#                                                    #"
Write-Host "######################################################"
Write-Host " "

Write-Host " "
Write-Host "OS version: $([System.Environment]::OSVersion.VersionString)"
Write-Host "Major version: $($windows_version)"
Write-Host "Windows 8 or higher: $($windows8_or_higher)"
Write-Host " "

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
$program_files = ${Env:ProgramFiles}
$windows_system32 = [System.Environment]::SystemDirectory
$expand_exe = "$($windows_system32)\expand.exe"
$oscdimg_x86 = "$($program_files_x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\x86\Oscdimg\oscdimg.exe"
$oscdimg_x64 = "$($program_files_x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\oscdimg.exe"
$7zip_86 = "$($program_files_x86)\7-Zip\7z.exe"
$7zip_64 = "$($program_files)\7-Zip\7z.exe"


# DVD
$folder_name_tmp = "TMP"
$folder_tmp = "$($PWD)\$($folder_name_tmp)"
$folder_windows_iso = "$($folder_tmp)\Windows ISO"
$folder_windows_iso_tmp = "$($PWD)\TMP Windows ISO"
$folder_copy_to_iso = "$($PWD)\Copy To ISO"
$dvd_source_name = "Windows.iso"
$dvd_target_name = "Windows_DVD.iso"
$installFile = "install."
$isoDriveLetter = "A:\"

# Windows Updates
$folder_cwd_windows_updates = "$($PWD)\Windows Updates"

# Windows Vista Updates
$folder_cwd_windows_vista = "$($PWD)\Windows Vista"

# Win Vista SP
$folder_tmp_windows_vista_sp1 = "$($folder_tmp)\Windows Vista SP1"
$folder_tmp_windows_vista_sp1_pre = "$($folder_tmp)\Windows Vista SP1 Prerequisites"
$folder_cwd_windows_vista_sp1 = "$($folder_cwd_windows_vista)\Service Pack 1"
$win_vista_sp1_exe_x86 = "02\windows6.0-kb936330-x86_b8a3fa8f819269e37d8acde799e7a9aea3dd4529.exe"
$win_vista_sp1_exe_x64 = "02\windows6.0-kb936330-x64_12eed6cf0a842ce2a609c622b843afc289a8f4b9.exe"

# Win Vista SP1 pre requesites
$win_vista_pre1_sp1_x86 = "01\windows6.0-kb935509-x86_083aa7934c3567ea6c2462a49c1ce4e5c2abe6a9.msu"
$win_vista_pre1_sp1_x64 = "01\windows6.0-kb935509-x64_d5cc6a8c1a83b2d75b3df49fab1a70be044beb16.msu"
$win_vista_pre1_sp1_x86_cab = "Windows6.0-KB935509-x86.cab"
$win_vista_pre1_sp1_x64_cab = "Windows6.0-KB935509-x64.cab"
$win_vista_pre2_sp1_x86 = "01\windows6.0-kb937287-x86_7c743a8b417d643dbe07eaa1c645be21ff8ae068.msu"
$win_vista_pre2_sp1_x64 = "01\windows6.0-kb937287-x64_3387382c1226f026497318cf975188647031fcc8.msu"
$win_vista_pre2_sp1_x86_cab = "Windows6.0-KB937287-x86.cab"
$win_vista_pre2_sp1_x64_cab = "Windows6.0-KB937287-x64.cab"
$win_vista_pre3_sp1_x86 = "01\windows6.0-kb938371-v2-x86_64465f21711c8fa12d5671d79363a72e43babafd.msu"
$win_vista_pre3_sp1_x64 = "01\windows6.0-kb938371-v2-x64_d4df75be66d34595c060f86737479c4b0f220163.msu"
$win_vista_pre3_sp1_x86_cab = "Windows6.0-KB938371-v2-x86.cab"
$win_vista_pre3_sp1_x64_cab = "Windows6.0-KB938371-v2-x64.cab"
$win_vista_pre4_sp1_x86 = "01\windows6.0-kb949939-x86_b4a77f7f20405bd714b5fcf8ddb1ffed6095814d.msu"
$win_vista_pre4_sp1_x64 = "01\windows6.0-kb949939-x64_194ca4626786f1928187c079586c2103ea0eb662.msu"
$win_vista_pre4_sp1_x86_cab = "Windows6.0-KB949939-x86.cab"
$win_vista_pre4_sp1_x64_cab = "Windows6.0-KB949939-x64.cab"

# Win Vista Pre requesites within SP1
$win_vista_sp1_pre1_x86 = "windows6.0-kb937287-X86.cab"
$win_vista_sp1_pre1_x64 = "windows6.0-kb937287-X64.cab"
$win_vista_sp1_pre2_x86 = "windows6.0-kb935509-X86.cab"
$win_vista_sp1_pre2_x64 = "windows6.0-kb935509-X64.cab"
$win_vista_sp1_pre3_x86 = "windows6.0-kb937954-X86.cab"
$win_vista_sp1_pre3_x64 = "windows6.0-kb937954-X64.cab"
$win_vista_sp1_pre4_x86 = "windows6.0-kb938371-X86.cab"
$win_vista_sp1_pre4_x64 = "windows6.0-kb938371-X64.cab"

$win_vista_sp1_cab_x86 = "windows6.0-kb936330-X86.cab"
$win_vista_sp1_cab_x64 = "windows6.0-kb936330-X64.cab"
$folder_tmp_kb936330 = "$($folder_tmp)\windows6.0-kb936330"
$win_vista_sp1_update_mum = "update.mum"
$ddf

$folder_tmp_windows_vista_sp2 = "$($folder_tmp)\Windows Vista SP2"
$folder_cwd_windows_vista_sp2 = "$($folder_cwd_windows_vista)\Service Pack 2"

# Win Vista WAIK
$waik_iso_name = "6001.18000.080118-1840-kb3aikl_en"
$waik_iso = "$($waik_iso_name).iso"
$waik_tmp = "$($folder_tmp)\$waik_iso_name"
$waik_setup_x86 = "waikx86.msi"
$waik_setup_x64 = "waikamd64.msi"
$pkgmgr_x86 = "$($program_files)\Windows AIK\Tools\x86\Servicing\pkgmgr.exe"
$pkgmgr_x64 = "$($program_files)\Windows AIK\Tools\amd64\Servicing\pkgmgr.exe"
$etfsboot_x86 = "$($program_files)\Windows AIK\Tools\PETools\x86\boot\etfsboot.com"
$etfsboot_x64 = "$($program_files)\Windows AIK\Tools\PETools\amd64\boot\etfsboot.com"
$7zip_setup_x86_regex = ".exe"
$7zip_setup_x64_regex = "-x64.exe"
$7zip_setup_x86 = "7z-x86.exe"
$7zip_setup_x64 = "7z-x64.exe"


# Windows 7 Updates
$folder_cwd_windows7 = "$($PWD)\Windows 7"
$folder_cwd_windows7_updates = "$($folder_cwd_windows7)\Updates"

# Windows 7 IE11
$folder_cwd_windows7_ie11 = "$($folder_cwd_windows7)\Internet Explorer 11"
$folder_tmp_windows7_ie11 = "$($folder_tmp)\Windows 7 IE11"
$win7_ie11_x86 = "IE11-Windows6.1-x86-en-us.exe"
$win7_ie11_x64 = "IE11-Windows6.1-x64-en-us.exe"
$win7_ie11_support_x86 = "IE_SUPPORT_x86_en-US.CAB"
$win7_ie11_support_x64 = "IE_SUPPORT_amd64_en-US.CAB"
$win7_ie11_spelling = "IE-Spelling-en.msu"
$win7_ie11_hyphenation = "IE-Hyphenation-en.msu"
$win7_ie11_iewin7 = "IE-Win7.CAB"

# Win7 SP1
$folder_tmp_windows7_sp1 = "$($folder_tmp)\Windows 7 SP1"
$folder_cwd_windows7_sp1 = "$($folder_cwd_windows7)\Service Pack 1"
$win7_pre_sp1_x86 = "windows6.1-kb2533552-x86_f2061d1c40b34f88efbe55adf6803d278aa67064.msu"
$win7_pre_sp1_x64 = "windows6.1-kb2533552-x64_0ba5ac38d4e1c9588a1e53ad390d23c1e4ecd04d.msu"
$win7_sp1_exe_x86 = "windows6.1-kb976932-x86_c3516bc5c9e69fee6d9ac4f981f5b95977a8a2fa.exe"
$win7_sp1_exe_x64 = "windows6.1-kb976932-x64_74865ef2562006e51d7f9333b4a8d45b7a749dab.exe"
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

# ESU script
$folder_win7_esuscript = "$($PWD)\Windows 7\ESU Script"
$win7_esuscript_cmd = "$($folder_win7_esuscript)\ESU_Script.cmd"


### Choose architecture settings matching the OS ###

# For x86 32-bit systems
$oscdimg = $oscdimg_x86
$7zip = $7zip_86
$waik_setup = $waik_setup_x86
$pkgmgr = $pkgmgr_x86
$etfsboot = $etfsboot_x86
$7zip_setup_regex = $7zip_setup_x86_regex
$7zip_setup = $7zip_setup_x86

# For x86 64-bit systems
if ([Environment]::Is64BitProcess) {
    $oscdimg = $oscdimg_x64
	$7zip = $7zip_64
	$waik_setup = $waik_setup_x64
	$pkgmgr = $pkgmgr_x64
	$etfsboot = $etfsboot_x64
	$7zip_setup_regex = $7zip_setup_x64_regex
	$7zip_setup = $7zip_setup_x64
}

###############
## Functions ##
###############
function Unmount-ISO {
	if ($windows8_or_higher) {
		Write-Host " "
		Write-Host "Unmount ISO $($isoPath)"
		$isoDrive = Get-DiskImage -ImagePath "$($isoPath)"
		$isoDrive | Dismount-DiskImage | Out-Null
	}
}

function Mount-ISO {
	if ($windows8_or_higher) {
		Write-Host " "
		Write-Host "Mount ISO $($isoPath)"
		$isoDrive = Mount-DiskImage -ImagePath $isoPath -PassThru | Get-Volume
		
		### Get the DriveLetter currently assigned to the drive (a single [char])
		$isoLetter = ($isoDrive | Get-Volume).DriveLetter
		$script:isoDriveLetter = "$($isoLetter):\"
		Write-Host "ISO drive letter: $($isoDriveLetter)"
	} else {
		# Workaround since Windows 7 and below doesn't support the various disk functions
		Remove-Item "$($folder_windows_iso_tmp)" -Recurse -Force -Confirm:$false -ErrorAction SilentlyContinue
		
		& $7zip x $dvd_source_name -o"$($folder_windows_iso_tmp)"
		$script:isoDriveLetter = "$($folder_windows_iso_tmp)\"
		Write-Host "ISO drive letter: $($isoDriveLetter)"
	}
}

function Mount-Wim {
	Write-Host " "
	Write-Host "Mount WIM file ""$($folder_windows_iso)\sources\$($installFile)"" to ""$($folder_tmp)\mount"" "
	dism /mount-wim /wimfile:"$($folder_windows_iso)\sources\$($installFile)" /index:$selection /mountdir:"$($folder_tmp)\mount"
}

function Unmount-Image-Commit {
	Write-Host " "
	Write-Host "Unmount ""$($folder_tmp)\mount"" and commit"
	if ($windows8_or_higher) {
		dism /unmount-image /mountdir:"$($folder_tmp)\mount" /commit
	} else {
		dism /unmount-wim /mountdir:"$($folder_tmp)\mount" /commit
	}
}

function Unmount-Image-Discard-Cleanup {
	Write-Host " "
	Write-Host "Unmount ""$($folder_tmp)\mount"" and discard. Cleanup wim"
	if ($windows8_or_higher) {
		dism /unmount-image /mountdir:"$($folder_tmp)\mount" /discard
	} else {
		dism /unmount-wim /mountdir:"$($folder_tmp)\mount" /discard
	}
	dism /cleanup-wim
}

function Create-CAB-DDF([string]$RootDir, [string]$CurrentDir){
	# Add folder tag for subfolders (skip for root files)
	if($RootDir -ne $CurrentDir){
		$RootDirWithBackslash = "$($RootDir)\"
		$ddfDir = $CurrentDir -Replace [regex]::Escape($RootDirWithBackslash),""
		
		$script:ddf += ".Set DestinationDir=$($ddfDir)" #`r`n
	}
	
	# Add files to DDF
	$script:ddf+=(Get-ChildItem -Path "$CurrentDir" -Attributes !Directory -Name).ForEach({"""$($CurrentDir)\{0}""" -f $_}) #`r`n
	
	# Recursive call
	(Get-ChildItem -Path "$CurrentDir" -Attributes Directory -Name).ForEach({ Create-CAB-DDF "$($RootDir)" "$($CurrentDir)\$_" })
	
	# Run at the end in the original function call, so we only do it once
	if($RootDir -eq $CurrentDir){
		# The ForEach loop for the files adds a space on the start of each line, so lets remove them.
		$script:ddf = $script:ddf -Replace " `"C:","`"C:"
	}
	
	# Source: https://stackoverflow.com/questions/21652659/windows-cabinet-file-for-sub-directories
}


### Check for ISO
if(-Not ([System.IO.File]::Exists("$dvd_source_name"))){
	Write-Host " "
	Write-Host "Cannot find the ""$($dvd_source_name)"" file, the source Windows DVD image file."
	Write-Host "Please select an ISO file you want to use, name it ""$($dvd_source_name)"" and put it in the folder ""$($PWD)\""."
	Write-Host " "

	Exit
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
Unmount-ISO

### Mount ISO
Mount-ISO


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

	Unmount-ISO

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
	
	Unmount-ISO
	
	Exit
}

################################
### Windows version settings ###
################################
$dvd_windows_version_array
$dvd_architecture_array
$dvd_servicepack_level_array
if ($windows8_or_higher) {
	$dvd_windows_version_array = Dism /Get-ImageInfo /ImageFile:"$($isoDriveLetter)sources\$($installFile)" /index:$selection | Select-String "Name : Windows"
	$dvd_architecture_array = Dism /Get-ImageInfo /ImageFile:"$($isoDriveLetter)sources\$($installFile)" /index:$selection | Select-String "Architecture : "
	$dvd_servicepack_level_array = Dism /Get-ImageInfo /ImageFile:"$($isoDriveLetter)sources\$($installFile)" /index:$selection | Select-String "ServicePack Level : "
} else {
	$dvd_windows_version_array = Dism /Get-WimInfo /wimfile:"$($isoDriveLetter)sources\$($installFile)" /index:$selection | Select-String "Name : Windows"
	$dvd_architecture_array = Dism /Get-WimInfo /wimfile:"$($isoDriveLetter)sources\$($installFile)" /index:$selection | Select-String "Architecture : "
	$dvd_servicepack_level_array = Dism /Get-WimInfo /wimfile:"$($isoDriveLetter)sources\$($installFile)" /index:$selection | Select-String "ServicePack Level : "
}

# Trim the start of the string array and save as string
$dvd_windows_version = $dvd_windows_version_array[0] -Replace "Name : ",""
$dvd_architecture = $dvd_architecture_array[0] -Replace "Architecture : ",""
$dvd_servicepack_level = $dvd_servicepack_level_array[0] -Replace "ServicePack Level : ",""

# Add DVD Windows name to target ISO name
$dvd_target_name = "$($dvd_windows_version) $($dvd_architecture).iso"

Write-Host " "
Write-Host "Name: $($dvd_windows_version)"
Write-Host "Architecture: $($dvd_architecture)"
Write-Host "ServicePack Level: $($dvd_servicepack_level)"

$dvd_version_win_vista = "vista"
$dvd_version_win_vista_name = "Windows Vista"
$dvd_version_win7 = "7"
$dvd_version_win7_name = "Windows 7"
$dvd_version_win10 = "10"
$dvd_version_win10_name = "Windows 10"
$dvd_version_win11 = "11"
$dvd_version_win11_name = "Windows 11"

if ("$($dvd_windows_version)" -like "*$($dvd_version_win_vista_name)*"){
    $dvd_windows_version = $dvd_version_win_vista
} elseif ("$($dvd_windows_version)" -like "*$($dvd_version_win7_name)*"){
    $dvd_windows_version = $dvd_version_win7
} elseif ("$($dvd_windows_version)" -like "*$($dvd_version_win10_name)*"){
    $dvd_windows_version = $dvd_version_win10
} elseif ("$($dvd_windows_version)" -like "*$($dvd_version_win11_name)*"){
    $dvd_windows_version = $dvd_version_win11
} else {
	Write-Host " "
	Write-Host "Unsupported Windows version!"
	Write-Host " "
	
	Unmount-ISO
	
	exit
}

### Choose architecture to match DVD/ISO architecture ###

# For x86 32-bit systems
$win_vista_pre1_sp1 = $win_vista_pre1_sp1_x86
$win_vista_pre2_sp1 = $win_vista_pre2_sp1_x86
$win_vista_pre3_sp1 = $win_vista_pre3_sp1_x86
$win_vista_pre4_sp1 = $win_vista_pre4_sp1_x86
$win_vista_pre1_sp1_cab = $win_vista_pre1_sp1_x86_cab
$win_vista_pre2_sp1_cab = $win_vista_pre2_sp1_x86_cab
$win_vista_pre3_sp1_cab = $win_vista_pre3_sp1_x86_cab
$win_vista_pre4_sp1_cab = $win_vista_pre4_sp1_x86_cab
$win_vista_sp1_exe = $win_vista_sp1_exe_x86
$win_vista_sp1_pre1 = $win_vista_sp1_pre1_x86
$win_vista_sp1_pre2 = $win_vista_sp1_pre2_x86
$win_vista_sp1_pre3 = $win_vista_sp1_pre3_x86
$win_vista_sp1_pre4 = $win_vista_sp1_pre4_x86
$win_vista_sp1_cab = $win_vista_sp1_cab_x86

$win7_sp1_exe = $win7_sp1_exe_x86
$win7_sp1_cab = $win7_sp1_cab_x86
$win7_pre_sp1 = $win7_pre_sp1_x86
$win7_ie11 = $win7_ie11_x86
$win7_ie11_support = $win7_ie11_support_x86

# For x86 64-bit systems
if ($dvd_architecture -eq "x64") {
	$win_vista_pre1_sp1 = $win_vista_pre1_sp1_x64
	$win_vista_pre2_sp1 = $win_vista_pre2_sp1_x64
	$win_vista_pre3_sp1 = $win_vista_pre3_sp1_x64
	$win_vista_pre4_sp1 = $win_vista_pre4_sp1_x64
	$win_vista_pre1_sp1_cab = $win_vista_pre1_sp1_x64_cab
	$win_vista_pre2_sp1_cab = $win_vista_pre2_sp1_x64_cab
	$win_vista_pre3_sp1_cab = $win_vista_pre3_sp1_x64_cab
	$win_vista_pre4_sp1_cab = $win_vista_pre4_sp1_x64_cab
	$win_vista_sp1_exe = $win_vista_sp1_exe_x64
	$win_vista_sp1_pre1 = $win_vista_sp1_pre1_x64
	$win_vista_sp1_pre2 = $win_vista_sp1_pre2_x64
	$win_vista_sp1_pre3 = $win_vista_sp1_pre3_x64
	$win_vista_sp1_pre4 = $win_vista_sp1_pre4_x64
	$win_vista_sp1_cab = $win_vista_sp1_cab_x64
	
	$win7_sp1_exe = $win7_sp1_exe_x64
	$win7_sp1_cab = $win7_sp1_cab_x64
	$win7_pre_sp1 = $win7_pre_sp1_x64
	$win7_ie11 = $win7_ie11_x64
	$win7_ie11_support = $win7_ie11_support_x64
}


##################################
### File and folder operations ###
##################################

### Unmount WIM images
Unmount-Image-Discard-Cleanup

### Delete old files and folders
Write-Host " "
Write-Host "Delete old files and folders. (This can take a while due to many small files!)"
if(Test-Path -Path "$($folder_tmp)"){
	attrib -r -h "$($folder_tmp)" /s /d
	Remove-Item "$($folder_tmp)" -Recurse -Force -Confirm:$false -ErrorAction SilentlyContinue
}

### Delete old ISOs with the version in the name
Remove-Item "$($PWD)\$($dvd_target_name)" -Force -Confirm:$false -ErrorAction SilentlyContinue

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

### Create folders
if ($dvd_windows_version -eq $dvd_version_win_vista) {
	# Windows 7
	if(-Not (Test-Path -Path "$folder_cwd_windows_vista_sp1")){
		mkdir "$($folder_cwd_windows_vista_sp1)"
		
		Write-Host " "
		Write-Host "The folder ""$($folder_cwd_windows_vista_sp1)"" was missing and has been created."
		Write-Host "Please put the Windows Vista Service Pack 1 files here if you need to add SP1."
		Write-Host "It must match the ISO architecture $($dvd_architecture)!"
		Write-Host " "
		Write-Host "Press any key to continue!"
		Write-Host " "
		
		Pause
	}
} elseif ($dvd_windows_version -eq $dvd_version_win7) {
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

if(-Not (Test-Path -Path "$folder_copy_to_iso")){
	mkdir "$($folder_copy_to_iso)"
		
		Write-Host " "
		Write-Host "The folder ""$($folder_copy_to_iso)"" was missing and has been created."
		Write-Host "Any files or folders you put here will be copied onto the finished ISO"
		Write-Host " "
		Write-Host "Press any key to continue!"
		Write-Host " "
		
		Pause
}

Write-Host " "
Write-Host "Creating the '$($folder_tmp)', '$($folder_windows_iso)' and '$($folder_tmp)\mount' folders"
mkdir "$($folder_windows_iso)"
mkdir "$($folder_tmp)\mount"

### Copy CD content to the tmp\win_dvd folder
if ($windows8_or_higher) {
	Write-Host " "
	Write-Host "Copy Windows DVD files from '$($isoDriveLetter)' to '$($folder_windows_iso)' (This takes a while!)"
	Copy-item -Force -Recurse "$($isoDriveLetter)*" -Destination "$($folder_windows_iso)" #-Verbose
} else {
	Write-Host " "
	Write-Host "Move Windows DVD files from '$($isoDriveLetter)' to '$($folder_windows_iso)'"
	Get-ChildItem -Path "$($isoDriveLetter)" -Recurse | Move-Item -Destination $($folder_windows_iso)
}

### Unmount ISO
Unmount-ISO

### Copy DVD folder with custom content
if(Test-Path -Path "$folder_copy_to_iso"){
	Write-Host " "
	Write-Host "Copying the ""$folder_copy_to_iso"" folder to ""$($folder_windows_iso)"". It will be included in the finished ISO."
	Copy-item -Force -Recurse "$folder_copy_to_iso\*" -Destination "$($folder_windows_iso)\"
}

### Read Write permissions
attrib -r -h "$($folder_tmp)\*.*" /s /d

if ($windows8_or_higher) {
# Remove the other Windows versions in the install image, from last to first to avoid index numbering issues
	Write-Host " "
	Write-Host "Remove the images not to be updated from the $($folder_windows_iso)\sources\$($installFile) file."
	for($i=$dvd_windows_info_index_trimmed.count-1;$i -ge 0; $i--){
		$info_index = $dvd_windows_info_index_trimmed[$i]
		
		if($info_index -ne $selection){
			Write-Host "Remove the $($dvd_windows_list[$info_index]) image with index number $($info_index)."
			Remove-WindowsImage -ImagePath "$($folder_windows_iso)\sources\$($installFile)" -Index $info_index -CheckIntegrity
		}
	}
	#Reset selection since there is now only one image in the install image
	$selection = 1
}


##################
### ESU Script ###
##################
Write-Host " "
if ($dvd_windows_version -eq $dvd_version_win7 -And [System.IO.File]::Exists($win7_esuscript_cmd)) {
	# Mount
	Mount-Wim
	
	$esu_msg_start = "Running the ESU script ""$($win7_esuscript_cmd)""
- $($installFile): $($folder_windows_iso)\sources\$($installFile)	
- Mounted directory: $($folder_tmp)\mount
 "
	$esu_msg_stop = " 
Press any key to continue once the ESU script has finished!
 "

	Write-Host " "
	Write-Host "$($esu_msg_start)"

	# Execute the ESU script
	Start-Process "$($win7_esuscript_cmd)" -Wait
	
	Write-Host "$($esu_msg_stop)"
	
	# Write message to txt file and open in notepad
	echo "$($esu_msg_start)$($esu_msg_stop)" | Out-File -FilePath "$($folder_win7_esuscript)\esu_msg.txt"
	Start-Process notepad "$($folder_win7_esuscript)\esu_msg.txt" -WindowStyle normal
	
	# Pause so the script can complete before unmounting 
	Pause
	
	# Unmount
	Unmount-Image-Commit
} else {
	Write-Host " "
	Write-Host "The script ""$($win7_esuscript_cmd)"" was not found. Skipping it!"
	Write-Host " "
}


######################################
### Windows Vista - Service Pack 1 ###
######################################
# Unpack Service Pack 1 if it's Windows Vista, has Service Pack Level 0 and the service pack file exists
if ($dvd_windows_version -eq $dvd_version_win_vista -And ($dvd_servicepack_level -eq "0" -Or $dvd_servicepack_level -eq "<undefined>") -And [System.IO.File]::Exists("$($folder_cwd_windows_vista_sp1)\$($win_vista_sp1_exe)")) {
	Write-Host " "
	Write-Host "#########################"
	Write-Host "####### WARNING! ########"
	Write-Host "#########################"
	Write-Host " "
	Write-Host "Slipstreaming Service Pack 1 onto Windows Vista hasn't worked so far!"
	Write-Host "I would suggest downloading an ISO with SP1 already, or slipstream it with vLite."
	Write-Host "Press any key to continue and try anyway..."
	Write-Host " "
	
	Pause
	
	Write-Host " "
	Write-Host "Create the folder: $($folder_tmp_windows_vista_sp1)"
	mkdir "$($folder_tmp_windows_vista_sp1)"
	
	Write-Host "Create the folder: $($folder_tmp_kb936330)"
	mkdir "$($folder_tmp_kb936330)"

	# Extract SP1 Prerequisite CABs from MSUs
	Start-Process "$($7zip)" -ArgumentList @("x `"$($folder_cwd_windows_vista_sp1)\$($win_vista_pre1_sp1)`" -o`"$($folder_tmp_windows_vista_sp1_pre)`" `"$($win_vista_pre1_sp1_cab)`"") -NoNewWindow -Wait
	Start-Process "$($7zip)" -ArgumentList @("x `"$($folder_cwd_windows_vista_sp1)\$($win_vista_pre2_sp1)`" -o`"$($folder_tmp_windows_vista_sp1_pre)`" `"$($win_vista_pre2_sp1_cab)`"") -NoNewWindow -Wait
	Start-Process "$($7zip)" -ArgumentList @("x `"$($folder_cwd_windows_vista_sp1)\$($win_vista_pre3_sp1)`" -o`"$($folder_tmp_windows_vista_sp1_pre)`" `"$($win_vista_pre3_sp1_cab)`"") -NoNewWindow -Wait
	Start-Process "$($7zip)" -ArgumentList @("x `"$($folder_cwd_windows_vista_sp1)\$($win_vista_pre4_sp1)`" -o`"$($folder_tmp_windows_vista_sp1_pre)`" `"$($win_vista_pre4_sp1_cab)`"") -NoNewWindow -Wait


	# Extract SP1 exe
	Write-Host " "
	Write-Host "The command: Start-Process ""$($folder_cwd_windows_vista_sp1)\$($win_vista_sp1_exe)"" -ArgumentList @(""/X:`"$($folder_tmp_windows_vista_sp1)`""") -NoNewWindow -Wait "
	Start-Process "$($folder_cwd_windows_vista_sp1)\$($win_vista_sp1_exe)" -ArgumentList @("/X:`"$($folder_tmp_windows_vista_sp1)`"") -NoNewWindow -Wait
	
	# Extract windows6.1-KB976932-X__.cab
	try { 
		Write-Host " "
		Write-Host "Start-Process ""$($expand_exe)"" -ArgumentList @(""-F:*"",""`"$($folder_tmp_windows_vista_sp1)\$($win_vista_sp1_cab)`""",""`"$($folder_tmp_kb936330)`""") -NoNewWindow -Wait"
		Start-Process "$($expand_exe)" -ArgumentList @("-F:*","`"$($folder_tmp_windows_vista_sp1)\$($win_vista_sp1_cab)`"","`"$($folder_tmp_kb936330)`"") -NoNewWindow -Wait
	} catch { 
		Write-host "An error occurred while extracting ""$($folder_tmp_windows_vista_sp1)\$($win_vista_sp1_cab)"" to ""$($folder_tmp_kb936330)""."
	}

	## Update update.mum ##
	[xml]$xmlDoc = Get-Content "$($folder_tmp_kb936330)\$($win_vista_sp1_update_mum)"
	Write-Host " "
	Write-Host "update.mum"
	Write-Host "allowedOffline: $($xmlDoc.assembly.package.packageExtended.allowedOffline)"
	$xmlDoc.assembly.package.packageExtended.allowedOffline = "true"
	$xmlDoc.Save("$($folder_tmp_kb936330)\$($win_vista_sp1_update_mum)")
	
	## Recreate CAB
	Write-Host " "
	Write-Host "Recreate CAB ""$($folder_tmp_windows_vista_sp1)\$($win_vista_sp1_cab) """

	Write-Host " "
	Write-Host "Populate DDF variable with the files and folders from ""$($folder_tmp_kb936330)"""
	Create-CAB-DDF "$($folder_tmp_kb936330)" "$($folder_tmp_kb936330)"
	
	Write-Host " "
	Write-Host "Write DDF content to the file ""$($folder_tmp)\files.txt"""
	$ddf | Out-File "$($folder_tmp)\files.ddf" -Encoding Ascii # IT'S REALLY IMPORTANT that we generate an ASCII (ANSI) text file. UTF8 causes errors
	
	# Change to TMP folder so that makecab puts temp files there
	$originalPWD = "$($PWD)"
	cd "$($folder_tmp)"
	
	Write-Host "The command: makecab /f ""$($folder_tmp)\files.ddf"""
	makecab /D CabinetNameTemplate="Updated_$($win_vista_sp1_cab)" /D DiskDirectory1="$($folder_tmp)" /D MaxDiskSize=0 /D Cabinet=on /D Compress=on /D CompressionType=MSZIP /f "$($folder_tmp)\files.ddf"
	
	# Change back to the original root folder / PWD
	cd "$($originalPWD)"
	
	# Sources: https://msfn.org/board/topic/116725-tutorial-how-to-slipstream-vista-sp1-into-vista-rtm-using-waik/
	#          https://stackoverflow.com/questions/45306085/convert-text-file-to-ansi-format
}

##################################
### Windows 7 - Service Pack 1 ###
##################################
# Unpack Service Pack 1 if it's Windows 7, has Service Pack Level 0 and the service pack file exists
if ($dvd_windows_version -eq $dvd_version_win7 -And $dvd_servicepack_level -eq "0" -And [System.IO.File]::Exists("$($folder_cwd_windows7_sp1)\$($win7_sp1_exe)")) {
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
		Write-host "An error occurred while extracting ""$($folder_tmp_windows7_sp1)\$($win7_sp1_cab)"" to ""$($folder_tmp_windows7_sp1)""."
	}

	# Extract NestedMPPContent.cab
	try { 
		Write-Host " "
		Write-Host "The command: $($expand_exe) -F:* ""$($folder_tmp_windows7_sp1)\$($win7_sp1_NestedMPPContent_cab)"" ""$($folder_tmp_windows7_sp1)"""
		Write-Host " "
		cmd.exe /c "$($expand_exe) -F:* ""$($folder_tmp_windows7_sp1)\$($win7_sp1_NestedMPPContent_cab)"" ""$($folder_tmp_windows7_sp1)"""
	} catch { 
		Write-host "An error occurred while extracting ""$($folder_tmp_windows7_sp1)\$($win7_sp1_NestedMPPContent_cab)"" to ""$($folder_tmp_windows7_sp1)""."
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
		Write-host "An error occurred while extracting the file."
	}
}

######################################
## Windows 7 - Internet Explorer 11 ##
######################################
if ($dvd_windows_version -eq $dvd_version_win7 -And [System.IO.File]::Exists("$($folder_cwd_windows7_ie11)\$($win7_ie11)")) {
	Write-Host " "
	Write-Host "Prepare Internet Explorer 11 files"
	Write-Host "CWD Folder & File: $($folder_cwd_windows7_ie11)\$($win7_ie11)"
	Write-Host "TMP Folder: $($folder_tmp_windows7_ie11)"
	
	mkdir "$($folder_tmp_windows7_ie11)"
	
	# Extract SP1
	Start-Process "$($folder_cwd_windows7_ie11)\$($win7_ie11)" -ArgumentList @("-x:""$($folder_tmp_windows7_ie11)""") -NoNewWindow -Wait
}


######################
### Update Windows ###
######################

# Mount install.wim
Mount-Wim

### Windows Vista Service Pack 1 ###
# Install Service Pack 1 if it's Windows 7, has Service Pack Level 0 and the service pack file exists
if ($dvd_windows_version -eq $dvd_version_win_vista -And ($dvd_servicepack_level -eq "0" -Or $dvd_servicepack_level -eq "<undefined>") -And [System.IO.File]::Exists("$($folder_cwd_windows_vista_sp1)\$($win_vista_sp1_exe)")) {
	$sandbox = "$($folder_tmp)\win_vista_sp1_sandbox"
	mkdir "$($sandbox)"
	
	if (![System.IO.File]::Exists($pkgmgr)) {
		if (![System.IO.File]::Exists($7zip)) {
			Write-Host " "
			Write-Host "Downloading and installing 7zip"
			Write-Host "We need 7zip to extract ""$($waik_setup)"" from the file ""$($waik_iso)"" we will download next."
			
			Pause
			
			# Download setup
			if (![System.IO.File]::Exists("$($PWD)\$($7zip_setup)")) {
				# Find latest version of 7zip (Source: https://www.reddit.com/r/PowerShell/comments/9gwbed/scrape_7zip_website_for_the_latest_version/)
				$data = Invoke-webrequest -Uri "https://www.7-zip.org/download.html" -UseBasicParsing
				$link = $data.links | Where href -like "*$($7zip_setup_regex)" | Sort-Object {$null = $_.href -match "a\/7z(\d{3,4})\$($7zip_setup_regex)";[int]$Matches[1] } -Descending | Select Select -First 1 | Select href
				$url = "https://www.7-zip.org/$($link.href)"
				$filename = $url -replace '.*\/' 
				Write-Host " "
				Write-Host "Downloading $($url)"
				Write-Host "The file will be renamed from ""$($filename)"" to ""$($7zip_setup)"" "
				Invoke-WebRequest "$($url)" -OutFile $7zip_setup
			}
			
			Write-Host "Installing 7zip, will continue once completed."
			Start-Process "$7zip_setup" -Wait
			
			Pause
		}
		
		Write-Host " "
		Write-Host "Installing Windows AIK in order to get it's pkgmgr.exe, required for Windows Vista SP1 integration."
		Write-Host "Be aware that the ISO file downloaded is 1.34GB in size, while the setup file itself is 100-200MB."
		
		Write-Host " "
		Write-Host "1. Downloading: ""$($waik_iso)"""
		Write-Host "2. Extracting ""$($waik_iso)"" to ""$($waik_tmp)"""
		Write-Host "3. Running the WAIK setup file ""$($waik_tmp)\$($waik_setup)"""
		Write-Host " "
		Write-Host ">>> NOTE! You will have to complete the setup manually when it starts!!! <<<"
		Write-Host " "
		
		Pause

		# Download setup
		if (![System.IO.File]::Exists("$($PWD)\$($waik_iso)")) {
			Write-Host "Download missing $($waik_iso) setup ISO file"
			Invoke-WebRequest https://download.microsoft.com/download/9/c/d/9cdfa30e-5901-40e4-b6bf-4a0086ea0a6a/6001.18000.080118-1840-kb3aikl_en.iso -OutFile $waik_iso
		}

		Write-Host "The command: Start-Process ""$($7zip)"" -ArgumentList @(""x `"$waik_iso`" -o`"$($waik_tmp)`""") -NoNewWindow -Wait"
		Start-Process "$($7zip)" -ArgumentList @("x `"$waik_iso`" -o`"$($waik_tmp)`"") -NoNewWindow -Wait
		
		Write-Host "The command: Start-Process msiexec -ArgumentList @(""/i `"$($waik_tmp)\$($waik_setup)`""") -Wait"
		Start-Process msiexec -ArgumentList @("/i `"$($waik_tmp)\$($waik_setup)`"") -Wait
		
		Write-Host " "
		Write-Host "Finished installing Windows AIK (assuming you completed it)."
	}

	Write-Host " "
	Write-Host "Install Windows Vista SP1 Prerequisites"
	
	Write-Host "The command: Start-Process ""$($pkgmgr)"" -ArgumentList @(""/ip /m:`"$($folder_tmp_windows_vista_sp1_pre)\$($win_vista_pre1_sp1_cab)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`""") -NoNewWindow -Wait"
	Start-Process "$($pkgmgr)" -ArgumentList @("/ip /m:`"$($folder_tmp_windows_vista_sp1_pre)\$($win_vista_pre1_sp1_cab)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`" /l:log_pkgmgr.txt") -NoNewWindow -Wait
	Remove-Item "`"$($sandbox)\*`"" -Force -Confirm:$false -ErrorAction SilentlyContinue

	Write-Host "The command: Start-Process ""$($pkgmgr)"" -ArgumentList @(""/ip /m:`"$($folder_tmp_windows_vista_sp1_pre)\$($win_vista_pre2_sp1_cab)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`""") -NoNewWindow -Wait"
	Start-Process "$($pkgmgr)" -ArgumentList @("/ip /m:`"$($folder_tmp_windows_vista_sp1_pre)\$($win_vista_pre2_sp1_cab)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`" /l:log_pkgmgr.txt") -NoNewWindow -Wait
	Remove-Item "`"$($sandbox)\*`"" -Force -Confirm:$false -ErrorAction SilentlyContinue

	Write-Host "The command: Start-Process ""$($pkgmgr)"" -ArgumentList @(""/ip /m:`"$($folder_tmp_windows_vista_sp1_pre)\$($win_vista_pre3_sp1_cab)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`""") -NoNewWindow -Wait"
	Start-Process "$($pkgmgr)" -ArgumentList @("/ip /m:`"$($folder_tmp_windows_vista_sp1_pre)\$($win_vista_pre3_sp1_cab)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`" /l:log_pkgmgr.txt") -NoNewWindow -Wait
	Remove-Item "`"$($sandbox)\*`"" -Force -Confirm:$false -ErrorAction SilentlyContinue
	
	Write-Host "The command: Start-Process ""$($pkgmgr)"" -ArgumentList @(""/ip /m:`"$($folder_tmp_windows_vista_sp1_pre)\$($win_vista_pre4_sp1_cab)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`""") -NoNewWindow -Wait"
	Start-Process "$($pkgmgr)" -ArgumentList @("/ip /m:`"$($folder_tmp_windows_vista_sp1_pre)\$($win_vista_pre4_sp1_cab)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`" /l:log_pkgmgr.txt") -NoNewWindow -Wait
	Remove-Item "`"$($sandbox)\*`"" -Force -Confirm:$false -ErrorAction SilentlyContinue
	
	
	Write-Host " "
	Write-Host "Install Windows Vista SP1 (4 smaller cabs and then the main SP1 cab itself)"
	
	Write-Host " "
	Write-Host "The command: Start-Process ""$($pkgmgr)"" -ArgumentList @(""/ip /m:`"$($folder_tmp_windows_vista_sp1)\$($win_vista_sp1_pre1)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`""") -NoNewWindow -Wait"
	Start-Process "$($pkgmgr)" -ArgumentList @("/ip /m:`"$($folder_tmp_windows_vista_sp1)\$($win_vista_sp1_pre1)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`" /l:log_pkgmgr.txt") -NoNewWindow -Wait
	Remove-Item "`"$($sandbox)\*`"" -Force -Confirm:$false -ErrorAction SilentlyContinue
	
	Write-Host " "
	Write-Host "The command: Start-Process ""$($pkgmgr)"" -ArgumentList @(""/ip /m:`"$($folder_tmp_windows_vista_sp1)\$($win_vista_sp1_pre2)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`""") -NoNewWindow -Wait"
	Start-Process "$($pkgmgr)" -ArgumentList @("/ip /m:`"$($folder_tmp_windows_vista_sp1)\$($win_vista_sp1_pre2)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`" /l:log_pkgmgr.txt") -NoNewWindow -Wait
	Remove-Item "`"$($sandbox)\*`"" -Force -Confirm:$false -ErrorAction SilentlyContinue
	
	Write-Host " "
	Write-Host "The command: Start-Process ""$($pkgmgr)"" -ArgumentList @(""/ip /m:`"$($folder_tmp_windows_vista_sp1)\$($win_vista_sp1_pre3)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`""") -NoNewWindow -Wait"
	Start-Process "$($pkgmgr)" -ArgumentList @("/ip /m:`"$($folder_tmp_windows_vista_sp1)\$($win_vista_sp1_pre3)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`" /l:log_pkgmgr.txt") -NoNewWindow -Wait
	Remove-Item "`"$($sandbox)\*`"" -Force -Confirm:$false -ErrorAction SilentlyContinue
	
	Write-Host " "
	Write-Host "The command: Start-Process ""$($pkgmgr)"" -ArgumentList @(""/ip /m:`"$($folder_tmp_windows_vista_sp1)\$($win_vista_sp1_pre4)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`""") -NoNewWindow -Wait"
	Start-Process "$($pkgmgr)" -ArgumentList @("/ip /m:`"$($folder_tmp_windows_vista_sp1)\$($win_vista_sp1_pre4)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`" /l:log_pkgmgr.txt") -NoNewWindow -Wait
	Remove-Item "`"$($sandbox)\*`"" -Force -Confirm:$false -ErrorAction SilentlyContinue
	
	Write-Host " "
	Write-Host "The command: Start-Process ""$($pkgmgr)"" -ArgumentList @(""/ip /m:`"$($folder_tmp)\Updated_$($win_vista_sp1_cab)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`""") -NoNewWindow -Wait"
	Start-Process "$($pkgmgr)" -ArgumentList @("/ip /m:`"$($folder_tmp)\Updated_$($win_vista_sp1_cab)`" /o:`"$($folder_tmp)\mount;$($folder_tmp)\mount\Windows`" /s:`"$($sandbox)`"") -NoNewWindow -Wait
	Remove-Item "`"$($sandbox)\*`"" -Force -Confirm:$false -ErrorAction SilentlyContinue
	
	# Sources: 
	# - https://davestechnology.blogspot.com/2014/06/manually-install-msu-or-cab-files.html
	# - https://msfn.org/board/topic/116725-tutorial-how-to-slipstream-vista-sp1-into-vista-rtm-using-waik/
	# - https://www.microsoft.com/nb-no/download/details.aspx?id=9085
	# - https://download.microsoft.com/download/9/c/d/9cdfa30e-5901-40e4-b6bf-4a0086ea0a6a/6001.18000.080118-1840-kb3aikl_en.iso
}

### Windows 7 Service Pack 1 ###
# Install Service Pack 1 if it's Windows 7, has Service Pack Level 0 and the service pack file exists
if ($dvd_windows_version -eq $dvd_version_win7 -And $dvd_servicepack_level -eq "0" -And [System.IO.File]::Exists("$($folder_cwd_windows7_sp1)\$($win7_sp1_exe)")) {
	Write-Host " "
	Write-Host "Update ""$($folder_tmp)\mount"" with the update ""$($folder_cwd_windows7_sp1)\$($win7_pre_sp1)"""
	Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($folder_cwd_windows7_sp1)\$($win7_pre_sp1)"

	Write-Host " "
	Write-Host "Update ""$($folder_tmp)\mount"" with the updates from ""$($folder_tmp_windows7_sp1)"" (This can take a while!!!)"
	Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($folder_tmp_windows7_sp1)"
}


### Windows Updates ###
if ($dvd_windows_version -eq $dvd_version_win_vista) {
	Write-Host " "
	Write-Host "Windows Vista updates"
	Write-Host "TBD"
} elseif ($dvd_windows_version -eq $dvd_version_win7) {
	## Windows 7 ##
	
	# Updates - Subfolders
	Get-ChildItem -Directory -Path "$($folder_cwd_windows7_updates)" | ForEach-Object {
		# Check that update folder is not empty
		if (Test-Path "$($_.FullName)\*") {
			Write-Host " "
			Write-Host "Slipstream updates in the subfolder ""$($_.FullName)"" (This can take a while!!! Ignore missmatch errors!)"
			Write-Host "Dism /Image:""$($folder_tmp)\mount"" /Add-Package /PackagePath:""$($_.FullName)"""
			Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($_.FullName)"
		}
	}
	
	# Updates - Root folder
	if (Test-Path "$($folder_cwd_windows7_updates)\*") {
		Write-Host " "
		Write-Host "Slipstream updates (This can take a while!!! Ignore missmatch errors!)"
		Write-Host "Dism /Image:""$($folder_tmp)\mount"" /Add-Package /PackagePath:""$($folder_cwd_windows7_updates)"""
		Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($folder_cwd_windows7_updates)"
	}
	
	# Internet Explorer 11
	if (Test-Path "$($folder_cwd_windows7_ie11)\*") {
		Write-Host " "
		Write-Host "Slipstream Internet Explorer 11 Prerequisites"
		Write-Host "Dism /Image:""$($folder_tmp)\mount"" /Add-Package /PackagePath:""$($folder_cwd_windows7_ie11)"""
		Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($folder_cwd_windows7_ie11)"
		
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
	}
} else {
	# All other versions of Windows
	Get-ChildItem -Directory -Path "$($folder_cwd_windows_updates)" | ForEach-Object {
		# Check that update folder is not empty
		if (Test-Path "$($_.FullName)\*") {
			Write-Host " "
			Write-Host "Slipstream updates in the subfolder ""$($_.FullName)"" (This can take a while!!! Ignore missmatch errors!)"
			Write-Host "Dism /Image:""$($folder_tmp)\mount"" /Add-Package /PackagePath:""$($_.FullName)"""
			Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($_.FullName)"
		}
	}
	
	# Check that update folder is not empty
	if (Test-Path "$($folder_cwd_windows_updates)\*") {
		Write-Host " "
		Write-Host "Slipstream updates (This can take a while!!! Ignore missmatch errors!)"
		Write-Host "Dism /Image:""$($folder_tmp)\mount"" /Add-Package /PackagePath:""$($folder_cwd_windows_updates)"""
		Dism /Image:"$($folder_tmp)\mount" /Add-Package /PackagePath:"$($folder_cwd_windows_updates)"
	}
}

# Unmount and commit changes to install.wim
Unmount-Image-Commit

###################
### Create ISOs ###
###################
if ($dvd_windows_version -eq $dvd_version_win_vista) {
	# Windows Vista ISO
	if(([System.IO.File]::Exists("$($folder_windows_iso)\boot\etfsboot.com"))){
		# Use ISOs etfsboot if it exists
		& $oscdimg -m -o -h -u2 -udfver102 -b"$($folder_windows_iso)\boot\etfsboot.com" "$($folder_windows_iso)" "$($PWD)\$($dvd_target_name)"
	} else {
		# Use WAIKs etfsboot as fallback
		& $oscdimg -m -o -h -u2 -udfver102 -b"$($etfsboot)" "$($folder_windows_iso)" "$($PWD)\$($dvd_target_name)"
	}
} elseif ($dvd_windows_version -eq $dvd_version_win7) {
	# Windows 7 ISO
	& $oscdimg -m -o -h -u2 -udfver102 -b"$($folder_windows_iso)\boot\etfsboot.com" "$($folder_windows_iso)" "$($PWD)\$($dvd_target_name)"
} else {
	# ISO for all other versions of Windows (10 and 11 should work)
	& $oscdimg -m -o -u2 -udfver102 -bootdata:2#p0,e,b"$($folder_windows_iso)\boot\etfsboot.com"#pEF,e,b"$($folder_windows_iso)\efi\microsoft\boot\efisys.bin" "$($folder_windows_iso)" "$($PWD)\$($dvd_target_name)"
}

### Finished
Write-Host " "
Write-Host "Finished creating the Windows ISOs!"
Write-Host "Windows DVD: $($PWD)\$($dvd_target_name)"


Write-Host " "
Write-Host "End logging"
Stop-Transcript

