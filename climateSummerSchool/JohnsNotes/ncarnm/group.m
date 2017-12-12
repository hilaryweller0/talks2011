% Matlab m-file to
% illustrate group velocity

n=100;
dx = 1.0/n;
x = (0:(n-1))*dx;

dt = 0.02;

k0 = 20*pi;
w = 0.13;

kmax = pi/dx;
dk = 2*kmax/n;
k = (-n/2:n/2-1)*dk;


icase = input('Choose a case: 1=non-dispersive; 2=Inertio-gravity wave; 3=Rossby wave > ')

switch icase

    case 1
% Nondispersive
      omega = 1.0*k;
      nstop = 49;
      s = 1.0;
      
    case 2
% Inertio-gravity wave-like case
      omega = 0.6*sqrt(2.0*k0.*k0 + 1.0*k.*k);
      nstop = 140;
      s = 1.0;

    case 3
% Rossby wave - like case
      omega = -0.8*k0^3./(1.0*k0^2 + k.*k);
      nstop = 125;
      s = -1.0;

end
      
plot(k,omega,[k0],[0],'*')
axis([0.0 kmax -kmax kmax])
title('Dispersion relation')
xlabel('Wavenumber k')
ylabel('Frequency omega')

omega = s*abs(omega).*sign(k);

%ff = fftshift(fft(f));
%hold on
%plot(k,ff*1000)


igo = input('Continue ? > ');

f = sin(k0*x).*exp(-((x-0.5)/w).^2);

hold off
subplot(1,1,1)

igo = 1;


for istep = 1:nstop

plot(x,real(f))
axis([0.0,1.0,-1.0,1.0])
xlabel('Distance x')
ylabel('Wave field phi')

ff = fftshift(fft(f));




a = exp(-i*omega*dt);
ff = ff.*a;
f = ifft(ifftshift(ff));

pause(0.2)

end