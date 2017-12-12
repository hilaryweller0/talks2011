% schematic of bottom bc

clear
hold off

x = (1:100)*0.03;


y = exp(-(x*33-50.0).^2 / 400.0);
plot(x,y,'k')
axis off
axis([0,3.0,0,1.2])

hold on

for k=5:2:95
    xx = [x(k),x(k)];
    yy = [0.0,y(k)];
    plot(xx,yy,'b')
end

xx = [x(25),x(37),x(37)-0.1,x(37),x(37)];
yy = [y(25),y(37),y(37),y(37),y(37)-0.1] + 0.3;
plot(xx,yy,'k')
