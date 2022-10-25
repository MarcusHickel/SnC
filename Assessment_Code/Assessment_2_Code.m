clear all
close all

% Initiates ROS Bridge if not
try 
    rosinit;
catch
    fprintf('ROS is running')
end

% ROS Subscriber to USB Cam Node
sub = rossubscriber('/usb_cam/image_raw');

% Base Image Received
[scanDataBL,~,~] = receive(sub,100);
imwrite(scanDataBL.readImage,'Baseline.jpg');
Baseline = 'Baseline.jpg';

% Figure 1 Set Up for Translation Vector
figure(1);
title('Translation Vector'); 
pl = line(0,0);
xline(0);
yline(0);
ylabel('Vertical Translation');
xlabel('Horizontal Translation');
axis([-240 240 -240 240]);

while true
    tic;
    %Second Image Received
    [scanData,~,~] = receive(sub,100);
    imwrite(scanData.readImage,'Shifted.jpg')
    imageName='Shifted.jpg';

    scanTime = toc ; % Time's Will Be Seen Throughout for Optimisation

    % Image Comparison, Compares Shifted.jpg to Baseline.jpg
    try % Try and catch will continue even if any function fails
         %Timer Start    
        try
            tic
            [roi1, imageCorners, Reddiff, Bluediff]= BoxFind(imageName,0); % Finds Box of Interest Compared to Baseline Image
            [roi2, refrenceCorners, ~, ~]= BoxFind(Baseline,0);
            Boxfindtime = toc;
        catch
            fprintf('Failed on BoxFind')
        end
        try
            tic
            [thetaRecovered, scaleRecovered] = RotationDetect(Baseline, imageName, roi1, roi2); % Finds Angle of Roation in Degrees
            Rotetime = toc;
        catch
            fprintf('Failed on RotationDetect\n')
        end
        try
            tic
            [translationVector, refMidpoint, imgMidpoint] = Translation(Baseline,imageName,refrenceCorners,imageCorners,0); % Finds Translation Vector
            transtime = toc;
        catch
            fprintf('Failed on translationVector')
        end

        calcTime = Boxfindtime + Rotetime + transtime; %Timer Stop
        
        tic;

        figure(1); % Show Translation Vector from Origin
        pl.XData = [0 ,translationVector(1)];
        pl.YData = [0, translationVector(2)];
                
        dispTime = toc;
      
        tic;

        % Show Rotation Required 
        ShowTheWay(Bluediff, Reddiff, thetaRecovered);
        ShowTime = toc;

        fprintf('BlueDiff %v4.2f RedDiff %4.2f \nRotation %4.2f \nTranslation vector: X:%4.2f Y:%4.2f \n' ,Bluediff, Reddiff, thetaRecovered, translationVector)
        fprintf('Box %4.2f, Rote %4.2f, Trans %4.2f',Boxfindtime, Rotetime, transtime)
        fprintf('Scan time %4.2fs. Display Time %4.2fs. Calc Time %4.2fs ShowDeWay %4.2fs. Total %4.2f\n',scanTime, dispTime, calcTime, ShowTime, (scanTime+dispTime+calcTime+ShowTime))
    catch
        fprintf('Failed\n')
    end 
end