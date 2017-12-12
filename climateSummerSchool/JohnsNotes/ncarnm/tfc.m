% schematic of terrain following coordinate

clear
hold off

x = 1:100;

subplot(1,2,1)

y = exp(-(x-50.0).^2 / 100.0);
plot(x,y,'k')
axis off

hold on

for k=5:2:95
    xx = [x(k),x(k)];
    yy = [0.0,y(k)];
    plot(xx,yy,'b')
end

y = y + 0.4;
plot(x,y,'k')


y = y + 0.4;
plot(x,y,'k')

y = y + 0.4;
plot(x,y,'k')

y = y + 0.4;
plot(x,y,'k')

y = y + 0.4;
plot(x,y,'k')

y = y + 0.4;
plot(x,y,'k')

axis([0,100,0,2.2])


subplot(1,2,2)

y = exp(-(x-50.0).^2 / 100.0);
plot(x,y,'k')
axis off

hold on

for k=5:2:95
    xx = [x(k),x(k)];
    yy = [0.0,y(k)];
    plot(xx,yy,'b')
end

y0 = y;

y = 0.8*y0 + 0.4;
plot(x,y,'k')


y = 0.6*y0 + 0.8;
plot(x,y,'k')

y = 0.4*y0 + 1.2;
plot(x,y,'k')

y = 0.2*y0 + 1.6;
plot(x,y,'k')

y = 0.0*y0 + 2.0;
plot(x,y,'k')

y = y + 0.4;
plot(x,y,'k')

axis([0,100,0,2.2])
