@echo off
setlocal EnableDelayedExpansion
cd /d "%~dp0"
set "PATH=%PATH%;%ProgramFiles%\nodejs;%ProgramFiles(x86)%\nodejs;%APPDATA%\npm;%LOCALAPPDATA%\Programs\nodejs"
for /d %%D in ("%~dp0node-v*" "%USERPROFILE%\Downloads\node-v*" "%USERPROFILE%\Desktop\node-v*") do (
  set "PATH=%%D;!PATH!"
  for /d %%E in ("%%D\node-v*") do set "PATH=%%E;!PATH!"
)
echo ===== Keep Fit - Upload to Firebase =====
where npx >nul 2>nul
if errorlevel 1 (
  echo.
  echo ERROR: Node.js is NOT installed on this computer.
  echo Install it from https://nodejs.org  then run this file again.
  echo.
  pause
  exit /b
)
node -v
call npx -y firebase-tools@13 login
if errorlevel 1 ( echo LOGIN FAILED - send a screenshot & pause & exit /b )
call npx -y firebase-tools@13 deploy --only hosting --project keep-fit-ef383
if errorlevel 1 ( echo UPLOAD FAILED - send a screenshot & pause & exit /b )
echo.
echo DONE. Open: https://keep-fit-ef383.web.app
pause
