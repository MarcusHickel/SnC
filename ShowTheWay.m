function [RotateME] = ShowTheWay(blue,red)

figure(2);
sgtitle('PIVOT!');
%Horizontal Rotation Arrow Shown
plot(red,blue,'o');
yline(0);
xline(0);
if (blue>80) || (red>80) || (blue<-80) || (red<-80)
    axis([-100 100 -100 100]);
elseif (blue>60) || (red>60) || (blue<-60) || (red<-60)
    axis([-80 80 -80 80])
elseif (blue>40) || (red>40) || (blue<-40) || (red<-40)
    axis([-60 60 -60 60]);
else
    axis([-40 40 -40 40]);
end

grid on;
end

%Vertical Rotation Arrow Shown
% subplot(1,2,2);
% if red>0
%     imshow("BackRotate.jpg");
% else
%     imshow("ForwardRotate.jpg");
% end
% 
% end