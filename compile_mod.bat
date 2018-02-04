@echo off

:: Vermintide info
SET vermintide_dir=E:\SteamLibrary\steamapps\common\Warhammer End Times Vermintide
SET vermintide_bundle_dir=%vermintide_dir%\bundle
SET vermintide_mods_dir=%vermintide_bundle_dir%\mods

:: Stingray executable
SET stingray_exe="./bin/stingray_win64_dev_x64.exe"

:: Mods directory
SET mods_dir=mods

:: Create install directory
if not exist "%vermintide_mods_dir%" mkdir "%vermintide_mods_dir%"

:: Loop all projects in mods directory
setlocal EnableDelayedExpansion
for /f "tokens=*" %%G in ('dir "%mods_dir%" /a:d /b') do (
	:: Found Project
	echo Found Project %%G
	
	:: Compile info
	SET source_dir=!mods_dir!\%%G
	SET temperary_dir=!source_dir!\temp
	SET data_dir=!temperary_dir!\compile
	SET buid_dir=!temperary_dir!\bundle
	
	:: Remove if temporary directory already exist
	if exist "!temperary_dir!" rmdir /S /Q "!temperary_dir!"
	
	:: Create temporary directory
	mkdir "!temperary_dir!"
	mkdir "!data_dir!"
	mkdir "!buid_dir!"
	
	:: Set Parameters
	SET stingray_para=--compile-for win32
	SET stingray_para=!stingray_para! --source-dir "!source_dir!"
	SET stingray_para=!stingray_para! --data-dir "!data_dir!"
	SET stingray_para=!stingray_para! --bundle-dir "!buid_dir!"
	
	:: Execute
	!stingray_exe! !stingray_para!

	:: Show Processed bundles
	more "!data_dir!\processed_bundles.csv"
	echo.
		
	:: Copy bundle files
	copy "!buid_dir!\*." "!vermintide_mods_dir!" 1>NUL
)

pause
