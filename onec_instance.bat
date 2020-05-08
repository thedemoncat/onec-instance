@echo off

SetLocal EnableExtensions

FOR /f "usebackq tokens=*" %%a in (".env") DO (
  FOR /F "tokens=1,2 delims==" %%b IN ("%%a") DO (
    set "%%b=%%c"
  )
)

echo off

set NewHosts=AddHostsProbe.txt

if not "%1"=="" set NewHosts=%1
if not exist %NewHosts% exit 1
set Hosts="%windir%\system32\drivers\etc\hosts"
copy %Hosts% %Hosts%.tmp

call :List %NewHosts%
move /Y %Hosts%.tmp %Hosts%
exit

:List
for /f "usebackq tokens=1,2 eol=#" %%A in ("%~1") do call :Search %%A %%B
exit /b

:Search
set Add=Y
for /f "tokens=1 eol=#" %%C in ('findstr /i /c:"%2" %Hosts%.tmp') do call :Found %1 %2 %%C
if %Add%==Y echo %1	%2>>%Hosts%.tmp
exit /b

:Found
if %1==%3 (set Add=N) else (
findstr /i /v /c:"%2" %Hosts%.tmp >%~dpn0.tmp
del /f %Hosts%.tmp
move /Y %~dpn0.tmp %Hosts%.tmp
if %1==- set Add=N
)
exit /b