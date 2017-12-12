% To plot schematics of A-E and Z grids


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

igrid = input('Which grid > ? ');

if igrid == 1
  text(0.42,0.5,'\fontsize{24} u v \Phi')
end


if igrid == 2
  text(0.46,0.5,'\fontsize{24} \Phi')
  text(0.2,0.85,'\fontsize{24} u v')
  text(0.8,0.85,'\fontsize{24} u v')
  text(0.2,0.25,'\fontsize{24} u v')
  text(0.8,0.25,'\fontsize{24} u v')
end


if igrid == 3
  text(0.46,0.5,'\fontsize{24} \Phi')
  text(0.2,0.5,'\fontsize{24} u')
  text(0.8,0.5,'\fontsize{24} u')
  text(0.46,0.25,'\fontsize{24} v')
  text(0.46,0.85,'\fontsize{24} v')
end


if igrid == 4
  text(0.46,0.5,'\fontsize{24} \Phi')
  text(0.2,0.5,'\fontsize{24} v')
  text(0.8,0.5,'\fontsize{24} v')
  text(0.46,0.25,'\fontsize{24} u')
  text(0.46,0.85,'\fontsize{24} u')
end


if igrid == 5
  text(0.46,0.5,'\fontsize{24} \Phi')
  text(0.2,0.85,'\fontsize{24} \Phi')
  text(0.8,0.85,'\fontsize{24} \Phi')
  text(0.2,0.25,'\fontsize{24} \Phi')
  text(0.8,0.25,'\fontsize{24} \Phi')
  text(0.2,0.5,'\fontsize{24} u v')
  text(0.8,0.5,'\fontsize{24} u v')
  text(0.44,0.25,'\fontsize{24} u v')
  text(0.44,0.85,'\fontsize{24} u v')
end


if igrid == 6
  text(0.42,0.5,'\fontsize{24} \xi \delta \Phi')
end






hold off