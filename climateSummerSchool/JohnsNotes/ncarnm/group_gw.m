% Matlab m-file to
% illustrate group velocity
% of internal gravity wave

% Set up grid
nx = 32;
nz = 32;
dx = 1.0/nx;
dz = 1.0/nz;
x = (0:(nx-1))*dx;
z = (0:(nz-1))*dz;
[xx,zz] = meshgrid(x,z);

% Time step
dt = 0.5;

% Main wavenumber of packet
k0 = 10*pi;
m0 = 10*pi;

% Width of wave packet
w = 0.13;

% Range of resolved wavenumbers
kmax = pi/dx;
dk = 2*kmax/nx;
k = (-nx/2:nx/2-1)*dk;
mmax = pi/dz;
dm = 2*mmax/nz;
m = (-nz/2:nz/2-1)*dm;
[kk,mm] = meshgrid(k,m);


% Dispersion relation
r = mm./kk;
omega = 1.0./(1.0 + r.*r);
omega(nx/2+1,nz/2+1) = 0.0; % Fix 0/0
omega = sqrt(omega);
% Negative root for upward group velocity
omega = -abs(omega).*sign(kk);
a = exp(-i*omega*dt);

% nstop = 100;
nstop = 50;

% Plot dispersion relation and highlight
% wavenumber of packet
contourf(kk,mm,omega)
title('Dispersion relation')
xlabel('Wavenumber k')
ylabel('Wavenumber m')

hold on

q = linspace(0,2*pi,20);
k1 = k0 + 13.0*sin(q);
m1 = m0 + 13.0*cos(q);
plot(k1,m1,'k')
k1 = k0 + 14.0*sin(q);
m1 = m0 + 14.0*cos(q);
plot(k1,m1,'k')
k1 = k0 + 15.0*sin(q);
m1 = m0 + 15.0*cos(q);
plot(k1,m1,'k')

hold off

igo = input('Continue ? > ');

% Define wave packet and fft
f = exp(i*(k0*xx + m0*zz)).*exp(-((xx-0.7)/w).^2 - ((zz-0.3)/w).^2);
ff = fftshift(fft(fft(f,[],1),[],2));

% Spectral plot showing wave packet
contourf(kk,mm,abs(ff))
title('Amplitude of Fourier transform')
xlabel('Wavenumber k')
ylabel('Wavenumber m')

igo = input('Continue ? > ');

% Preliminary stuff to aid visualization
f0 = 40.0*zz;
v = [0:11]*4.0;
v1 = [-4.5:1:4.5]*0.2;

% Loop over timesteps
for istep = 1:nstop

ftot = f0 + f;
   %contour(xx,zz,real(ftot),v)
   % contourf(xx,zz,real(f),v1)
   
   % Plot as a series of material lines
   for j = 1:1:nz
      hold on
      if (j == 1)
         hold off
      end
      % y = z(j) + 0.02*real(f(j,:))';
      y = z(j) + 0.025*real(f(j,:))';
      plot(x,y)
   end
   axis([0.0,1.0,0.0,1.0])
   xlabel('Horizontal distance x')
   ylabel('Vertical distance z')

   % Evolve in time
   ff = ff.*a;
   f = ifft(ifft(ifftshift(ff),[],2),[],1);
   pause(0.05)

end

hold off