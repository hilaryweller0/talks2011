% Explicit, centred difference finite difference equations to solve
% linear advection:
% dTdt + u dTdx + vdTdy = 0
% ie Tnew = Told - dt (u (Twest - Teast)/dx + v (Tnorth - Tsouth)/dy)

% x y positions of the grid
Lx = 250e3;
Ly = 250e3;
dx = 100e3;
dy = 100e3;
x = -Lx:dx:Lx;
y = -Ly:dy:Ly;

% fixed and initial conditions:
r = zeros(length(x), length(y));
u = zeros(length(x), length(y));
v = zeros(length(x), length(y));
T = zeros(length(x), length(y));
V = 10;
R = Lx;
Tmid = 20;
Tdiffy = -5;
Tdiffx = 0;

for i = 1:length(x)
    for j = 1:length(y)
        r(i,j) = sqrt(x(i)^2 + y(j)^2);
        u(i,j) = -V/Lx*y(j);
        v(i,j) = V/Ly*x(i);
        T(i,j) = Tmid + y(j)/Ly*Tdiffy + x(i)/Lx*Tdiffx;
    endfor
endfor
Tnew = T;

% function to display the results
function displayT(x, y, u, v, it, T)
    h = image(x/1000,y/1000,T');
    set(gca,"ydir", "normal","clim",[15,28]);
    set(gca, "gridlinestyle", "-", "xgrid", "on", "ygrid", "on");
    set(h,'CDataMapping','scaled');
    hc = colorbar;
    set(hc, "ytick", 15:28);
    %xlabel('East-West / km');
    %ylabel('North-South / km');
    set(gcf, "papersize", [8.5,8.5]);
    hold on
    quiver(x/1000,y/1000,u',v',8,"k", "linewidth", 2);
    hold off
    title(sprintf("%s%i%s", "Temperature after ", it, " hours"));
endfunction

displayT(x, y, u, v, 0, T);
print("Tinit.eps", "-deps", "-color", "-tight", "-FTimes-Roman:12", "-S160,120");

printf("%s%i%s\n", "Time step ", 0, " press return");
pause

dt = 3600;
nt = 3;

for it = 1:nt;
    T = Tnew;
    for i = 2:length(x)-1
        for j = 2:length(y)-1
            Tnew(i,j) = 0.1*round(10*(...
                        T(i,j) - 0.5*dt*(u(i,j)*(T(i+1,j) - T(i-1,j))/dx ...
                                       + v(i,j)*(T(i,j+1) - T(i,j-1))/dy)));
        endfor
    endfor
    
    if (it == 2) % add 2 to T in Swansea, Bristol and Southend and 5 to London
        Tnew(2,2) = Tnew(2,2)+2;
        Tnew(3,2) = Tnew(3,2)+2;
        Tnew(4,2) = Tnew(4,2)+5;
        Tnew(5,2) = Tnew(5,2)+2;
    endif
    
    if (it == 2) % subtract 4 from Snowdon temperature
        Tnew(2,3) = Tnew(2,3) - 4;
    endif
%    
%    if (it == 4) % subtract 5 from temp in Peterborough and Norwich
%        Tnew(4,3) = Tnew(4,3) - 5;
%        Tnew(5,3) = Tnew(5,3) - 5;
%    endif
    
    printf("minimum temperature = %g, maximum = %g\n", min(min(Tnew)), max(max(Tnew)));
    displayT(x, y, u, v, it, Tnew);
    print(sprintf("T%i.eps", it), "-deps", "-color", "-tight", "-FTimes-Roman:12", "-S160,120");
    Tnew(1:end,end:-1:1)'
    printf("%s%i%s\n", "Time step ", it, " press return");
    pause
endfor

