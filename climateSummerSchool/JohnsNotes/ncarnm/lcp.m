% Schematic of Lorenz and Charney-Phillips grids

clear
hold off

subplot(1,2,1)

xx = [0.25,0.75];
yy = [0,0];
plot(xx,yy,'k')
axis off
axis([0,1,-0.5,2])
hold on

yy = [0.5,0.5];
plot(xx,yy,'k--')

yy = [1.0,1.0];
plot(xx,yy,'k')

yy = [1.5,1.5];
plot(xx,yy,'k--')

text(0.8,0,'u, v, \theta','FontSize',20)

%text(0.8,0.5,'\eta, p','FontSize',20)

text(0.8,1.0,'u, v, \theta','FontSize',20)

%text(0.8,1.5,'\eta, p','FontSize',20)



subplot(1,2,2)

xx = [0.25,0.75];
yy = [0,0];
plot(xx,yy,'k')
axis off
axis([0,1,-0.5,2])
hold on

yy = [0.5,0.5];
plot(xx,yy,'k--')

yy = [1.0,1.0];
plot(xx,yy,'k')

yy = [1.5,1.5];
plot(xx,yy,'k--')

text(0.8,0,'u, v','FontSize',20)

text(0.8,0.5,'\theta','FontSize',20)

text(0.8,1.0,'u, v','FontSize',20)

text(0.8,1.5,'\theta','FontSize',20)

