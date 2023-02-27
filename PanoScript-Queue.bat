REM 2023-02-03- This script is being built to take a folder full of folders containing groups of .jpg photos from the drone 360 photo tool and export a 2:1 aspect ration photo to be uploaded to google Maps/Streetview.
REM Guide followed located here - https://wiki.panotools.org/Panorama_scripting_in_a_nutshell#Creating_hugin_projects_on_the_command-line


REM Hugin needs to be installed here C:\Program Files\Hugin
REM - This script is being called by the deployment script.  The Deployment script copies this to each folder in the specified directory and then executes it.  All sub-folder tasks will run at the same time, so it will take a bit of time when doing many panos.  


REM - MAKE SURE YOU DO NOT HAVE ANY NON-PANO IMAGES IN THE FOLDER.  THE SOFTWARE TRIES TO EAT THEM AND ADD TO YOUR PANO.


REM - set the name of the variable we will be using.   This will be the name of the directory the file is in.
@echo off
for %%I in (.) do set "current_folder=%%~nxI"
echo The current folder is: %current_folder%


REM Build the PTO file with the contents of the directory we are currently in.
"C:\Program Files\Hugin\bin\pto_gen" *.jpg -o %current_folder%.pto
REM Figure out how to rename the pto file to the parent folder name.  Remember to tweak the file name below if this changes.


REM Create Control Points in the existing pto file
"C:\Program Files\Hugin\bin\cpfind" --celeste -o %current_folder%.pto %current_folder%.pto

REM Clean up the control points
"C:\Program Files\Hugin\bin\cpclean" -o %current_folder%.pto %current_folder%.pto

REM Find Vertical Lines
"C:\Program Files\Hugin\bin\linefind" -o %current_folder%.pto %current_folder%.pto

REM Optimize 
"C:\Program Files\Hugin\bin\autooptimiser" -a -l -s -m -o %current_folder%.pto %current_folder%.pto

REM Optimize Version 2 - 
REM "C:\Program Files\Hugin\bin\pto_var" --opt Vb,Vx,Ra,Eev -o %current_sfolder%.pto %current_folder%.pto
REM "C:\Program Files\Hugin\bin\vig_optimize" -o %current_folder%.pto %current_folder%.pto
REM version 2 was far worse.

REM set output/stitcher options
"C:\Program Files\Hugin\bin\pano_modify" -o %current_folder%.pto --fov=360x180 --center --straighten --canvas=9000x4500 --ldr-file=JPG --ldr-compression=100 --output-exposure=AUTO %current_folder%.pto

REM After the pause, it will attempt to stitch.
REM pause

REM Stitch the output - un-rem the next line if you want the script to stitch right away.  I had too many at once so I moved over to the batch tool, which is the command below.  
REM "C:\Program Files\Hugin\bin\hugin_executor" --stitching --prefix=%current_folder% %current_folder%.pto

REM send to batch to run sequentially.
"C:\Program Files\Hugin\bin\PTBatcherGui.exe" --batch %current_folder%.pto %current_folder%.pano


REM Rename the output to the date it was captured to help clarify the filename.
REM "C:\Program Files\Hugin\bin\exiftool" "-filename<CreateDate" -d %Y%m%d_%H%M%S%%-c.pano.%%le pano.jpg
REM This does not work for some reason?


REM - Figure out how to get rid of black blocks-  maybe adding enblend "-l 29" will help?

