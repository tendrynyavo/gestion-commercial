set TOMCAT_PATH=C:\Program Files\Apache Software Foundation\Tomcat 10.0

if exist "target" (
    rmdir /s /q .\target
)

@REM Build target for project
mkdir .\target
mkdir .\target\WEB-INF
mkdir .\target\WEB-INF\classes
mkdir .\target\WEB-INF\lib
mkdir .\target\view
mkdir .\target\assets

Xcopy lib .\target\WEB-INF\lib /E /H /C /I /Y
copy .\web.xml .\target\WEB-INF\
copy .\config.xml .\target\WEB-INF\classes

@REM Copy Front-end
Xcopy assets .\target\assets /E /H /C /I /Y
rmdir /s /q .\target\assets\scss
Xcopy view .\target\view /E /H /C /I /Y
copy index.jsp .\target

@REM  Compile all java file
dir src /b /s .\src\*.java > file.txt
findstr /i .java file.txt > sources.txt
javac --source 15 --target 15 -parameters -cp ./lib/connection.jar;./lib/framework.jar;./lib/tradukisto-3.0.0.jar;./lib/gson-2.10.1.jar;./lib/pdfbox-app-3.0.0.jar;./lib/mail.jar;./lib/jxl-2.6.12.jar -d ./target/WEB-INF/classes/ @sources.txt
if %errorlevel% neq 0 ( exit /b %errorlevel% )
del "file.txt"
del "sources.txt"

@REM @REM Convert into .war
cd target
jar -cvf "commercial.war" *
move "commercial.war" "%TOMCAT_PATH%\webapps"
cd ..