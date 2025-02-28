@mode 38,25
@echo off
title netinf
echo Checking network info...
set uptct=9998
:loop
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^|find "SSID" ^|findstr /v "BSSID"') do set SSID=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^|find "Authentication"') do set SUCTYPE=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^|find "Band"') do set BAND=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^|find "State"') do set STATE=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^|find "Signal"') do set SIGNAL=%%a
for /f "tokens=4 delims==" %%a in ('ping 8.8.8.8 ^| find "Average"') do set ping=%%a 
set /a uptct=%uptct% + 1
if /I %STATE% EQU connected (
set STATEDIS=Connected
 ) else (
 set STATEDIS=Disconnected
 )
cls
echo   __________Network__________
echo Name:               %SSID%
echo Sercurity:          %SUCTYPE%
echo Network Band:       %BAND%
echo.
echo   _______Connectivity_______
echo State:               %STATEDIS%
echo Ping:               %ping%
echo Signal Strength:    %SIGNAL%
echo.
echo Updated at %time% [%uptct%]
goto loop