% Simulate Rossby wave propagation
%
clear
hold off

% Set up grid
nx = 64;
ny = 64;
dx = 1.0/nx;
dy = 1.0/ny;
x = (0:(nx-1))*dx;
y = (0:(ny-1))*dy;
[xx,yy] = meshgrid(x,y);

ixby2 = 1:2:nx-1;
iyby2 = 1:2:ny-1;
ixby4 = 1:4:nx-1;
iyby4 = 1:4:ny-1;


% Time step
dt = 2.0;

% Main wavenumber of packet
k0 = 8*pi;
l0 = 0.0*pi;

% Width of wave packet
w = 0.2;

% Range of resolved wavenumbers
kmax = pi/dx;
dk = 2*kmax/nx;
k = (-nx/2:nx/2-1)*dk;
lmax = pi/dy;
dl = 2*lmax/ny;
l = (-ny/2:ny/2-1)*dl;
[kk,ll] = meshgrid(k,l);


% Dispersion relation
beta = 2.0;
ra = 40.0; %20.0;
den = (kk.*kk + ll.*ll + ra*ra);
omega = -beta*kk./den;
a = exp(-i*omega*dt);

% nstop = 200;
nstop = 90;

% Plot dispersion relation and highlight
% wavenumber of packet
subplot(1,1,1)
contourf(kk,ll,omega)
title('Dispersion relation')
xlabel('Wavenumber k')
ylabel('Wavenumber l')

hold on

q = linspace(0,2*pi,20);
k1 = k0 + 13.0*sin(q);
l1 = l0 + 13.0*cos(q);
plot(k1,l1,'k')
k1 = k0 + 14.0*sin(q);
l1 = l0 + 14.0*cos(q);
plot(k1,l1,'k')
k1 = k0 + 15.0*sin(q);
l1 = l0 + 15.0*cos(q);
plot(k1,l1,'k')

hold off

igo = input('Continue ? > ');

% Define wave packet and fft
f = 0.5*exp(i*(k0*xx + l0*yy)).*exp(-((xx-0.5)/w).^2 - ((yy-0.5)/w).^2);
ff = fftshift(fft(fft(f,[],1),[],2));

% Spectral plot showing wave packet
contourf(kk,ll,abs(ff))
title('Amplitude of Fourier transform')
xlabel('Wavenumber k')
ylabel('Wavenumber l')

igo = input('Continue ? > ');

% Preliminary stuff to aid visualization
f0 = 2.0*(yy - 0.5);
v = [0:11]*4.0;
v1 = [-4.5:1:4.5]*0.25;

% Loop over timesteps
for istep = 1:nstop
   
   ftot = f0 + f;
    
   % Plot as a series of material lines
   %for j = 1:1:ny
   %   hold on
   %   if (j == 1)
   %      hold off
   %   end
   %   y9 = y(j) + 0.04*real(f(j,:))';
   %   plot(x,y9)
   %end
   %axis([0.0,1.0,0.0,1.0])
   %xlabel('Eastward distance x')
   %ylabel('Northward distance y')
   
      
   psi = -real(f./den);
   [gpx,gpy] = gradient(psi);
   % quiver(x(ixby2),y(iyby2),-gpy(ixby2,iyby2),gpx(ixby2,iyby2))
   quiver(x(ixby4),y(iyby4),-gpy(ixby4,iyby4),gpx(ixby4,iyby4))
   axis([0.0,1.0,0.0,1.0])
   hold on
   %igo = input('go');
   
   % pcolor(real(f))
   contour(xx,yy,real(ftot),v1)
   % shading interp
   xlabel('Eastward distance x')
   ylabel('Northward distance y')
   % hold on
   
   %psi = real(f./den);
   %[gpx,gpy] = gradient(psi);
   %quiver(x(ixby2),y(iyby2),-gpy(ixby2,iyby2),gpx(ixby2,iyby2))
   hold off
   
   % Evolve in time
   ff = ff.*a;
   f = ifft(ifft(ifftshift(ff),[],2),[],1);
   pause(0.1)
   %igo = input('continue ? > ');

   if istep > 55
      igo = input('Carry on ? > ') 
   end
   
end

hold off