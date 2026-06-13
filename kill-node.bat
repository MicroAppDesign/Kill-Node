@echo off
rem Kill Node.js processes on Windows with selection support.
rem This script lists running node.exe processes and lets the user choose one or all.
setlocal enabledelayedexpansion

echo Checking for Node.js processes...
set count=0
for /f "usebackq tokens=1,2 delims=," %%A in (`tasklist /FI "IMAGENAME eq node.exe" /FO CSV /NH ^| find /I "node.exe"`) do (
    set /a count+=1
    set "proc_name[!count!]=%%~A"
    set "proc_pid[!count!]=%%~B"
    echo !count!. %%~A (PID %%~B)
)

if %count%==0 (
    echo No Node.js processes found.
    echo.
    pause
    exit /b 0
)

echo.
set /p choice=Enter process number to kill, A=all, Q=quit: 

if /I "%choice%"=="Q" (
    echo Aborted. No processes were stopped.
    echo.
    pause
    exit /b 0
)

if /I "%choice%"=="A" (
    echo Stopping all Node.js processes...
    taskkill /F /IM node.exe
    if errorlevel 1 (
        echo Failed to stop some processes or none were running.
        pause
        exit /b 1
    )
    echo All Node.js processes have been terminated.
    echo.
    pause
    exit /b 0
)

set "pid="
for /L %%I in (1,1,%count%) do (
    if "%choice%"=="%%I" set "pid=!proc_pid[%%I]!"
)

if not defined pid (
    echo Invalid selection. Please enter a number from 1 to %count%, A, or Q.
    echo.
    pause
    exit /b 1
)

echo Stopping Node.js process PID %pid%...
taskkill /F /PID %pid%
if errorlevel 1 (
    echo Failed to stop process %pid%.
    pause
    exit /b 1
)

echo Process %pid% has been terminated.
echo.
pause
exit /b 0
