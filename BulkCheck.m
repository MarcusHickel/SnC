clear all
close all

Prefix = 'ROTE';

j = length(dir(['Testimages/', Prefix, '*.jpg']));

figure;
h = zeros(ceil(sqrt(j)));

for i = 1:j
    h(i) = subplot(ceil(sqrt(j)),ceil(sqrt(j)),i);
    imageName = strcat(Prefix, num2str(i), '.jpg');
    try
    [roi, Corners, Reddiff, Bluediff]= BoxFind(imageName,0);
    [thetaRecovered, scaleRecovered] = RotationDetect(imageName);
    
    I = imread(imageName);

    % Add Blue Lines
    J = insertShape(I,'Line',[[Corners(1,:)] [Corners(2,:)]],'LineWidth',2,'Color','blue');
    J = insertShape(J,'Line',[[Corners(3,:)] [Corners(4,:)]],'LineWidth',2,'Color','blue');
    
    % Add Red Lines
    J = insertShape(J,'Line',[[Corners(1,:)] [Corners(3,:)]],'LineWidth',2,'Color','red');
    J = insertShape(J,'Line',[[Corners(2,:)] [Corners(4,:)]],'LineWidth',2,'Color','red');

    imshow(J);
    title(sprintf('BlueDiff %4.2f RedDiff %4.2f Rotation %4.2f' ,Bluediff, Reddiff, thetaRecovered));
    catch
    fprintf('Failed on number %d \n', i)
    end
end