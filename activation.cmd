@echo off
setlocal

cd /d "%ProgramFiles%\Microsoft Office\root\Office16"

echo.
echo ==========================================
echo Installing Office Volume License files
echo ==========================================
echo.

for /f %%x in ('dir /b "..\Licenses16\ProPlusVL_KMS*.xrm-ms"') do (
    echo Installing %%x
    cscript //nologo ospp.vbs /inslic:"..\Licenses16\%%x"
    if errorlevel 1 goto :error
)

echo.
echo ==========================================
echo Installing Office KMS Client Key
echo ==========================================
echo.

cscript //nologo ospp.vbs /inpkey:XQNVK-8JYDB-WJ9W3-YJ8YR-WFG99
if errorlevel 1 goto :error

echo.
echo ==========================================
echo Removing old product keys
echo ==========================================
echo.

cscript //nologo ospp.vbs /unpkey:BTDRB
cscript //nologo ospp.vbs /unpkey:KHGM9
cscript //nologo ospp.vbs /unpkey:CPQVG

echo.
echo ==========================================
echo Configuring KMS server
echo ==========================================
echo.

cscript //nologo ospp.vbs /sethst:209.209.9.214
if errorlevel 1 goto :error

cscript //nologo ospp.vbs /setprt:1688
if errorlevel 1 goto :error

echo.
echo ==========================================
echo Activating Office
echo ==========================================
echo.

cscript //nologo ospp.vbs /act
if errorlevel 1 goto :error

echo.
echo ==========================================
echo FINAL LICENSE STATUS
echo ==========================================
echo.

cscript //nologo ospp.vbs /dstatus

echo.
echo Done.
pause
exit /b 0

:error
echo.
echo ==========================================
echo ERROR - Operation failed
echo ==========================================
echo.
cscript //nologo ospp.vbs /dstatus
pause
exit /b 1