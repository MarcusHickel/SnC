function [roi] = BoxFind(image)
%Find the bounding box of a checker board pattern
%   outputs the topleft and bottom right coordinates of the boudning box
% Marcus
I = imread(image);% Detect the checkerboard points.

[imagePoints,boardSize] = detectCheckerboardPoints(I);

%Finding the bounding box of the checkerboard
TopLeft = min(imagePoints);
BottomRight = max(imagePoints);
BottomLeft = [TopLeft(1,1), BottomRight(1,2)];

% Adding Markers
J = insertText(I,imagePoints,1:size(imagePoints,1));
J = insertMarker(J,imagePoints,'o','Color','red','Size',5);

J = insertMarker(J,TopLeft,'plus','Color','cyan','Size',10);
J = insertMarker(J,BottomRight,'plus','Color','cyan','Size',10);

J = insertMarker(J,BottomLeft,'plus','Color','green','Size',10);

imshow(J);
title(sprintf('Detected a %d x %d Checkerboard',boardSize));
%figure(1);

rectangle('Position',[TopLeft abs(BottomRight-TopLeft)])
roi = [TopLeft abs(BottomRight-TopLeft)];
end
