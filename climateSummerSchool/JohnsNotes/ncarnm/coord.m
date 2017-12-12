% Schematic of alternative vertical coordinate

clear
hold off

x = 1:100;

y = 0.0*x;
plot(x,y,'k--')
axis off
hold on

y = y + 2.5;
plot(x,y,'k--')

y = y + 2.5;
plot(x,y,'k--')

y = y + 2.5;
plot(x,y,'k--')

y = 1.5*sin(0.03*x - 1.3);
plot(x,y,'b')

y = y + 2.5;
plot(x,y,'b')

y = y + 2.5;
plot(x,y,'b')

y = y + 2.5;
plot(x,y,'b')

text(-5,2.5,'z','FontSize',22)
text(-5,3.75,'\eta','FontSize',22)