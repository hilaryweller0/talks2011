% schematic of bottom bc - eta step coord

clear
hold off

x = (1:300)*0.01;


y = exp(-(x*33-50.0).^2 / 200.0);
y = 0.2 * floor(y/0.2);

plot(x,y,'k')
axis off
axis([0,3.0,0,1.6])

hold on

for k=17:6:285
    xx = [x(k),x(k)];
    yy = [0.0,y(k)];
    plot(xx,yy,'b')
end

xx = [0.0,1.0];
yy = [0.2,0.2];
plot(xx,yy,'k--')

xx = 3.0 - xx;
plot(xx,yy,'k--')

xx = [0,1.15];
yy = [0.4,0.4];
plot(xx,yy,'k--')

xx = 3.0 - xx;
plot(xx,yy,'k--')

xx = [0,1.3];
yy = [0.6,0.6];
plot(xx,yy,'k--')

xx = 3.0 - xx;
plot(xx,yy,'k--')

xx = [0,1.45];
yy = [0.8,0.8];
plot(xx,yy,'k--')

xx = 3.0 - xx;
plot(xx,yy,'k--')

xx = [0,3.0];
yy = [1.0,1.0];
plot(xx,yy,'k--')

xx = [0,3.0];
yy = [1.2,1.2];
plot(xx,yy,'k--')



%xx = [x(25),x(37),x(37)-0.1,x(37),x(37)];
%yy = [y(25),y(37),y(37),y(37),y(37)-0.1] + 0.3;
%plot(xx,yy,'k')
