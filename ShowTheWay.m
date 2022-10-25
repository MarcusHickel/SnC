function [RotateME] = ShowTheWay(blue,red)

figure(2);
sgtitle('PIVOT!');
%Horizontal Rotation Arrow Shown

if (blue>40.5)
    blue=40;
    
elseif (red>40.5)
    red=40;
elseif (blue<-40.5)
    blue = -40;
elseif (red<-40.5)
    red = -40;
end
plot(blue,red,'o');
yline(0);
xline(0);
ylabel('Vertical Rotation');
xlabel('Horizontal Rotation');
axis([-40 40 -40 40]);
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