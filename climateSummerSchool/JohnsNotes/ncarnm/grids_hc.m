% To plot schematics of A-E and Z grids



subplot(2,3,1)

x = [0.2 0.2];
y = [0 1];
plot(x,y,'k')
axis off
hold on
x = [0.8 0.8];
y = [0 1];
plot(x,y,'k')
x = [0 1];
y = [0.2 0.2];
plot(x,y,'k')
x = [0 1];
y = [0.8 0.8];
plot(x,y,'k')
text(0.42,0.5,'\fontsize{16} u v \Phi')
title('\fontsize{16} A-grid')
hold off

subplot(2,3,2)

x = [0.2 0.2];
y = [0 1];
plot(x,y,'k')
axis off
hold on
x = [0.8 0.8];
y = [0 1];
plot(x,y,'k')
x = [0 1];
y = [0.2 0.2];
plot(x,y,'k')
x = [0 1];
y = [0.8 0.8];
plot(x,y,'k')

  text(0.46,0.5,'\fontsize{16} \Phi')
  text(0.2,0.85,'\fontsize{16} u v')
  text(0.8,0.85,'\fontsize{16} u v')
  text(0.2,0.25,'\fontsize{16} u v')
  text(0.8,0.25,'\fontsize{16} u v')
  title('\fontsize{16} B-grid')
  hold off

subplot(2,3,3)

x = [0.2 0.2];
y = [0 1];
plot(x,y,'k')
axis off
hold on
x = [0.8 0.8];
y = [0 1];
plot(x,y,'k')
x = [0 1];
y = [0.2 0.2];
plot(x,y,'k')
x = [0 1];
y = [0.8 0.8];
plot(x,y,'k')

  text(0.46,0.5,'\fontsize{16} \Phi')
  text(0.2,0.5,'\fontsize{16} u')
  text(0.8,0.5,'\fontsize{16} u')
  text(0.46,0.25,'\fontsize{16} v')
  text(0.46,0.85,'\fontsize{16} v')
  title('\fontsize{16} C-grid')
hold off
  
subplot(2,3,4)

x = [0.2 0.2];
y = [0 1];
plot(x,y,'k')
axis off
hold on
x = [0.8 0.8];
y = [0 1];
plot(x,y,'k')
x = [0 1];
y = [0.2 0.2];
plot(x,y,'k')
x = [0 1];
y = [0.8 0.8];
plot(x,y,'k')

  text(0.46,0.5,'\fontsize{16} \Phi')
  text(0.2,0.5,'\fontsize{16} v')
  text(0.8,0.5,'\fontsize{16} v')
  text(0.46,0.25,'\fontsize{16} u')
  text(0.46,0.85,'\fontsize{16} u')
  title('\fontsize{16} D-grid')
  hold off

subplot(2,3,5)

x = [0.2 0.2];
y = [0 1];
plot(x,y,'k')
axis off
hold on
x = [0.8 0.8];
y = [0 1];
plot(x,y,'k')
x = [0 1];
y = [0.2 0.2];
plot(x,y,'k')
x = [0 1];
y = [0.8 0.8];
plot(x,y,'k')

  text(0.46,0.5,'\fontsize{16} \Phi')
  text(0.2,0.85,'\fontsize{16} \Phi')
  text(0.8,0.85,'\fontsize{16} \Phi')
  text(0.2,0.25,'\fontsize{16} \Phi')
  text(0.8,0.25,'\fontsize{16} \Phi')
  text(0.2,0.5,'\fontsize{16} u v')
  text(0.8,0.5,'\fontsize{16} u v')
  text(0.44,0.25,'\fontsize{16} u v')
  text(0.44,0.85,'\fontsize{16} u v')
  title('\fontsize{16} E-grid')
  hold off
  
subplot(2,3,6)

x = [0.2 0.2];
y = [0 1];
plot(x,y,'k')
axis off
hold on
x = [0.8 0.8];
y = [0 1];
plot(x,y,'k')
x = [0 1];
y = [0.2 0.2];
plot(x,y,'k')
x = [0 1];
y = [0.8 0.8];
plot(x,y,'k')

  text(0.42,0.5,'\fontsize{16} \xi \delta \Phi')
  title('\fontsize{16} Z-grid')
  hold off






hold off