haxe serverCpp.hxml

@echo off
if not exist bin mkdir bin
@echo on


copy build\cpp\DedicatedServer.exe bin\multiplayerServer.exe

@echo off
REM creates (clickable;) batch files for cpp server and client
if not exist bin\multiplayerServer.bat (
  echo multiplayerServer.exe
  echo pause
) > bin\multiplayerServer.bat


if "%~1"=="" pause

@echo on