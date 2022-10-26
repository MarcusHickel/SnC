%Initiates ROS Bridge if not
clear all
close all

try 
    rosinit;
catch
    fprintf('ROS is running')
end

%ROS Subscriber to USB Cam Node
sub = rossubscriber('/usb_cam/image_raw');

%Base Image Received
[scanDataBL,~,~] = receive(sub,100);
imwrite(scanDataBL.readImage,'Baseline.jpg');
Baseline = 'Baseline.jpg';

figure(1);
sgtitle('Camera Vectors'); 
subplot(2,2,3);
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
    
    imwrite(scanData.readImage,'Shifted.jpg');

    imageName='Shifted.jpg';
    scanTime = toc ;
    %Image Comparison, Compares Shifted.jpg to Baseline.jpg
    try % Try and catch will continue even if any function fails
         %Timer Start    
        try
            tic
            [roi1, imageCorners, Reddiff, Bluediff]= BoxFind(imageName,0);
            [roi2, refrenceCorners, ~, ~]= BoxFind(Baseline,0);
            Boxfindtime = toc;
        catch
            fprintf('Failed on BoxFind')
        end
        try
            tic
            [thetaRecovered, scaleRecovered] = RotationDetect(Baseline, imageName, roi1, roi2);
            Rotetime = toc;
        catch
            fprintf('Failed on RotationDetect\n')
        end
        try
            tic
            [translationVector, refMidpoint, imgMidpoint] = Translation(Baseline,imageName,refrenceCorners,imageCorners,0);
            transtime = toc;
        catch
            fprintf('Failed on translationVector')
        end

        calcTime = Boxfindtime + Rotetime + transtime; %Timer Stop
        
        tic;
%         I = imread(imageName);
%     
%         % Add Blue Lines
%         J = insertShape(I,'Line',[[Corners(1,:)] [Corners(2,:)]],'LineWidth',2,'Color','blue');
%         J = insertShape(J,'Line',[[Corners(3,:)] [Corners(4,:)]],'LineWidth',2,'Color','blue');
%         
%         % Add Red Lines
%         J = insertShape(J,'Line',[[Corners(1,:)] [Corners(3,:)]],'LineWidth',2,'Color','red');
%         J = insertShape(J,'Line',[[Corners(2,:)] [Corners(4,:)]],'LineWidth',2,'Color','red');
%         
%         % Add translation Vector
%         J = insertShape(J,'Line',[refMidpoint, (refMidpoint-translationVector)],'LineWidth',2,'Color','magenta');
%         J = insertMarker(J,refMidpoint,"circle");
        
        
        %Show Live USB_CAM Feed
        %figure(1);
        %imshow(J);
        %title(sprintf('BlueDiff %4.2f RedDiff %4.2f \nRotation %4.2f \nTranslation vector: X:%4.2f Y:%4.2f \nTime %4.2fs' ,Bluediff, Reddiff, thetaRecovered, translationVector, calcTime));
        
        figure(1);
        pl.XData = [0 ,translationVector(1)];
        pl.YData = [0 , -translationVector(2)];
        
        %line([0 ,translationVector(1)], [0, translationVector(2)],'Color','red')T
        
        dispTime = toc;
      
        tic;
        %Show Rotation Required 
        ShowTheWay(-Bluediff, Reddiff, thetaRecovered);
        ShowTime = toc;

        fprintf('BlueDiff %v4.2f RedDiff %4.2f \nRotation %4.2f \nTranslation vector: X:%4.2f Y:%4.2f \n' ,Bluediff, Reddiff, thetaRecovered, translationVector)
        fprintf('Box %4.2f, Rote %4.2f, Trans %4.2f',Boxfindtime, Rotetime, transtime)
        fprintf('Scan time %4.2fs. Display Time %4.2fs. Calc Time %4.2fs ShowDeWay %4.2fs. Total %4.2f\n',scanTime, dispTime, calcTime, ShowTime, (scanTime+dispTime+calcTime+ShowTime))
    catch
        fprintf('Failed\n')
    end 
end