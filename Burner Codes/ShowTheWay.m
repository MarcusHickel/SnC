function [plotGraph] = ShowTheWay(theta)

if theta>0
    t = linspace( pi/2, -pi/2, 100);
    xt=sin(t);
    yt=cos(t);
    zt=0;
else
    xt=-sin(t);
    yt=cos(t);
end

figure(1)
plot3(xt,yt,zt);
end