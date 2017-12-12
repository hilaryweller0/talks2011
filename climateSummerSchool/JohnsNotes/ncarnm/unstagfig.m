% To illustrate 1D unstaggered grid and SW dispersion relation

subplot(1,2,1)

x = [0, 1];
y = [0, 0];
plot(x,y,'k')
axis([0,1,-1,1])
axis off
hold on

x = [0.1, 0.1];
y = [-0.05, 0.05];
plot(x,y,'k')

x = [0.5, 0.5];
y = [-0.05, 0.05];
plot(x,y,'k')

x = [0.9, 0.9];
y = [-0.05, 0.05];
plot(x,y,'k')

text(0.085,0.2,'u','FontSize',16)
text(0.485,0.2,'u','FontSize',16)
text(0.885,0.2,'u','FontSize',16)
text(0.08,0.38,'\Phi','FontSize',16)
text(0.48,0.38,'\Phi','FontSize',16)
text(0.88,0.38,'\Phi','FontSize',16)


text(0.07,-0.25,'j-1','FontSize',16)
text(0.495,-0.25,'j','FontSize',16)
text(0.87,-0.25,'j+1','FontSize',16)
hold off


subplot(1,2,2)

kdx = linspace(0,pi);
freq0 = kdx;
freq1 = sin(kdx);

plot(kdx,freq0,'k',kdx,freq1,'k')
axis([-0.2,pi+0.2,-0.2,pi+0.5])
axis off
hold on

%xlabel('k \Delta x','FontSize',12)
%ylabel('\omega','FontSize',12)

x = [0,pi,pi,0,0];
y = [0,0,pi,pi,0];
plot(x,y,'k')

x = [0,0];
y = [-0.07,0];
plot(x,y,'k')
x = [0.5*pi,0.5*pi];
y = [-0.07,0];
plot(x,y,'k')
x = [pi,pi];
y = [-0.07,0];
plot(x,y,'k')
text(-0.04,-0.26,'0','FontSize',12)
text(0.5*pi-0.1,-0.26,'\pi/2','FontSize',12)
text(pi-0.05,-0.26,'\pi','FontSize',12)
text(1.4,-0.6,'k \Delta x','FontSize',14)


x = [0,0];
y = [pi,pi+0.07];
plot(x,y,'k')
x = [0.25*pi,0.25*pi];
y = [pi,pi+0.07];
plot(x,y,'k')
x = [0.5*pi,0.5*pi];
y = [pi,pi+0.07];
plot(x,y,'k')
x = [pi,pi];
y = [pi,pi+0.07];
plot(x,y,'k')
text(0.25*pi-0.04,3.3,'8','FontSize',12)
text(0.5*pi-0.05,3.3,'4','FontSize',12)
text(pi-0.04,3.3,'2','FontSize',12)
text(1.4,3.7,'L / \Delta x','FontSize',14)

text(-0.25,1.0,'Frequency','Rotation',90,'FontSize',12)


hold off

