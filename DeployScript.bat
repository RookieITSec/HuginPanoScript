REM 2023-02-24 - RCB
REM - This script deploys the pano script bat file to each directory containing the pano files from a drone flight.  Modify the two "set" variables to the script to be deployed and the location of the pano file folders.  
REM - keep in mind this script will kick off a bunch of processor intensive tasks.

@echo on
set "script=D:\Photo Location Testing\PanoScript-Queue.bat"
REM This variable should be the location of the Hugin script file.  


set "directory=D:\2023-02-26-Drone\"
REM This variable should be the location of the folders containing Pano images.  The DJI drone puts each pano set into a unique directory.



for /D %%i in ("%directory%/*") do (
  REM This loop reads in the list of files from the location specified in the directory vartiable above.  It runs the below two steps on each folder in the directory location.

  copy "%script%" "%%i"
    REM This step copies the script to each folder in the directory.   
  
  start cmd /c "D: && cd /d %%i && PanoScript-Queue.bat"
    REM This step launches a new command window from the folder in the directory to execute the bat file.  
  
)

pause
