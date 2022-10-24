
try 
    rosinit;
catch
    fprintf('ROS is running')
end

sub = rossubscriber('/usb_cam/image_raw');
% [pub,msg] = rospublisher('/usb_cam/image_raw')

[scanDataBL,~,~] = receive(sub,100);
imwrite(scanDataBL.readImage,'BBaby.jpg');
Baseline = 'BBaby.jpg';

while true
    
    [scanData,~,~] = receive(sub,100);
    
    imwrite(scanData.readImage,'FailBaby.jpg');

    imageName='FailBaby.jpg';
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
            fprintf('Failed on RotationDetect\n')
        end
        try
            [translationVector] = Translation(Baseline,imageName,0);
        catch
            fprintf('Failed on translationVector')
        end

        time = toc; %Timer Stop
    
        I = imread(imageName);
    
        % Add Blue Lines
        J = insertShape(I,'Line',[[Corners(1,:)] [Corners(2,:)]],'LineWidth',2,'Color','blue');
        J = insertShape(J,'Line',[[Corners(3,:)] [Corners(4,:)]],'LineWidth',2,'Color','blue');
        
        % Add Red Lines
        J = insertShape(J,'Line',[[Corners(1,:)] [Corners(3,:)]],'LineWidth',2,'Color','red');
        J = insertShape(J,'Line',[[Corners(2,:)] [Corners(4,:)]],'LineWidth',2,'Color','red');
        
        % Add translation Vector
        J = insertShape(J,'Line',[refMidpoint, (refMidpoint-translationVector)],'LineWidth',2,'Color','magenta');
        J = insertMarker(J,refMidpoint,"circle");
        
        imshow(J);
        title(sprintf('BlueDiff %4.2f RedDiff %4.2f \nRotation %4.2f \nTranslation vector: X:%4.2f Y:%4.2f \nTime %4.2fs' ,Bluediff, Reddiff, thetaRecovered, translationVector, time));
        fprintf('Processed image in %4.2f Seconds\n',time)
    catch
        fprintf('Failed\n')

    end
end