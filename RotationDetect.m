function [thetaRecovered, scaleRecovered] = RotationDetect(Baseline, Image, ROI1, ROI2)
Image1 = Baseline;
Image2 = Image;

% ROI1 = BoxFind(Image1,0);
% ROI2 = BoxFind(Image2,0);

%The following lines are from the tutorial 

%Convert to grey scale
original = rgb2gray (imread(Image1));
distorted = rgb2gray (imread(Image2));

%SURF
ptsOriginal = detectSURFFeatures(original,'ROI',ROI1);
ptsDistorted = detectSURFFeatures(distorted,'ROI',ROI2);

%Extracting the points from SURF
[featuresOriginal, validPtsOriginal] = extractFeatures(original,ptsOriginal);
[featuresDistorted, validPtsDistorted] = extractFeatures(distorted,ptsDistorted);

%Matching the SURF points
indexPairs = matchFeatures(featuresOriginal,featuresDistorted);
matchedOriginal = validPtsOriginal(indexPairs(:,1));
matchedDistorted = validPtsDistorted(indexPairs(:,2));

% figure;
% showMatchedFeatures(original,distorted,matchedOriginal,matchedDistorted,'montage');

%Generate transform matrix
[tform,~,~] = estimateGeometricTransform (matchedDistorted,matchedOriginal,'similarity');

% figure;
% showMatchedFeatures(original,distorted,inlierOriginal,inlierDistorted,'montage');
% title('Matching point (inliers only)');
% legend ('ptsOriginal','ptsDistorted');

% Extract theta and scale from martix
Tinv = tform.invert.T;
ss = Tinv(2,1);
sc = Tinv(1,1);
scaleRecovered = sqrt(ss*ss+sc*sc); %Unused at the moment, if position from camera is needed use this.
thetaRecovered = atan2(ss,sc)*180/pi;

% outputView = imref2d(size(original));
% recovered = imwarp(distorted,tform,'OutputView',outputView);
% figure;
% imshowpair(original,recovered,'montage');
end