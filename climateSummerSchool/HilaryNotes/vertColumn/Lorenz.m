% Simulate a column of non-hydrostatic atmosphere satisfying:
% ddt(rho w) + ddz(rho w w) = -rho cp theta ddz(Exner) + rho g
% ddt(rho) + d/dz(rho w) = 0           (continuity)
% Exner = (rho R theta/p0)^(kappa/(1-kappa))      (perfect gas)
% ddt(rho theta) + d/dz(rho w theta) = 0   (energy equation)

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
theta1 = theta0*ones(length(zmid),1);
Exner1 = ones(length(zmid),1);
theta = theta0*ones(length(zmid),1);
Exner = ones(length(zmid),1);

% auxiliary variables
T = zeros(length(zmid),1);
p = zeros(length(zmid),1);
rho = zeros(length(zmid),1);
w = zeros(length(z),1);

% initial balanced conditions
for iz = 1:length(p)
    theta1(iz) = theta0*exp(N^2*zmid(iz)/(-g));
    Exner1(iz) = 1+g^2/(theta0*N^2*cp)*(exp(N^2*zmid(iz)/g)-1);
endfor
theta = theta1;
Exner = Exner1;
%theta(10) = theta(10)+0.01;
p = p0*Exner.^(1/kappa);
T = theta.*(p/p0).^kappa;
rho = p./(R*T);
rhoOld = rho;

% interpolated variables
rhof = interpToFace(rho);
thetaf = interpToFace(theta);
for iz = 1:length(theta1)
    thetaf(iz) = theta0*exp(N^2*z(iz)/(-g));
endfor
thetaf1 = thetaf;
wC = interpToCell(w);
rhowC = interpToCell(rhow);

% boundary conditions
%dthetadztop = theta0*exp(N^2*top/(-g))/g*N^2;
%dthetadz0 = theta0/g*N^2;
thetaTop    = theta0*exp(N^2*top/(-g));
thetaBottom = theta0;

figure(1);
clf
plot(w,z/1000, wC,zmid/1000);
legend('w', 'wC');
set(gca, 'xlim', [-0.0005 0.0005]);
%set(gca, 'xlim', [-10 10]);
hold on;
%printf('Press return to continue\n');
%pause

figure(2);
clf
plot(Exner-Exner1,zmid/1000);
legend('Exner')
set(gca, 'xlim', [-2e-6 2e-6]);
hold on;

figure(3);
clf
plot(theta-theta1,zmid/1000, thetaf-thetaf1,z/1000);
legend('theta-theta1', 'thetaf-thetaf1');
set(gca, 'xlim', [-5e-5 5e-5]);
hold on;

% time stepping
dt = 0.5;
nsteps = 200;
plotEvery = 10;

printf("Accoustic Courant number = %g\n", cs*dt/dz);

% store time evolution of w and theta
wt = zeros(length(w), nsteps);
thetat = zeros(length(theta), nsteps);
wt(:,1) = w;
thetat(:,1) = theta;

% Euler explicit time-stepping
for it = 1:nsteps
%    if (mod(it,plotEvery) == 0)
%        printf("Maximum advective Courant number = %g\n", max(w)*dt/dz);
%    endif

    % update density, rho, from continuity
    rhoOld = rho;
    for iz = 1:length(rho)
        rho(iz) = rho(iz) - dt*(rhow(iz+1)-rhow(iz))/dz;
    endfor
    rhof = interpToFace(rho);
    
    % update vertical velocity, w, from momentum equation
    for iz = 2:length(w)-1
        rhow(iz) = rhow(iz) - dt*(...
          cp*rhof(iz)*thetaf(iz)*(Exner(iz)-Exner(iz-1))/dz...
               -rhof(iz)*g);
    endfor
    w = rhow./rhof;
    rhowC = interpToCell(rhow);
    wC = interpToCell(w);
    
    if (mod(it,plotEvery) == 0)
        figure(1);
        plot(w,z/1000, wC,zmid/1000);
    endif

    % update potential temperature
    for iz = 1:length(theta)
        rhoThetaiz = rhoOld(iz)*theta(iz) - dt/dz*...
                    (rhow(iz+1)*thetaf(iz+1) - rhow(iz)*thetaf(iz));
        theta(iz) = rhoThetaiz/rho(iz);
    endfor
    thetaf = interpToFace(theta);
    thetaf(1) = thetaBottom;
    thetaf(end) = thetaTop;

    if (mod(it,plotEvery) == 0)
        figure(3);
        plot(theta-theta1,zmid/1000, thetaf-thetaf1,z/1000);
    endif

    % update Exner, pressure and temperature
    Exner = (rho.*R.*theta./p0).^(kappa/(1-kappa));
    p = p0*Exner.*(1/kappa);    
    T = theta.*(p/p0).^kappa;

    if (mod(it,plotEvery) == 0)
        figure(2);
        plot(Exner-Exner1,zmid/1000);
        %printf('Press return to continue\n');
        %pause
    endif

    wt(:,it+1) = w;
    thetat(:,it+1) = theta;
    
endfor
hold off

