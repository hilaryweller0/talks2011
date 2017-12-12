% Pseudo-Spectral Solution of Barotropic Vorticity Equation
%
clear
%
% Resolution
n = 256;
n3 = floor(n/3)
%
% Domain size
domain = 1.0;
%
% Grid
dx = domain/n;
dy = domain/n;
x = [0:n-1]*dx;
y = [0:n-1]*dy;
[xx,yy] = meshgrid(x,y);
%
% Time step
dt = 0.4*16/n;
%
% Dissipation coeff
tau = 0.5;
nu = (((domain)/(n3*2.0*pi))^4)/tau;
nu = 0.0
%
% Coefficient for Robert filter
robert =  0.01;
%
% Various constant factors needed
dk = 2.0*pi/domain;
k = [-n/2:n/2-1]*dk;
l = [-n/2:n/2-1]*dk;
[kk,ll] = meshgrid(k,l);
ksq = kk.*kk + ll.*ll;
ksq(n/2+1,n/2+1) = 1.0;
rksq = 1.0./ksq;
del4 = 1.0./(1.0 + nu*ksq.*ksq*dt);
dbdx = i*kk;
dbdy = i*ll;
%
% Range of indices for anti-aliasing
n1 = ceil(n/6)+1;
n2 = n+2 - n1;
%
% Initial vorticity
z = sin(4*2*pi*xx/domain).*sin(4*2*pi*yy/domain);
z = z + 0.4*cos(3*2*pi*xx/domain).*cos(3*2*pi*yy/domain);
z = z + 0.3*cos(5*2*pi*xx/domain).*cos(2*2*pi*yy/domain);
z = z + 0.02*sin(2*pi*yy/domain) + 0.02*sin(2*pi*xx/domain);
%
% Transform to spectral space
temp1 = fft(z,[],1);
temp2 = fft(temp1,[],2);
zt = fftshift(temp2);
zoldt = zt;
%
% Estimate initial maximum Courant number
psit = -rksq.*zt;
psixt = dbdx.*psit;
psiyt = dbdy.*psit;
temp1 = fftshift(psixt);
temp2 = ifft(temp1,[],1);
psix = ifft(temp2,[],2);
temp1 = fftshift(psiyt);
temp2 = ifft(temp1,[],1);
psiy = ifft(temp2,[],2);
mxu = max(max(abs(psiy)));
mxv = max(max(abs(psix)));
mxvel = mxu + mxv;
courant = mxvel*dt/dx
%
% Initial enstrophy spectrum
zz = 0.5*zt.*conj(zt)/((dk^2)*(n^4));
% and energy spectrum
ee = zz.*rksq;
%
% Initial spectra integrated over angle
ee1d0 = [1:ceil(n/2)]*0.0;
zz1d0 = [1:ceil(n/2)]*0.0;
for r = n1+1:n2-1
    for s = n1+1:n2-1
        ktot = sqrt(ksq(r,s));
        bin = floor(ktot/dk)+1;
        ee1d0(bin) = ee1d0(bin) + ee(r,s);
        zz1d0(bin) = zz1d0(bin) + zz(r,s);
    end
end
ee1d0 = ee1d0*dk;
zz1d0 = zz1d0*dk;

% Energy and enstrophy from spectrum 2
eespec0 = sum(ee1d0)*dk
zzspec0 = sum(zz1d0)*dk
%
% Plot initial vorticity and spectra
subplot(1,2,1)
pcolor(z)
title('Vorticity')
axes('position',[0.6,0.6,0.3,0.3])
plot(ee1d0(1:n3))
title('Energy spectrum')
axes('position',[0.6,0.1,0.3,0.3])
plot(zz1d0(1:n3))
title('Enstrophy spectrum')
%
igo = input('Ready to go ? > ')
%
%
% Integrate
for istep = 1:1000
%
if rem(istep,20) == 0
    istep
    courant
end
%
if istep == 1
    twodt = dt;
else
    twodt = 2.0*dt;
end
%
% Spectral solution of Poisson equation and
% calculation of derivatives
psit = -rksq.*zt;
psixt = dbdx.*psit;
psiyt = dbdy.*psit;
zxt = dbdx.*zt;
zyt = dbdy.*zt;
%
% Transform to grid space
%temp1 = fftshift(psit);
%temp2 = ifft(temp1,[],1);
%psi = ifft(temp2,[],2);
temp1 = fftshift(zt);
temp2 = ifft(temp1,[],1);
z = ifft(temp2,[],2);
temp1 = fftshift(psixt);
temp2 = ifft(temp1,[],1);
psix = ifft(temp2,[],2);
temp1 = fftshift(psiyt);
temp2 = ifft(temp1,[],1);
psiy = ifft(temp2,[],2);
temp1 = fftshift(zxt);
temp2 = ifft(temp1,[],1);
zx = ifft(temp2,[],2);
temp1 = fftshift(zyt);
temp2 = ifft(temp1,[],1);
zy = ifft(temp2,[],2);
%max(max(abs(real(psix))))*l(1)*dt
%max(max(abs(real(psiy))))*k(1)*dt
%
% Enstrophy spectrum
zz = 0.5*zt.*conj(zt)/((dk^2)*(n^4));
% Energy spectrum
ee = zz.*rksq;
%
% Spectra integrated over angle
ee1d = [1:ceil(n/2)]*0.0;
zz1d = [1:ceil(n/2)]*0.0;
for r = n1+1:n2-1
    for s = n1+1:n2-1
        ktot = sqrt(ksq(r,s));
        bin = floor(ktot/dk)+1;
        ee1d(bin) = ee1d(bin) + ee(r,s);
        zz1d(bin) = zz1d(bin) + zz(r,s);
    end
end
ee1d = ee1d*dk;
zz1d = zz1d*dk;
%
%
% Energy on grid
% eegrid = -0.5*sum(sum(real(psi).*real(z)))*dx*dy
%
% Enstrophy on grid
% zzgrid = 0.5*sum(sum(real(z).*real(z)))*dx*dy
%
% Energy and enstrophy from spectrum 1
% eespec1 = sum(sum(real(ee)))*dk*dk
% zzspec1 = sum(sum(real(zz)))*dk*dk

% Energy and enstrophy from spectrum 2
eespec = sum(ee1d)*dk;
zzspec = sum(zz1d)*dk;
eefrac = eespec/eespec0;
zzfrac = zzspec/zzspec0;
%
% Visualize
if rem(istep,1) == 0
   subplot(1,2,1)
   pcolor(real(z))
   shading interp
   title(['Vorticity: step  ' num2str(istep)])
   %subplot(1,2,2)
   %axis off
   %axes('position',[0.6,0.6,0.3,0.3])
   %plot(ee1d0(1:n3),'k')
   %hold on
   %plot(ee1d(1:n3))
   %title(['Energy spectrum  ' num2str(eefrac)])
   %hold off
   %axes('position',[0.6,0.1,0.3,0.3])
   %plot(zz1d0(1:n3),'k')
   %hold on
   %plot(zz1d(1:n3))
   %title(['Enstrophy spectrum  ' num2str(zzfrac)])
   %hold off
   subplot(2,2,2)
   semilogy(ee1d0(1:n3),'k')
   ylim([1e-10,1e-2])
   hold on
   semilogy(ee1d(1:n3))
   title(['Energy spectrum  ' num2str(eefrac)])
   hold off
   subplot(2,2,4)
   semilogy(zz1d0(1:n3),'k')
   ylim([1e-10,1e0])
   hold on
   semilogy(zz1d(1:n3))
   title(['Enstrophy spectrum  ' num2str(zzfrac)])
   hold off
end
%
pause(0.005)
%
% Check Courant number
mxu = max(max(abs(psiy)));
mxv = max(max(abs(psix)));
mxvel = mxu + mxv;
courant = mxvel*dt/dx;
if courant > 0.8
    disp('Warning: Courant No > 0.8')
    dt = 0.9*dt
end
%
% Calculate Jacobian
jac = psix.*zy - psiy.*zx;
%
% Transform back to spectral space
temp1 = fft(jac,[],1);
temp2 = fft(temp1,[],2);
jact = fftshift(temp2);
%igo = input('back to spectral');
%
% Elimate short wavelengths to avoid aliasing
jact(1:n1,:) = 0;
jact(n2:n,:) = 0;
jact(:,1:n1) = 0;
jact(:,n2:n) = 0;
%
% Time step
znewt = zoldt - twodt*jact;
%
% Dissipation
znewt = znewt.*del4;
%
% Robert filter
zt = zt + robert*(znewt - 2.0*zt + zoldt);
%
% Rename ready for next step
zoldt = zt;
zt = znewt;
%igo = input('finished step');
%
end




