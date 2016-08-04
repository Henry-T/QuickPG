@echo off

set DIR=%~dp0
set APP_ROOT=%DIR%..\
set APP_ANDROID_ROOT=%DIR%
set COCOS2DX_ROOT=%QUICK_COCOS2DX_ROOT%\lib\cocos2d-x
set SHARED_LIB_ROOT=%QUICK_COCOS2DX_ROOT%\NativeBuildProj\proj.android
set GAME_PLATFORM=%1
set MIN_ASSETS=%2
if "%MIN_ASSETS=%"=="" (
  set MIN_ASSETS=0
)

if "%GAME_PLATFORM%"=="" (
  set GAME_PLATFORM=apowo
)

echo - config:
echo   ANDROID_NDK_ROOT    = %ANDROID_NDK_ROOT%
echo   QUICK_COCOS2DX_ROOT = %QUICK_COCOS2DX_ROOT%
echo   COCOS2DX_ROOT       = %COCOS2DX_ROOT%
echo   APP_ROOT            = %APP_ROOT%
echo   APP_ANDROID_ROOT    = %APP_ANDROID_ROOT%

rem if dont use DEBUG, comments out two lines below
set NDK_DEBUG=1
set NDK_BUILD_FLAGS=CPPFLAGS="-DCOCOS2D_DEBUG=1"

echo - prepare assets
call %~dp0PrepareAssets.bat

echo Using prebuilt externals
rem "%ANDROID_NDK_ROOT%\ndk-build" %ANDROID_NDK_BUILD_FLAGS% NDK_DEBUG=%NDK_DEBUG% %NDK_BUILD_FLAGS% -C %APP_ANDROID_ROOT% NDK_MODULE_PATH=%QUICK_COCOS2DX_ROOT%;%COCOS2DX_ROOT%;%COCOS2DX_ROOT%\cocos2dx\platform\third_party\android\prebuilt;%QUICK_COCOS2DX_ROOT%\pbc
call "%ANDROID_NDK_ROOT%\ndk-build" -j3 %ANDROID_NDK_BUILD_FLAGS% NDK_DEBUG=%NDK_DEBUG% %NDK_BUILD_FLAGS% -C %SHARED_LIB_ROOT% NDK_MODULE_PATH=%QUICK_COCOS2DX_ROOT%;%COCOS2DX_ROOT%;%COCOS2DX_ROOT%\cocos2dx\platform\third_party\android\prebuilt;%QUICK_COCOS2DX_ROOT%\pbc
if %errorlevel% neq 0 (
  echo failed to build cocos native lib !!!!!
  exit /B 1
)

echo copy so to game project
if not exist "%APP_ROOT%\proj.android\libs" mkdir "%APP_ROOT%proj.android\libs"
xcopy/AEFRSY "%SHARED_LIB_ROOT%\libs" "%APP_ROOT%proj.android\libs"
