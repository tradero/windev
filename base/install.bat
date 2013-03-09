@echo off

:: welcome banner
call :heredoc stickman && goto next1

Welcome to Windev installation script...

Just hold on a second, i'll download stage-1 package for You.

:next1

:: settings
set remoteFile=https://npmjs.org/static/npm.png
set localFile=stage1.zip

:: fetch.vbs script
call :heredoc html >fetch.vbs && goto next2
strFileURL = "!remoteFile!"
strHDLocation = "!localFile!"
Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP")
objXMLHTTP.open "GET", strFileURL, false
objXMLHTTP.send()
If objXMLHTTP.Status = 200 Then
Set objADOStream = CreateObject("ADODB.Stream")
objADOStream.Open
objADOStream.Type = 1 'adTypeBinary
objADOStream.Write objXMLHTTP.ResponseBody
objADOStream.Position = 0    'Set the stream position to the start
Set objFSO = Createobject("Scripting.FileSystemObject")
If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation
Set objFSO = Nothing
objADOStream.SaveToFile strHDLocation
objADOStream.Close
Set objADOStream = Nothing
End if
Set objXMLHTTP = Nothing

:next2

set curr_dir=%cd%

mkdir C:\windev
cscript fetch.vbs
del fetch.vbs
copy /Y ..\stage1.zip C:\windev
start /WAIT unzip.exe -q -o C:\windev\stage1.zip -d C:\windev
chdir /D C:\windev\stage1
cls

echo If You want to tweak something in installation script, You need to CTRL+C right now.
pause

bash.exe install.sh

chdir /D %curr_dir%
rmdir /S /Q C:\windev

goto next3
:next3

:: end of main script
goto :EOF

:: heredoc support
:heredoc <uniqueIDX>
setlocal enabledelayedexpansion
set go=
for /f "delims=" %%A in ('findstr /n "^" "%~f0"') do (
    set "line=%%A" && set "line=!line:*:=!"
    if defined go (if #!line:~1!==#!go::=! (goto :EOF) else echo(!line!)
    if "!line:~0,13!"=="call :heredoc" (
        for /f "tokens=3 delims=>^ " %%i in ("!line!") do (
            if #%%i==#%1 (
                for /f "tokens=2 delims=&" %%I in ("!line!") do (
                    for /f "tokens=2" %%x in ("%%I") do set "go=%%x"
                )
            )
        )
    )
)
goto :EOF

