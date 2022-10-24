
try 
    rosinit;
catch
    fprintf('ROS is running')
end

sub = rossubscriber('/usb_cam/image_raw');
[pub,msg] = rospublisher('/usb_cam/image_raw')

[scanDataBL,~,~] = receive(sub,100);
Baseline = scanDataBL.readImage;

while true
    
    [scanData,~,~] = receive(sub,100);
    
    imageName = scanData.readImage;
    imshow(imageName);
    try % Try and catch will continue even if any function fails
    tic; %Timer Start    
        try
            [roi, Corners, Reddiff, Bluediff]= BoxFind(imageName,0);
        catch
            fprintf('Failed on BoxFind')
        end
        try
            [thetaRecovered, scaleRecovered] = RotationDetect(Baseline, imageName);
        catch
            fprintf('Failed on RotationDetect')
        end
    
    time = toc; %Timer Stop

    I = imread(imageName);

    % Add Blue Lines
    J = insertShape(I,'Line',[[Corners(1,:)] [Corners(2,:)]],'LineWidth',2,'Color','blue');
    J = insertShape(J,'Line',[[Corners(3,:)] [Corners(4,:)]],'LineWidth',2,'Color','blue');
    
    % Add Red Lines
    J = insertShape(J,'Line',[[Corners(1,:)] [Corners(3,:)]],'LineWidth',2,'Color','red');
    J = insertShape(J,'Line',[[Corners(2,:)] [Corners(4,:)]],'LineWidth',2,'Color','red');

    imshow(J);
    title(sprintf('BlueDiff %4.2f RedDiff %4.2f Rotation %4.2f Time %4.2f' ,Bluediff, Reddiff, thetaRecovered, time));
    catch
    fprintf('Failed\n')

    end
end