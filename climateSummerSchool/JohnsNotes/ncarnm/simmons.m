% Schematic of Simmons and Burridge coordinate

clear
hold off

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

text(0.8,0,'u, v, T','FontSize',24)

text(0.8,0.5,'\eta, p','FontSize',24)

text(0.8,1.0,'u, v, T','FontSize',24)

text(0.8,1.5,'\eta, p','FontSize',24)

text(0.,0,'k+1','FontSize',24)

text(0.,0.5,'k+1/2','FontSize',24)

text(0.,1,'k','FontSize',24)

text(0.,1.5,'k-1/2','FontSize',24)