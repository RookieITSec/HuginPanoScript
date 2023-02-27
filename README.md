# HuginPanoScript
I have been working to build a better process to build pano images from my DJI Mini 2 drone.  

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


## General Steps
1. 





