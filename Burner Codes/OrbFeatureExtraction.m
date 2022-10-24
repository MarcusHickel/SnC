Image1 = 'ASY1.jpg';
Image2 = 'ASY4.jpg';


I1gs = rgb2gray (imread(Image1));
I2gs = rgb2gray (imread(Image2));

ROI1 = BoxFind(Image1);
ROI2 = BoxFind(Image2);

points1 = detectORBFeatures(I1gs,'ROI',ROI1);
points2 = detectORBFeatures(I2gs,'ROI',ROI2);

[features1, validPoints1] = extractFeatures(I1gs,points1);
[features2, validPoints2] = extractFeatures(I2gs,points2);

indexPairs = matchFeatures(features1,features2);

matchedPoints1 = validPoints1(indexPairs(:,1));
matchedPoints2 = validPoints2(indexPairs(:,2));

showMatchedFeatures(I1gs,I2gs,matchedPoints1,matchedPoints2,'montage');