
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

Dumfries     = ;
Carlisle     = ;
Newcastle    = ;
Dogger       = ;
IrishSea     = ;
Manchester   = ;
Grimsby      = ;
Humber       = ;
Snowdon      = ;
Birmingham   = ;
Peterborough = ;
Norwich      = ;
Swansea      = ;
Bristol      = ;
London       = ;
Southend     = ;

T = [T(1,:);...
     T(2,1) Swansea Snowdon IrishSea Dumfries       T(2,6);...
     T(3,1)  Bristol Birmingham Manchester Carlisle T(3,6); ...
     T(4,1)  London Peterborough Grimsby Newcastle  T(4,6); ...
     T(5,1)  Southend Norwich Humber Dogger         T(5,6);...
     T(6,:)];


% function to display the results
function displayT(x, y, u, v, it, T)
    h = image(x/1000,y/1000,T');
    set(h,'CDataMapping','scaled');
    h = colorbar;
    set(h, "ytick", 15:25);
    set(gca,"ydir", "normal","clim",[15,25]);
    set(gca, "gridlinestyle", "-", "xgrid", "on", "ygrid", "on");
    %xlabel('East-West / km');
    %ylabel('North-South / km');
    set(gcf, "papersize", [8.5,8.5]);
    hold on
    quiver(x/1000,y/1000,u',v',8,"k", "linewidth", 2);
    hold off
    title(sprintf("%s%i%s", "Temperature after ", it, " hours"));
endfunction

displayT(x, y, u, v, 4, T);

