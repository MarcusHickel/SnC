# SnC
Sensors and Control 2022

Assessment_2_Video/
The Demo Video

Testimages/
Testing Images

Assessment_2_Code.m
The Main Loop. Run this. Make sure to hold test checkerboard centred and perpendicular to the camera for the first few seconds of running this.

Baseline.jpg
The image used as the refernce point for Loop. Gets overwritten in Loop

BoxFind.m
Function used to find the Checkerboard pattern, its corners and generate a region of intrest (ROI) for the main Loop

BulkCheck.m
Used to test code on images in 'testimages/'

GraphMaker.m
Function to make a 360 pointer figure for rotation of the Checkerboard.

Presenation.pptx
Presentation slides

README.md
This file

RotationDetect.m
Function that takes the calculated Region of intrest (ROI) from BoxFind and uses SURF to find features to figure out the rotation of the image.

Shifted.jpg
The 'live' image from the ROS subscriber, is overwritten when loop runs

ShowTheWay.m
Function that creates the figures and plolts to show the rotation of the pattern

TestCheckerboard.pdf
The first iteration of the checkerboard

TestCheckerboardV2.PDF
Second iteration of the checkerboard. Unused.

Translation.m
Function that calcuates a translation vector between to images. 



OLD:
Use the following link to install usb_cam (I THINK) - Anthony
https://answers.ros.org/question/197651/how-to-install-a-driver-like-usb_cam/
