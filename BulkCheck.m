clear all
close all

Prefix = 'Tsy';

j = length(dir(['Testimages/', Prefix, '*.jpg']));

refImg = strcat(Prefix, num2str(1), '.jpg');

figure;
h = zeros(ceil(sqrt(j)));

for i = 1:j
    
    h(i) = subplot(ceil(sqrt(j)),ceil(sqrt(j)),i);
    img = strcat(Prefix, num2str(i), '.jpg');
    try % Try and catch will continue even if any function fails
    tic; %Timer Start    
    [roi, Corners, Reddiff, Bluediff]= BoxFind(img,0);
    [thetaRecovered, scaleRecovered] = RotationDetect(refImg,img);
    [translationVector] = Translation(refImg,img,0);
    time = toc; %Timer Stop
    I = imread(img);

    % Add Blue Lines
    J = insertShape(I,'Line',[[Corners(1,:)] [Corners(2,:)]],'LineWidth',2,'Color','blue');
    J = insertShape(J,'Line',[[Corners(3,:)] [Corners(4,:)]],'LineWidth',2,'Color','blue');
    
    % Add Red Lines
    J = insertShape(J,'Line',[[Corners(1,:)] [Corners(3,:)]],'LineWidth',2,'Color','red');
    J = insertShape(J,'Line',[[Corners(2,:)] [Corners(4,:)]],'LineWidth',2,'Color','red');

    imshow(J);
    title(sprintf('BlueDiff %4.2f RedDiff %4.2f Rotation %4.2f translation vector: X:%4.2f Y:%4.2f Time %4.2f' ,Bluediff, Reddiff, thetaRecovered, translationVector, time));
    fprintf('Processed %d in %4.2f Seconds\n', i,time)
    catch
    fprintf('Failed on number %d \n', i)
    end
end