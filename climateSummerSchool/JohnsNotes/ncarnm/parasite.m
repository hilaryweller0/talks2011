% To demonstrate effects of grid staggering (or not)
% for linearized 1D non-rotating SWEs

phi_0 = 1.0;

domain = 1.0;
n = 60;
hn = floor(n/2);
dx = domain/n;

dt = 0.1*dx/sqrt(phi_0);

tstop = 0.5*domain/sqrt(phi_0);
nstop = floor(tstop/dt) + 1;

j = 1:n;
jm = j - 1;
jm(1) = n;
jp = j + 1;
jp(n) = 1;

x1 = [0:n-1]*dx;
x2 = x1 + 0.5*dx;

omega = 8.0;

% Initial condition
w = 0.05;
phi = 0.0*j;
u   = 0.0*j;
psi = 0.0*j;
v   = 0.0*j;

phiold = phi;
uold = u;
psiold = psi;
vold = v;


subplot(2,1,1)
plot(x1,phi)
axis([0.0,1.0,-1.5,1.5])
title('Unstaggered')
xlabel('x')
ylabel('phi')
subplot(2,1,2)
plot(x1,psi)
axis([0.0,1.0,-1.5,1.5])
title('Staggered')
xlabel('x')
ylabel('phi')

igo = input('Ready > ? ');

for istep = 1:nstop
    
    twodt = 2.0*dt;
    if (istep == 1)
        twodt = dt;
    end
    
    phinew = phiold - twodt*(u(jp) - u(jm))/(2.0*dx);
    unew = uold - twodt*(phi(jp) - phi(jm))/(2.0*dx);
    
    psinew = psiold - twodt*(v(j) - v(jm))/dx;
    vnew = vold - twodt*(psi(jp) - psi(j))/dx;
    
    phiold = phi;
    uold = u;
    psiold = psi;
    vold = v;

    phi = phinew;
    u = unew;
    psi = psinew;
    v = vnew;

     % Add forcing
    f = sin(omega*istep*dt);
    phi(hn) = f;
    % u(hn) = f;
    psi(hn) = f;
    % v(hn-1) = f;
    % v(hn) = f;

    
    subplot(2,1,1)
    plot(x1,phi)
    axis([0.0,1.0,-1.5,1.5])
    title('Unstaggered')
    xlabel('x')
    ylabel('phi')
    subplot(2,1,2)
    plot(x1,psi)
    axis([0.0,1.0,-1.5,1.5])
    title('Staggered')
    xlabel('x')
    ylabel('phi')

    pause(0.05)
    
end


    





