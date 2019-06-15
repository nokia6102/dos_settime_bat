@ECHO OFF
:: Check Windows version
IF NOT "%OS%"=="Windows_NT" GOTO Syntax

:: Check if a valid timeout period is specified
IF     "%~1"=="" GOTO Syntax
IF NOT "%~2"=="" GOTO Syntax
ECHO.%*| FINDSTR /R /X /C:"[0-9][0-9]*" >NUL || GOTO Syntax
IF %~1 LSS    1 GOTO Syntax
IF %~1 GTR 3600 GOTO Syntax

:: Use local variable
SETLOCAL

:: Add 1 second for IPv4
SET /A seconds = %1 + 1

:: The actual command: try IPv4 first, if that fails try IPv6
PING -n %seconds% 127.0.0.1 >NUL 2>&1 || PING -n %1 ::1 >NUL 2>&1

:: Done
ENDLOCAL
GOTO:EOF


:Syntax
ECHO.
ECHO PMSleep.bat
ECHO Poor Man's SLEEP utility,  Version 3.00 for Windows NT 4 and later.
ECHO Wait for a specified number of seconds.
ECHO.
ECHO Usage:  CALL  PMSLEEP  seconds
ECHO.
ECHO Where:        seconds  is the number of seconds to wait (1..3600)
ECHO.
ECHO Notes:  The script uses PING for the delay, so an IP stack is required.
ECHO         The delay time will not be very accurate.
ECHO.
ECHO Written by Rob van der Woude
ECHO http://www.robvanderwoude.com

IF "%OS%"=="Windows_NT" EXIT /B 1
