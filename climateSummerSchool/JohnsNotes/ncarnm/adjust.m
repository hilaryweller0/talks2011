% Demonstrate geostrophic adjustment using
% A B and C grids

clear

% Grid resolution
n = 40;
hn = 1+floor(n/2);

% Time step
dt = 0.002;
nstop = 1000;

% Domain size
domain = 1.0;
dx = domain/n;
twodx = 2.0*dx;

% Mean geopotential
phi0 = 1.0;

% Coriolis
icor = input('Well resolved (1) or poorly resolved (2) Rossby radius ? > ');
switch icor
    case 1
        f = 0.3*sqrt(phi0)/dx % well resolved rossby radius
    case 2
        f = 3.0*sqrt(phi0)/dx % poorly resolved rossby radius
end

% Matrix for damping near edges
damp = ones(n);
damp(1:n,3) = 0.98;
damp(1:n,n-2) = 0.98;
damp(3,1:n) = 0.98;
damp(n-2,1:n) = 0.98;
damp(1:n,2) = 0.95;
damp(1:n,n-1) = 0.95;
damp(2,1:n) = 0.95;
damp(n-1,1:n) = 0.95;
damp(1:n,1) = 0.9;
damp(1:n,n) = 0.9;
damp(1,1:n) = 0.9;
damp(n,1:n) = 0.9;


% Initial conditions
phia = zeros(n);
phia(hn,hn) = 1.0;
ua = zeros(n);
va = zeros(n);
phib = zeros(n);
phib(hn,hn) = 1.0;
ub = zeros(n);
vb = zeros(n);
phic = zeros(n);
phic(hn,hn) = 1.0;
uc = zeros(n);
vc = zeros(n);

phiaold = phia;
uaold = ua;
vaold = va;
phibold = phib;
ubold = ub;
vbold = vb;
phicold = phic;
ucold = uc;
vcold = vc;

subplot(1,3,1)
%pcolor(phia)
%surf(phia,'FaceColor','blue','EdgeColor','none')
surfl(phia)
colormap pink
shading interp
%camlight left; lighting flat
axis([0 n 0 n -0.5 1])
title('A-grid')
subplot(1,3,2)
% pcolor(phib)
%surf(phib,'FaceColor','blue','EdgeColor','none')
%camlight left; lighting phong
surfl(phib)
colormap pink
shading interp
axis([0 n 0 n -0.5 1])
title('B-grid')
subplot(1,3,3)
% pcolor(phic)
%surf(phic,'FaceColor','blue','EdgeColor','none')
%camlight left; lighting phong
surfl(phic)
colormap pink
shading interp
axis([0 n 0 n -0.5 1])
title('C-grid')

igo = input('ready ? > ');

for istep = 1:nstop
    
    twodt = 2.0*dt;
    if (istep == 1)
        twodt = dt;
    end
    
    % A grid
    for k = 1:n
        km = k - 1;
        if k == 1
            km = n;
        end
        kp = k + 1;
        if k == n
            kp = 1;
        end
        for l = 1:n
            lm = l - 1;
            if l == 1
                lm = n;
            end
            lp = l + 1;
            if l == n
                lp = 1;
            end
            phianew(k,l) = phiaold(k,l) - twodt*((ua(kp,l) - ua(km,l)) + (va(k,lp) - va(k,lm)))/twodx;
            uanew(k,l) = uaold(k,l) - twodt*((phia(kp,l) - phia(km,l))/twodx - f*va(k,l));
            vanew(k,l) = vaold(k,l) - twodt*((phia(k,lp) - phia(k,lm))/twodx + f*ua(k,l));
        end
    end
    phianew = phianew.*damp;
    phiaold = phia;
    phia = phianew;
    uaold = ua;
    ua = uanew;
    vaold = va;
    va = vanew;
    
    subplot(1,3,1)
    % pcolor(phia)
    % shading interp
    %surf(phia,'FaceColor','blue','EdgeColor','none')
    %camlight left; lighting phong
    surfl(phia)
    colormap pink
    shading interp
    axis([0 40 0 40 -0.5 1])
    title('A-grid')

    
    % B grid
    for k = 1:n
        km = k - 1;
        if k == 1
            km = n;
        end
        kp = k + 1;
        if k == n
            kp = 1;
        end
        for l = 1:n
            lm = l - 1;
            if l == 1
                lm = n;
            end
            lp = l + 1;
            if l == n
                lp = 1;
            end
            phibnew(k,l) = phibold(k,l) - twodt*((ub(kp,l) - ub(k,l)) + (ub(kp,lp) - ub(k,lp)) + (vb(k,lp) - vb(k,l)) + (vb(kp,lp) - vb(kp,l)))/twodx;
            ubnew(k,l) = ubold(k,l) - twodt*((phib(k,l) - phib(km,l) + (phib(k,lm) - phib(km,lm)))/twodx - f*vb(k,l));
            vbnew(k,l) = vbold(k,l) - twodt*((phib(k,l) - phib(k,lm) + (phib(km,l) - phib(km,lm)))/twodx + f*ub(k,l));
        end
    end
    phibnew = phibnew.*damp;
    phibold = phib;
    phib = phibnew;
    ubold = ub;
    ub = ubnew;
    vbold = vb;
    vb = vbnew;
    
    subplot(1,3,2)
    % pcolor(phib)
    %surf(phib,'FaceColor','blue','EdgeColor','none')
    %camlight left; lighting phong
    surfl(phib)
    colormap pink
    shading interp
    axis([0 40 0 40 -0.5 1])
    % shading interp
    title('B-grid')

    
    % C grid
    for k = 1:n
        km = k - 1;
        if k == 1
            km = n;
        end
        kp = k + 1;
        if k == n
            kp = 1;
        end
        for l = 1:n
            lm = l - 1;
            if l == 1
                lm = n;
            end
            lp = l + 1;
            if l == n
                lp = 1;
            end
            phicnew(k,l) = phicold(k,l) - twodt*((uc(kp,l) - uc(k,l)) + (vc(k,lp) - vc(k,l)))/dx;
            ucnew(k,l) = ucold(k,l) - twodt*((phic(k,l) - phic(km,l))/dx - 0.25*f*(vc(k,l) + vc(k,lp) + vc(km,l) + vc(km,lp)));
            vcnew(k,l) = vcold(k,l) - twodt*((phic(k,l) - phic(k,lm))/dx + 0.25*f*(uc(k,l) + uc(kp,l) + uc(k,lm) + uc(kp,lm)));
        end
    end
    phicnew = phicnew.*damp;
    phicold = phic;
    phic = phicnew;
    ucold = uc;
    uc = ucnew;
    vcold = vc;
    vc = vcnew;
    
    subplot(1,3,3)
    %surf(phic,'FaceColor','blue','EdgeColor','none')
    %camlight left; lighting phong
    surfl(phic)
    colormap pink
    shading interp
    axis([0 40 0 40 -0.5 1])
    % pcolor(phic)
    % shading interp
    title('C-grid')

    
    
    pause(0.01)
end
            



