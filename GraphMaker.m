function [plotGraph] = ShowTheWay(theta)

if theta>0
    t = 0:pi/5:10*pi;
    xt=sin(t);
    yt=sin(t);
    zt=t;
else
    t=-0:pi/5:10*pi;
end

plot3(xt,yt,zt) = figure(1);