# HuginPanoScript
I have been working to build a better process to build pano images from my DJI Mini 2 drone.  
- Note - I am 100% NOT a programmer.  There is probably better ways to do this.  If you find some, let me know!


## Problem Statement
The problem I have was DJI's software had two major flaws - 
1. The Pano constrcuted does NOT have gps tags.  The individual images do have gps, but the Pano stitching in DJI's app does not include the metadata.
2. The Pano constructed does not use full res images.  The images are significantly scalled down and I want higher res panos.  


## Objectives
1. Highest resolution possible.
2. GPS Coords in the metadata.
3. Batch processing for all directories in a specific location.  
4. Patching of "black holes" where image data does not exist - missing images or top of image where the drone did not capture data.
5. Correctly reading low contrast images and adding control points via scripting.  Snow and water both cause problems with stitching.  


## Software Used
1. Windows 10 was used with standard bat files. 
2. Hugin
  - Version: 2021.0.0.52df0f76c700 built by Thomas
  - Path to resources: C:\Program Files\Hugin\share\hugin\xrc\
  - Path to data: C:\Program Files\Hugin\share\hugin\data\


## PC Used 
 - Just for reference - Win 10, i7, 64gb, RTX 2070 Super
 - Mac or liinux could be used with the scripts, but some modifications would be needed, mostly just syntax of the bat files.  


## General Steps
1. Get the files ready.
2. Run the batch file to deploy the Hugin Script.
3. Let the Hugin Script Run
4. Monitor Batcher tool thing.


### 1. Get the files Ready.


### 2. Run Batch file to deploy the Hugin Script.


### 3. Let the Hugin Script Run


### 4. Monitor Batcher tool thing.
The above script will send the individual PTO files to the PTBatcher tool from Hugin and 





