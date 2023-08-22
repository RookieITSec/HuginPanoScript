2023-08-21 - Tweaking the readme for V2.  

# HuginPanoScript
I have been working to build a better process to build 360/Sphere pano images from my DJI Mini 2 drone.  
- Note - I am 100% NOT a programmer.  This repo is largely for my own reference in the future.  There is probably better ways to do this.  If you find some, let me know!


## Problem Statement
The problem I have was DJI's software had two major flaws - 
1. The 360/Sphere Pano constrcuted does NOT have gps tags.  The individual images do have gps, but the Pano stitching in DJI's app does not include the metadata.
2. The 360/Sphere Pano constructed does not use full res images.  The images are significantly scaled down and I want higher res panos.  


## Objectives
1. Highest resolution possible.  (solved)
2. GPS Coords in the metadata.  (solved)
3. Batch processing for all directories in a specific location.  (solved)
4. Patching of "black holes" where image data does not exist - missing images or top of image where the drone did not capture data. (working on it.)
5. Correctly reading low contrast images and adding control points via scripting.  Snow and water both cause problems with stitching.  (at a dead end maybe)


## Software Used
1. Windows 10 was used with standard bat files. 
2. Hugin
  - Version: 2021.0.0.52df0f76c700 built by Thomas
  - Path to resources: C:\Program Files\Hugin\share\hugin\xrc\
  - Path to data: C:\Program Files\Hugin\share\hugin\data\
  - Note - version is probably not overly important to match, as long as it's close.  I dont think I am doing anything too crazy or unique.  


## PC Used 
 - Just for reference - Win 10, i7, 64gb, RTX 2070 Super
 - Mac or liinux could be used with the scripts, but some modifications would be needed, mostly just syntax of the bat files.  


## General Steps
1. Install the software.
2. Get the files ready.
3. Run the batch file to deploy the Hugin Script.
4. Let the Hugin Script Run
5. Monitor Batcher tool thing.
6. Do something with the Pano's.


### 1. Install the software.
1. Hugin is open source and easy to get/install - https://sourceforge.net/projects/hugin/files/latest/download
2. Get the latest version and install it.  I used the defaults and if you change the install locations, the script may need to be tweaked to follow the locations. 

### 2. Get the files Ready.
1. I use a local drive on my PC to store the files from the Drone to keep things as fast as possible.
2. The DJI Mini 2 saves each set of images for a pano sphere in a individual directory on the memory card from the drone.  
3. I copy all the individual files from the Panorama folder on the memory card to a local folder like d:\2023-02-27-DronePanos\


### 3. Run Batch file to deploy the Hugin Script.
1. The deploy script contains two variables you will need to tweak.  The location of the Script you want to run and the location of your target folders.
2. Edit the deploy script from this repo with the correct locations in the variables.  I have REM comments in the bat file to help also.
Notes:
  - The DeployScript.bat in this repo is the script I currently use.  This may be tweaked as I move forward.
  - The script could be modified to run the Hugin Script in the next step sequentially by tweaking the "Start" line to not open a new command prompt.  This would help to limit the resources used on the computer, but will not take advatage of multi core/threaded processors.  


### 4. Let the Hugin Script Run
  - The script is located in this repo - PanoScript-Queue.bat
  - This process will take some time 
  

### 5. Monitor PTBatcher tool thing.
The above script will send the individual PTO files to the PTBatcher tool from Hugin and run the stitching operations sequentially.

### 6. Do something with the Pano's
1. Determine if the Panos are good.  
2. I typically use the windows search function to find all the new panos in the various directories and then copy them out to a single directory for review and next steps.  Moving them saves a step later on if you want to go back and edit/re-run a stitching for an individual item as leaving the new pano in the directory and re-running the bat file hugin script from this project will ingest the pano and all the matching images and cause chaos.  
3. If you want to add them to a google photos album, upload to Google photos like any other photo.  Google Photos will read these as panos and display them to viewers as panos, which is nice.
4. If you want to add them to Google Maps, check out my other Github project here - https://github.com/RookieITSec/GoogleMaps360PhotoUpload




## Thank you to the various sources of info that lead to this write-up.
1. Panotools Hugin scripting writeup https://wiki.panotools.org/Panorama_scripting_in_a_nutshell#Creating_hugin_projects_on_the_command-line
2. Hugin Google Groups - https://groups.google.com/g/hugin-ptx
3. EXIFTool is used by Hugin automatically - https://exiftool.org/ and/or https://exiftool.sourceforge.net/
4. DJI Mini 2 and DJI Fly App - For making a fairly slick drone for taking 360 photos and software that missed a few features....so far.  

