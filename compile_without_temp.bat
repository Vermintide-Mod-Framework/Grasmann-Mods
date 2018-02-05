@setlocal enableextensions enabledelayedexpansion
@echo off

:: Manual setting pathes (in case this batch script won't be able to automatically locate steam installation folders) [you can change them if needed]

set MANUAL_MODS_DIR=C:\Program Files (x86)\Steam\steamapps\common\Warhammer End Times Vermintide\bundle\mods
set MANUAL_STINGRAY_EXE=C:\Program Files (x86)\Steam\steamapps\common\Warhammer End Times Vermintide Mod Tools\bin\stingray_win64_dev_x64.exe

:: Find Vermintide folder via steam registry entries

set KEY_NAME="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 235540"
set VALUE_NAME=InstallLocation

for /F "usebackq skip=2 tokens=1-2*" %%A in (`REG QUERY %KEY_NAME% /v %VALUE_NAME% 2^>nul`) do (
  set MODS_DIR=%%C\bundle\mods
)

:: Find Stingray SDK folder via steam registry entries

set KEY_NAME="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 718610"
set VALUE_NAME=InstallLocation

FOR /F "usebackq skip=2 tokens=1-2*" %%A in (`REG QUERY %KEY_NAME% /v %VALUE_NAME% 2^>nul`) do (
  set STINGRAY_EXE=%%C\bin\stingray_win64_dev_x64.exe
)

:: Check if Vermintide mods folder and Sringray binary exist (automatically located [and manually set])

if not exist "%MODS_DIR%" set MODS_DIR=%MANUAL_MODS_DIR%

if not exist "%MODS_DIR%" (
  echo ERROR: Vermintide install location not found. Script execution aborted.
  pause
  exit
)

if not exist "%STINGRAY_EXE%" set MODS_DIR=%MANUAL_STINGRAY_EXE%

if not exist "%STINGRAY_EXE%" (
  echo ERROR: stingray_win64_dev_x64.exe not found. Script execution aborted.
  pause
  exit
)

::delete temp folder
del /Q .temp

:: Iterate through all the subdirectories (assuming all of them are bundle projects; ignoring .git and .temp folders)
for /f "tokens=*" %%D in ('dir "." /a:d /b') do (
  if /i not "%%~nxD"==".git" (
    if /i not "%%~nxD"==".temp" (
      :: Show the name of current directory
      echo ------------------------------------------------------------------------------------------------
      echo %%D
      echo ------------------------------------------------------------------------------------------------
      
      :: Get needed dir pathes for current project
      SET SOURCE_DIR=%%D
      SET TEMP_DIR=.temp\%%D
      SET DATA_DIR=!TEMP_DIR!\compile
      SET BUILD_DIR=!TEMP_DIR!\bundle
      
      :: Create Stingray compiler parameters
      SET STINGRAY_PARAMS=--compile-for win32
      SET STINGRAY_PARAMS=!STINGRAY_PARAMS! --source-dir "!SOURCE_DIR!"
      SET STINGRAY_PARAMS=!STINGRAY_PARAMS! --data-dir "!DATA_DIR!"
      SET STINGRAY_PARAMS=!STINGRAY_PARAMS! --bundle-dir "!BUILD_DIR!"
      
      :: Execute
      !STINGRAY_EXE! !STINGRAY_PARAMS!
      
      :: Display processed bundle contents
      type !DATA_DIR!\processed_bundles.csv 2>nul
      echo.
      
      :: Rename bundle file (use its project folder name)
      ren "!BUILD_DIR!\*." %%D
      
      :: Copy compiled mods to mods directory
      move /y "!BUILD_DIR!\*." "%MODS_DIR%" 1>nul
    )
  )
)

pause