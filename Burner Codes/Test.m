%% Question 1
clear all
close all
try 
    rosinit
catch
    fprintf('Already Running')
end
sub = rossubscriber('/usb_cam/image_raw');
[pub,msg] = rospublisher('/usb_cam/image_raw')

[scanData,~,~] = receive(sub,100000000);
[scanData2,status,statustext] = receive(sub,100000);

original = rgb2gray (scanData.readImage);
distorted = rgb2gray (scanData2.readImage);

ptsOriginal = detectSURFFeatures(original);
ptsDistorted = detectSURFFeatures(distorted);
[featuresOriginal, validPtsOriginal] = extractFeatures(original,ptsOriginal);
[featuresDistorted, validPtsDistorted] = extractFeatures(distorted,ptsDistorted);

indexPairs = matchFeatures(featuresOriginal,featuresDistorted);
matchedOriginal = validPtsOriginal(indexPairs(:,1));
matchedDistorted = validPtsDistorted(indexPairs(:,2));

figure(1);
showMatchedFeatures(original,distorted,matchedOriginal,matchedDistorted,'montage');
hold on;

imshow(scanData.readImage);
imshow(scanData2.readImage);
% 
% 
% msg = scanData;
% send(pub,msg);
%msg = sub.LatestMessage.Data;
% img = rosReadImage(msg);    
% imshow(msg);
rosshutdown
