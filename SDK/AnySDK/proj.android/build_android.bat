@echo off

set IGNORE_SCRIPT=%2
if "%IGNORE_SCRIPT%"=="" (
  set IGNORE_SCRIPT=0
)

call ./proj.android/build_native.bat %1

echo ### ant build cocos2dx_java
call %ANT_HOME%/bin/ant -Dsdk.dir=%ANDROID_SDK_ROOT% -buildfile %QUICK_COCOS2DX_ROOT%\lib\cocos2d-x\cocos2dx\platform\android\java\build.xml clean debug

echo ### copy cocos2dx_java
call copy /Y %QUICK_COCOS2DX_ROOT%\lib\cocos2d-x\cocos2dx\platform\android\java\bin\classes.jar proj.android\libs\libcocos2dx.jar

if %IGNORE_SCRIPT%==0 (
  echo ### packing scripts
  call %QUICK_COCOS2DX_ROOT%\bin\compile_scripts.bat -i scripts -o proj.android\assets\res\game.zip -e xxtea_zip -ek lolofinil
) else (
  echo ### scripts ignored
)

echo ### copying framework
call copy /y %QUICK_COCOS2DX_ROOT%\lib\framework_precompiled\framework_precompiled.zip proj.android\assets\res

echo ### removing source code from assets\scripts
call rmdir /s /q proj.android\assets\scripts

echo ### build Apowo Game SDK
call %ANDROID_SDK_ROOT%\tools\android update lib-project -p E:\proj\ProjectS\PicaTownMobileClient\apowo_sdk\GameSDK

echo ### update project
call %ANDROID_SDK_ROOT%\tools\android update project --name game --path proj.android

echo ### build game project
call %ANT_HOME%/bin/ant -buildfile proj.android/build.xml  clean debug

pause