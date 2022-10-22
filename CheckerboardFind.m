clear all
close all

I = imread('Check2.jpg');
% Detect the checkerboard points.

[imagePoints,boardSize] = detectCheckerboardPoints(I);

%Finding the bounding box of the checkerboard
TopLeft = min(imagePoints);
BottomRight = max(imagePoints);

% Adding Markers
J = insertText(I,imagePoints,1:size(imagePoints,1));
J = insertMarker(J,imagePoints,'o','Color','red','Size',5);

J = insertMarker(J,TopLeft,'plus','Color','cyan','Size',10);
J = insertMarker(J,BottomRight,'plus','Color','cyan','Size',10);

imshow(J);
title(sprintf('Detected a %d x %d Checkerboard',boardSize));
%figure(1);

rectangle('Position',[TopLeft abs(BottomRight-TopLeft)])