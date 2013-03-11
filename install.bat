@echo off

echo Select your Windev installation directory
For /F "Tokens=1 Delims=" %%I In ('cscript //nologo browse.vbs') Do Set _InstallFolderName=%%I

echo Select your user home directory
For /F "Tokens=1 Delims=" %%I In ('cscript //nologo browse.vbs') Do Set _HomeFolderName=%%I

:: To be able to use Home directory just after shell start
set HOME=%_homefoldername%
unzip.exe -q -o stage1.zip
bin\SetEnv -a HOME %_homefoldername%
bin\SetEnv -a PATH %"%_installfoldername%/windev/bin"

:: sometimes windows cache dns works to good, and we can have problem with connecting into WORKING github server, so let's flush dns
ipconfig /flushdns

cls
bin\zsh.exe install.sh %_installfoldername% %_homefoldername%
