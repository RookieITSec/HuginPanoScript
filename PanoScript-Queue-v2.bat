REM 2023-08-21- This script is being built to take a folder full of folders containing groups of .jpg photos from the drone 360 photo tool and export a 2:1 aspect ration photo to be uploaded to google Maps/Streetview.
REM Guide followed located here - https://wiki.panotools.org/Panorama_scripting_in_a_nutshell#Creating_hugin_projects_on_the_command-line
REM - dji.assistant file uses a similar process, but dynamically pulls data.  If the template I have setup does not work well, this may be a new idea - http://www.wse.fr/How-TO/dji-30.assistant

REM Hugin needs to be installed here C:\Program Files\Hugin
REM - This script is being called by the deployment script.  The Deployment script copies this to each folder in the specified directory and then executes it.  All sub-folder tasks will run at the same time, so it will take a bit of time when doing many panos.  

REM - MAKE SURE YOU DO NOT HAVE ANY NON-PANO IMAGES IN THE FOLDER.  THE SOFTWARE TRIES TO EAT THEM AND ADD TO YOUR PANO.

REM - set the name of the variable we will be using.   This will be the name of the directory the file is in.
@echo off
for %%I in (.) do set "current_folder=%%~nxI"
echo The current folder is: %current_folder%

REM Build the PTO file with the contents of the directory we are currently in.
"C:\Program Files\Hugin\bin\pto_gen" *.jpg -o %current_folder%.pto

REM Add detail from the template example (a good DJI Mini2 pano in my case) to new PTO file from the template of a known good file.
REM - https://groups.google.com/g/hugin-ptx/c/Af7TG2Bq-ko/m/3g3y-xIoEAAJ
"C:\Program Files\Hugin\bin\pto_template" --o %current_folder%.pto --template=template.pto %current_folder%.pto

REM Create Control Points in the project
"C:\Program Files\Hugin\bin\cpfind" --prealigned -o %current_folder%.pto %current_folder%.pto

REM Clean up the control points
"C:\Program Files\Hugin\bin\cpclean" -o %current_folder%.pto %current_folder%.pto

REM Use the non-conntected tool to align non-CPlinked images
REM - https://groups.google.com/g/hugin-ptx/c/Af7TG2Bq-ko/m/3g3y-xIoEAAJ
"C:\Program Files\Hugin\bin\geocpset" -o %current_folder%.pto %current_folder%.pto

REM Clean up the control points
"C:\Program Files\Hugin\bin\cpclean" -o %current_folder%.pto %current_folder%.pto

REM Find Vertical Lines
"C:\Program Files\Hugin\bin\linefind" -o %current_folder%.pto %current_folder%.pto

REM Optimize 
"C:\Program Files\Hugin\bin\autooptimiser" -a -l -s -m -o %current_folder%.pto %current_folder%.pto

REM set output/stitcher options
REM These options are to setup the pano for upload to Google Maps.
"C:\Program Files\Hugin\bin\pano_modify" -o %current_folder%.pto --fov=360x180 --center --straighten --canvas=9000x4500 --ldr-file=JPG --ldr-compression=100 --output-exposure=AUTO %current_folder%.pto

REM Stitch the output - un-rem the next line if you want the script to stitch right away.  I had too many at once so I moved over to the batch tool, which is the command below.  
REM "C:\Program Files\Hugin\bin\hugin_executor" --stitching --prefix=%current_folder% %current_folder%.pto

REM send to batch to run sequentially.
REM Only use the next line if the "hugin_executer" line is commented out.
"C:\Program Files\Hugin\bin\PTBatcherGui.exe" --batch %current_folder%.pto

REM - Figure out how to get rid of the black blocks at the top.
