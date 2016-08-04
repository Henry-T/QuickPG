call ./proj.android/build_native.bat
	
echo ### build cocos2dx_java
call %QUICK_COCOS2DX_ROOT%\lib\cocos2d-x\cocos2dx\platform\android\java\gradlew.bat build

echo ### copy cocos2dx_java
call copy /Y %QUICK_COCOS2DX_ROOT%\lib\cocos2d-x\cocos2dx\platform\android\java\bin\classes.jar proj.android\libs\libcocos2dx.jar

echo ### packing scripts
call %QUICK_COCOS2DX_ROOT%\bin\compile_scripts.bat -i scripts -o res\game.zip -e xxtea_zip -ek lolofinil -x app.test

echo ### copying framework
call copy /y %QUICK_COCOS2DX_ROOT%\lib\framework_precompiled\framework_precompiled.zip proj.android\assets\res

echo ### copying game.zip
call copy /y res\game.zip proj.android\assets\res

echo ### removing source code from assets\scripts
call rmdir /s /q proj.android\assets\scripts

echo ### build game project
cd proj.android & call gradlew.bat build

pause