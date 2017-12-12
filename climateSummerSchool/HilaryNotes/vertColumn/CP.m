% Simulate a column of non-hydrostatic atmosphere satisfying:
% ddt(w) = -cp theta ddz(Exner) + g
% ddt(rho) + d/dz(rho w) = 0           (continuity)
% Exner = (rho R theta/p0)^(kappa/(1-kappa))      (perfect gas)
% ddt(theta) + w d/dz(theta) = 0   (energy equation)

% initially theta = theta0
% T = theta(p/p0)^kappa

% initial conditions
theta0 = 300;
N = 0.01;

% constants
g = -9.81;
R = 380;
p0 = 1e5;
cp = 1000;
kappa = R/cp;
gamma = 1/(1-kappa);
cs = sqrt(gamma*R*theta0);

% grid
dz = 500;
top = 10000;
z = 0:dz:top;
zmid = z(1)+0.5*dz:dz:top-0.5*dz;

% prognostic variables (initially unstratified, balanced)
rhow = zeros(length(z),1);
theta1 = theta0*ones(length(z),1);
Exner1 = ones(length(zmid),1);
theta = theta0*ones(length(z),1);
thetaC = theta0*ones(length(zmid),1);
Exner = ones(length(zmid),1);

% auxiliary variables
T = zeros(length(zmid),1);
p = zeros(length(zmid),1);
rho = zeros(length(zmid),1);
w = zeros(length(z),1);

% initial balanced conditions
for iz = 1:length(theta1)
    theta1(iz) = theta0*exp(N^2*z(iz)/(-g));
endfor
for iz = 1:length(Exner)
    %thetaC(iz) = theta0*exp(N^2*zmid(iz)/(-g));
    Exner1(iz) = 1+g^2/(theta0*N^2*cp)*(exp(N^2*zmid(iz)/g)-1);
endfor
theta = theta1;
Exner = Exner1;
%theta(10) = theta(10)+0.01;
p = p0*Exner.^(1/kappa);

thetaC = interpToCell(theta);
T = thetaC.*(p/p0).^kappa;
rho = p./(R*T);
%rhoOld = rho;

% interpolated variables
rhof = interpToFace(rho);
thetaC1 = thetaC;
wC = interpToCell(w);
rhowC = interpToCell(rhow);
rhofOld = rhof;

% boundary conditions
%dthetadztop = theta0*exp(N^2*top/(-g))/g*N^2;
%dthetadz0 = theta0/g*N^2;
thetaTop    = theta0*exp(N^2*top/(-g));
thetaBottom = theta0;

figure(4);
clf
plot(w,z/1000, wC,zmid/1000);
legend('w', 'wC');
set(gca, 'xlim', [-0.0005 0.0005]);
%set(gca, 'xlim', [-10 10]);
hold on;
%printf('Press return to continue\n');
%pause

figure(5);
clf
plot(Exner-Exner1,zmid/1000);
legend('Exner')
set(gca, 'xlim', [-2e-6 2e-6]);
hold on;

figure(6);
clf
plot(theta-theta1,z/1000, thetaC-thetaC1,zmid/1000);
legend('theta-theta1', 'thetaC-thetaC1');
set(gca, 'xlim', [-1e-5 1e-5]);
hold on;
%printf('Press return to continue\n');
%pause

% time stepping
dt = 0.5;
nsteps =30;
plotEvery = 1;

printf("Accoustic Courant number = %g\n", cs*dt/dz);

% store time evolution of w and theta
wt = zeros(length(w), nsteps);
thetat = zeros(length(theta), nsteps);
wt(:,1) = w;
thetat(:,1) = theta;

% Euler explicit time-stepping
for it = 1:nsteps
    %printf("Max advective Courant number = %g\n", max(abs(w))*dt/dz);

    % update density, rho, from continuity
    rhofOld = rhof;
    rhoOld = rho;
    for iz = 1:length(rho)
        rho(iz) = rho(iz) - dt*(rhow(iz+1)-rhow(iz))/dz;
    endfor
    rhof = interpToFace(rho);
    
    % update vertical velocity, w, from momentum equation
    for iz = 2:length(w)-1
        w(iz) = w(iz) - dt*(...
%            (rhowC(iz)*wC(iz)-rhowC(iz-1)*wC(iz-1))/dz...
            cp*theta(iz)*(Exner(iz)-Exner(iz-1))/dz
          - g);
    endfor
    rhow = w.*rhof;
    rhowC = interpToCell(rhow);
    wC = interpToCell(w);

    if (mod(it,plotEvery) == 0)
        figure(4);
        plot(w,z/1000, wC,zmid/1000);
    endif
    
    % CP update potential temperature
    for iz = 2:length(theta)-1
        theta(iz) = theta(iz)...
                  - dt*w(iz)/dz*(theta(iz+1)-theta(iz-1));
    endfor
    theta(1) = thetaBottom;
    theta(end) = thetaTop;
    thetaC = interpToCell(theta);

    if (mod(it,plotEvery) == 0)
        figure(6);
        plot(theta-theta1,z/1000, thetaC-thetaC1,zmid/1000);
    endif
    
    % update Exner, pressure and temperature
    for iz = 1:length(T)
        Exner(iz) = (rho(iz)*R.*thetaC(iz)/p0).^(kappa/(1-kappa));
        p(iz) = p0*Exner(iz)*(1/kappa);    
        T(iz) = thetaC(iz)*(p(iz)/p0)^kappa;
    endfor

    if (mod(it,plotEvery) == 0)
        figure(5);
        plot(Exner-Exner1,zmid/1000);
%        printf('Press return to continue\n');
%        pause
    endif

    wt(:,it+1) = w;
    thetat(:,it+1) = theta;
    
endfor
hold off

%figure(8);
%mesh(1:size(wt,2), 1:size(wt,1), wt);


