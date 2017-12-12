% plots to demonstrate Fourier decompositions

x = 0:pi/45:2*pi;
y2 = ((N-oneModes(1))/N*sin(oneModes(1)*x) + oneModes(1)/N*cos(oneModes(1)*x));

for j = 2:floor(length(oneModes)/2)
    y2 = y2 +(N-oneModes(j))/N*sin(oneModes(j)*x) + oneModes(j)/N*cos(oneModes(j)*x);
endfor

y = y2;
for j = floor(length(oneModes)/2)+1:length(oneModes)
    y = y + (N-oneModes(j))/N*sin(oneModes(j)*x) + oneModes(j)/N*cos(oneModes(j)*x);
endfor

plot(x, y, 'k', x, y2, 'r', "linewidth", 4);
print -solid 'realSpace.eps'

plot(x, (N-oneModes(1))/N*sin(oneModes(1)*x) + oneModes(1)/N*cos(oneModes(1)*x),...
     x, (N-oneModes(2))/N*sin(oneModes(2)*x) + oneModes(2)/N*cos(oneModes(2)*x),...
     x, (N-oneModes(3))/N*sin(oneModes(3)*x) + oneModes(3)/N*cos(oneModes(3)*x));
print -solid 'firstModes.eps'

plot(x, (N-oneModes(4))/N*sin(oneModes(4)*x) + oneModes(4)/N*cos(oneModes(4)*x),...
     x, (N-oneModes(5))/N*sin(oneModes(5)*x) + oneModes(5)/N*cos(oneModes(5)*x),...
     x, (N-oneModes(6))/N*sin(oneModes(6)*x) + oneModes(6)/N*cos(oneModes(6)*x));
print -solid 'lastModes.eps'

