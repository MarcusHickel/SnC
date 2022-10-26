function [RotateME] = ShowTheWay(blue,red,theta)

figure(1);
% sgtitle('PIVOT!');
% Shows the Horizontal and Vertical Rotation
subplot(2,2,1);
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


% Displays the "Perpendicular" Rotation
subplot(2,2,4);
polarplot([0 theta]*pi/180, [0; 1]*50);
end