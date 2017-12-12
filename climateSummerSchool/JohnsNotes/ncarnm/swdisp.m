% Dispersion relations for linearized SWEs
% on staggered grids

kdx = linspace(0,pi,21);
ldy = linspace(0,pi,21);

[kk,ll] = meshgrid(kdx,ldy);

s1x = sin(kk);
s1y = sin(ll);
s2x = 2.0*sin(0.5*kk);
s2y = 2.0*sin(0.5*ll);
cx = cos(0.5*kk);
cy = cos(0.5*ll);

igrid = input('A grid (1), B grid (2) or C grid (3) > ? ')

if igrid == 1
    coriolfac = 1.0;
    ddxfac = s1x;
    ddyfac = s1y;
elseif igrid == 2
    coriolfac = 1.0;
    ddxfac = cy.*s2x;
    ddyfac = cx.*s2y;
elseif igrid == 3
    coriolfac = cx.*cy;
    ddxfac = s2x;
    ddyfac = s2y;
end

v = [0:10]*0.1;

% Well resolved Rossby radius

r = 0.2;

w2ex = (1.0 + (kk.^2 + ll.^2)/(r*r));
w2fd = (coriolfac + (ddxfac.*ddxfac + ddyfac.*ddyfac)/(r*r));

ratio = sqrt(w2fd./w2ex);

subplot(1,2,1)
[cc,hh] = contour(kk,ll,ratio,v,'-k');
clabel(cc,hh)
title('dx / \lambda = 0.2')
xlabel('k \Delta x')
ylabel('l \Delta y')

% Poorly resolved Rossby radius

r = 5.0;

w2ex = (1.0 + (kk.^2 + ll.^2)/(r*r));
w2fd = (coriolfac + (ddxfac.*ddxfac + ddyfac.*ddyfac)/(r*r));

ratio = sqrt(w2fd./w2ex);

subplot(1,2,2)
[cc,hh] = contour(kk,ll,ratio,v,'k');
clabel(cc,hh)
title('dx / \lambda = 5.0')
xlabel('k \Delta x')
ylabel('l \Delta y')









