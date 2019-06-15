@echo off
set timestamp=%date:~0,10%
set timestamp=%timestamp:/=-% %time:~0,8%
echo|set /p=%timestamp%
echo|set /p=%timestamp%>"time.txt"
call pmsleep.bat 5
::pause
exit