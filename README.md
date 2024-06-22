# Update Windows.iso with Windows Updates (Mainly Windows 7)

This script was made firstly with Windows 7 in mind, and is what I have tested it with.

Slipstreaming Windows 10 and 11 updates and producing a bootable ISO should also be possible, but not tested yet.

# Required files

## Windows 7

You will only need to download the files that matches the architecture of the DVD you choose (x86 or x64).
<br>The following lists of files will contain both!

### Windows 7 ISOs
These are just some file suggestions on what to [use/google for on archive sites](https://archive.org/search?query=x17-59186.iso) and such.
<br>Feel free to use other ISOs.

Use the ISO/DVD that matches the CD-keys/license you have.
<br>There are no CD-keys etc here!

| Windows version | Service Pack | Filename | SHA1 |
| --- | --- | --- | --- |
| Windows 7 Professional x64 English | SP1 | x17-59186.iso | 0bcfc54019ea175b1ee51f6d2b207a3d14dd2b58 |
| Windows 7 Professional x86 English | SP1 | x17-59183.iso | d89937df3a9bc2ec1a1486195fd308cd3dade928 |
| Windows 7 Home Premium x64 English | SP1 | x17-58997.iso | 6c9058389c1e2e5122b7c933275f963edf1c07b9 | 
| Windows 7 Home Premium x86 English | SP1 | x17-58996.iso | 6071b4553fcf0ea53d589a846b5ae76743dd68fc | 
| Windows 7 Ultimate x64 English | SP1 | X17-59465.iso | 36ae90defbad9d9539e649b193ae573b77a71c83 |

### Windows 7 Updates
I would recommend using an ISO from Microsoft where SP1 is already integrated. Alternatively follow the instructions below.

For Windows Updates, I would recommend adding the update files in the following folder structure.
- <b>windows7_updates</b>
	- <b>01</b>
		- windows6.1-kb3020369-***.msu
	- <b>02</b> 
		- windows6.1-kb3125574-v4-***.msu
	- <b>03</b> 
		- windows6.1-kb4056894-***.msu
- <b>windows7_ie11</b>
	- Internet Explorer 11 + Prerequisites files

#### Service Pack 1 (KB976932)
If you want to slipstream Service Pack 1 onto an ISO without Service Pack 1 on it already, download both files matching the architecture of the Windows.ISO file.

Download the SP1 files to the folder <b>windows7_sp1</b>, create it if missing in the same folder as this README file and the script files.

| Architecture | Filename / Link |
| --- | --- | --- | 
| x86 | [windows6.1-kb2533552-x86_f2061d1c40b34f88efbe55adf6803d278aa67064.msu](http://download.windowsupdate.com/msdownload/update/software/crup/2011/05/windows6.1-kb2533552-x86_f2061d1c40b34f88efbe55adf6803d278aa67064.msu) |
| x86 | [windows6.1-kb976932-x86_c3516bc5c9e69fee6d9ac4f981f5b95977a8a2fa.exe](http://download.windowsupdate.com/msdownload/update/software/svpk/2011/02/windows6.1-kb976932-x86_c3516bc5c9e69fee6d9ac4f981f5b95977a8a2fa.exe) |
| x64 | [windows6.1-kb2533552-x64_0ba5ac38d4e1c9588a1e53ad390d23c1e4ecd04d.msu](http://download.windowsupdate.com/msdownload/update/software/crup/2011/05/windows6.1-kb2533552-x64_0ba5ac38d4e1c9588a1e53ad390d23c1e4ecd04d.msu) |
| x64 | [windows6.1-kb976932-x64_74865ef2562006e51d7f9333b4a8d45b7a749dab.exe](http://download.windowsupdate.com/msdownload/update/software/svpk/2011/02/windows6.1-kb976932-x64_74865ef2562006e51d7f9333b4a8d45b7a749dab.exe) |

Sources:
- https://answers.microsoft.com/en-us/windows/forum/all/extracting-an-update/2f341403-1419-4153-8c4a-e088d6bfdd72
- https://superuser.com/questions/249275/slipstream-windows-7-service-pack-1

#### Post Service Pack 1 Rollup packs
Install them in order top to bottom, either only the x86 or x64 files.
Put the files in separate numbered subfolders in the folder "windows7_updates" from top to bottom.

- <b>windows7_updates</b>
	- <b>01</b>
		- windows6.1-kb3020369-...
	- <b>02</b>
		- windows6.1-kb3125574-v4-...
	- ...

| Architecture | Name | Filename / Link | 
| --- | --- | --- | 
| x86 | KB3020369 - Service Stack Update (Released in April 2015) | [windows6.1-kb3020369-x86_82e168117c23f7c479a97ee96c82af788d07452e.msu](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2015/04/windows6.1-kb3020369-x86_82e168117c23f7c479a97ee96c82af788d07452e.msu) |
| x64 | KB3020369 - Service Stack Update (Released in April 2015) | [windows6.1-kb3020369-x64_5393066469758e619f21731fc31ff2d109595445.msu](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2015/04/windows6.1-kb3020369-x64_5393066469758e619f21731fc31ff2d109595445.msu) |
| x86 | KB3125574 - Convenience Rollup Update Package (Released in May 2016) | [windows6.1-kb3125574-v4-x86_ba1ff5537312561795cc04db0b02fbb0a74b2cbd.msu](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2016/05/windows6.1-kb3125574-v4-x86_ba1ff5537312561795cc04db0b02fbb0a74b2cbd.msu) |
| x64 | KB3125574 - Convenience Rollup Update Package (Released in May 2016) | [windows6.1-kb3125574-v4-x64_2dafb1d203c8964239af3048b5dd4b1264cd93b9.msu](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2016/05/windows6.1-kb3125574-v4-x64_2dafb1d203c8964239af3048b5dd4b1264cd93b9.msu) |
| x86 | KB4490628 - 2019-03 Servicing Stack Update for Windows 7 | [windows6.1-kb4490628-x86_3cdb3df55b9cd7ef7fcb24fc4e237ea287ad0992.msu](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/03/windows6.1-kb4490628-x86_3cdb3df55b9cd7ef7fcb24fc4e237ea287ad0992.msu) |
| x64 | KB4490628 - 2019-03 Servicing Stack Update for Windows 7 | [windows6.1-kb4490628-x64_d3de52d6987f7c8bdc2c015dca69eac96047c76e.msu](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/03/windows6.1-kb4490628-x64_d3de52d6987f7c8bdc2c015dca69eac96047c76e.msu) |
| x86 | KB4474419 - 2019-09 Security Update for Windows 7 | [windows6.1-kb4474419-v3-x86_0f687d50402790f340087c576886501b3223bec6.msu](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/09/windows6.1-kb4474419-v3-x86_0f687d50402790f340087c576886501b3223bec6.msu) |
| x64 | KB4474419 - 2019-09 Security Update for Windows 7 | [windows6.1-kb4474419-v3-x64_b5614c6cea5cb4e198717789633dca16308ef79c.msu](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/09/windows6.1-kb4474419-v3-x64_b5614c6cea5cb4e198717789633dca16308ef79c.msu) |
| x86 | KB4516655 - 2019-09 Servicing Stack Update for Windows 7 | [windows6.1-kb4516655-x86_47655670362e023aa10ab856a3bda90aabeacfe6.msu](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/09/windows6.1-kb4516655-x86_47655670362e023aa10ab856a3bda90aabeacfe6.msu) |
| x64 | KB4516655 - 2019-09 Servicing Stack Update for Windows 7 | [windows6.1-kb4516655-x64_8acf6b3aeb8ebb79973f034c39a9887c9f7df812.msu](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/09/windows6.1-kb4516655-x64_8acf6b3aeb8ebb79973f034c39a9887c9f7df812.msu) |
| x86 | KB4516065 - 2019-09 Security Monthly Quality Rollup for Windows 7 | [windows6.1-kb4516065-x86_662c716c417149d39d5787b1ff849bf7e5c786c3.msu](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2019/09/windows6.1-kb4516065-x86_662c716c417149d39d5787b1ff849bf7e5c786c3.msu) |
| x64 | KB4516065 - 2019-09 Security Monthly Quality Rollup for Windows 7 | [windows6.1-kb4516065-x64_40a6dff87423268e55a909d40a310ac66386be0d.msu](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2019/09/windows6.1-kb4516065-x64_40a6dff87423268e55a909d40a310ac66386be0d.msu) |
| x86 | KB4524157 - 2019-10 Security Monthly Quality Rollup for Windows 7 | [windows6.1-kb4524157-x86_422970e6ce3ab31cb101e1b8bc38294b4d2ebee2.msu](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2019/10/windows6.1-kb4524157-x86_422970e6ce3ab31cb101e1b8bc38294b4d2ebee2.msu) |
| x64 | KB4524157 - 2019-10 Security Monthly Quality Rollup for Windows 7 | [windows6.1-kb4524157-x64_0735a83d6d6849dc09c6bc430a8d0b1404b01dd3.msu](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2019/10/windows6.1-kb4524157-x64_0735a83d6d6849dc09c6bc430a8d0b1404b01dd3.msu) |
| x86 | KB4536952 - 2020-01 Servicing Stack Update for Windows 7 | [windows6.1-kb4536952-x86_f3b49481187651f64f13a0369c86ad7caa83b190.msu](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2020/01/windows6.1-kb4536952-x86_f3b49481187651f64f13a0369c86ad7caa83b190.msu) |
| x64 | KB4536952 - 2020-01 Servicing Stack Update for Windows 7 | [windows6.1-kb4536952-x64_87f81056110003107fa0e0ec35a3b600ef300a14.msu](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2020/01/windows6.1-kb4536952-x64_87f81056110003107fa0e0ec35a3b600ef300a14.msu) |
| x86 | KB4534310 - 2020-01 Security Monthly Quality Rollup for Windows 7 | [indows6.1-kb4534310-x86_887a5caab59437e8f23aa5a4608950455bb37537.msu](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2020/01/windows6.1-kb4534310-x86_887a5caab59437e8f23aa5a4608950455bb37537.msu) |
| x64 | KB4534310 - 2020-01 Security Monthly Quality Rollup for Windows 7 | [windows6.1-kb4534310-x64_4dc78a6eeb14e2eac1ede7381f4a93658c8e2cdc.msu](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2020/01/windows6.1-kb4534310-x64_4dc78a6eeb14e2eac1ede7381f4a93658c8e2cdc.msu) |
| x86 | KB4539601 - 2020-01 Preview of Monthly Quality Rollup for Windows 7 | [windows6.1-kb4539601-x86_89f30861c9a5d65b68ed1e029a68cf59be39fc13.msu](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2020/01/windows6.1-kb4539601-x86_89f30861c9a5d65b68ed1e029a68cf59be39fc13.msu) |
| x64 | KB4539601 - 2020-01 Preview of Monthly Quality Rollup for Windows 7 | [windows6.1-kb4539601-x64_fb3f59fb0b1d3a4abf4a35230aa88a06996c4a4a.msu](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2020/01/windows6.1-kb4539601-x64_fb3f59fb0b1d3a4abf4a35230aa88a06996c4a4a.msu) |

Sources:
- https://forums.malwarebytes.com/topic/274496-how-to-update-windows-7-to-the-latest-security-updates/
- https://www.reddit.com/r/apexlegends/comments/w80aw8/your_windows_7_system_is_to_outdated_please/


#### Internet Explorer 11 + Prerequisites 

Put all the files for your DVDs architecture (x86 or x64) in the folder "windows7_ie11".

Source: https://learn.microsoft.com/en-us/troubleshoot/developer/browsers/installation/prerequisite-updates-for-ie-11

| Architecture | Name | File / Link |
| --- | --- | --- | 
| x86 | Internet Explorer 11 (KB2841134) | [IE11-Windows6.1-x86-en-us.exe](https://www.microsoft.com/en-us/download/details.aspx?id=40902)
| x64 | Internet Explorer 11 (KB2841134) | [IE11-Windows6.1-x64-en-us.exe](https://www.microsoft.com/en-us/download/details.aspx?id=40901)
| x86 | KB2729094 | [windows6.1-kb2729094-v2-x86.msu](https://download.microsoft.com/download/b/6/b/b6bf1d9b-2568-406b-88e8-e4a218dea90a/windows6.1-kb2729094-v2-x86.msu) |
| x64 | KB2729094 | [windows6.1-kb2729094-v2-x64.msu](https://download.microsoft.com/download/6/c/a/6ca15546-a46c-4333-b405-ab18785abb66/windows6.1-kb2729094-v2-x64.msu) |
| x86 | KB2731771 | [windows6.1-kb2731771-x86.msu](https://download.microsoft.com/download/a/0/b/a0ba0a59-1f11-4736-91c0-dfcb06224d99/windows6.1-kb2731771-x86.msu) |
| x64 | KB2731771 | [windows6.1-kb2731771-x64.msu](https://download.microsoft.com/download/9/f/e/9fe868f6-a0e1-4f46-96e5-87d7b6573356/windows6.1-kb2731771-x64.msu) |
| x86 | KB2533623 | ? Maybe Windows6.1-KB3063858-x86.msu @ https://www.microsoft.com/en-us/download/details.aspx?id=47409 |
| x64 | KB2533623 | [windows6.0-kb2533623-x64_23652360b903754d42b6b969d9ae79462343f7d4.msu](https://catalog.s.download.windowsupdate.com/msdownload/update/software/updt/2011/06/windows6.0-kb2533623-x64_23652360b903754d42b6b969d9ae79462343f7d4.msu) |
| x86 | KB2670838 | [windows6.1-kb2670838-x86.msu](https://download.microsoft.com/download/1/4/9/14936fe9-4d16-4019-a093-5e00182609eb/windows6.1-kb2670838-x86.msu) |
| x64 | KB2670838 | [windows6.1-kb2670838-x64.msu](https://download.microsoft.com/download/1/4/9/14936fe9-4d16-4019-a093-5e00182609eb/windows6.1-kb2670838-x64.msu) |
| x86 | KB2786081 | [windows6.1-kb2786081-x86.msu](https://download.microsoft.com/download/4/8/1/481c640e-d3ee-4adc-aa48-6d0ed2869d37/windows6.1-kb2786081-x86.msu) |
| x64 | KB2786081 | [windows6.1-kb2786081-x64.msu](https://download.microsoft.com/download/1/8/f/18f9ae2c-4a10-417a-8408-c205420c22c3/windows6.1-kb2786081-x64.msu) |
| x86 | KB2834140 | [windows6.1-kb2834140-v2-x86.msu](https://download.microsoft.com/download/f/1/4/f1424ad7-f754-4b6e-b0da-151c7cbae859/windows6.1-kb2834140-v2-x86.msu) |
| x64 | KB2834140 | [windows6.1-kb2834140-v2-x64.msu](https://download.microsoft.com/download/5/a/5/5a548bfe-adc5-414b-b6bd-e1ec27a8dd80/windows6.1-kb2834140-v2-x64.msu) |
| x86 | KB2888049 | [windows6.1-kb2888049-x86.msu](https://download.microsoft.com/download/3/9/d/39d85ca8-7bf3-47c1-9031-fd6e51d8bbeb/windows6.1-kb2888049-x86.msu) |
| x64 | KB2888049 | [windows6.1-kb2888049-x64.msu](https://download.microsoft.com/download/4/1/3/41321d2e-2d08-4699-a635-d9828aadb177/windows6.1-kb2888049-x64.msu) |
| x86 | KB2882822 | [windows6.1-kb2882822-x86.msu](https://download.microsoft.com/download/7/c/e/7ce5d2a0-3a08-427e-9aa9-8a79e47b87b9/windows6.1-kb2882822-x86.msu) |
| x64 | KB2882822 | [windows6.1-kb2882822-x64.msu](https://download.microsoft.com/download/6/1/4/6141bfd5-40fd-4148-a3c9-e355338a9ac8/windows6.1-kb2882822-x64.msu) |

Source:
- https://www.escde.net/blog/dism-windows-7-sp1-mit-ie-11-image-bereitstellen
