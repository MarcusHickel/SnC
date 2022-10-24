function [translationVector] = Translation(refrenceImage,image,showFigure)
%Calculates the translation vector of two images
%Marcus

% Get Baseline Corners
[~, refrenceCorners, ~, ~] = BoxFind(refrenceImage,0);

% Avg Baseline Corners
refMidpoint(1) = sum(refrenceCorners(:,1))/4;
refMidpoint(2) = sum(refrenceCorners(:,2))/4;



% Get Current image Corners
[~, imageCorners, ~, ~] = BoxFind(image,0);

% Avg current image Corners
imgMidpoint(1) = sum(imageCorners(:,1))/4;
imgMidpoint(2) = sum(imageCorners(:,2))/4;

% Calcuate Translation Vector
translationVector = refMidpoint-imgMidpoint;

if showFigure == true
    % Mark refrence image midpoint
    I = imread(refrenceImage);
    refrence = insertMarker(I,refMidpoint,"x-mark","Size",10,"Color","green");
    
    %Mark current image midpoint
    I = imread(image);
    img = insertMarker(I,imgMidpoint,"x-mark","Size",10,"Color","red");
    
    %Add vector
    img = insertShape(img,"line",[refMidpoint, imgMidpoint],"Color","magenta","LineWidth",3);
    
    %Show
    figure('Name','Translation Vector');
    imshowpair(refrence,img,"blend");
end

end