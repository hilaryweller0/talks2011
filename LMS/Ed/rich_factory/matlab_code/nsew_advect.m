

% Code to solve advection equation for nsew event
% not the best solution (forward in time and space) 
% but it works for now


dx=100.E3;
dy=100.E3;
dt=3600.; % 60 mins
nsteps=4;

x=0.+dx*(0:3);
y=0.+dx*(0:3);

t=zeros(4,4,nsteps);

% very simple forward and first order timestepping scheme

% initialisation and winds

systx=[5.,10.,20.,25.]
systy=ones(1,4)*1.;
tinit=transpose(systy)*systx;

u=zeros(4,4);
v=zeros(4,4);
v=flipud([4.3,3.5,2.5,0;8.6,7,5,0;13,10.5,7.5,0;17.3,14,10,0])*(-1)
u=flipud([2.5,3.5,4.3,5;5,7,8.6,10.;7.5,10.5,13.0,15.0;10,14,17.3,20])


xderiv=zeros(4,4);
yderiv=zeros(4,4);

% timestepping

t(:,:,1)=tinit;

xbound=[3,3,3,3];
ybound=[5,10,20,25];

for n=1:nsteps

% use an upwind scheme
% velocity fixed so that always from top right

% xderivative

for j=2:4 
for i=1:4
xderiv(i,j)=(t(i,j,n)-t(i,j-1,n))/dx;
end
xderiv(i,1)=(t(i,1,n)-xbound(j))/dx;
end

% yderivative

for j=1:4 
for i=1:3
yderiv(i,j)=(t(i+1,j,n)-t(i,j,n))/dy;
end
yderiv(4,j)=(t(4,j,n)-ybound(j))/dy;
end


% step
t(:,:,n+1)=t(:,:,n)-(dt*((u.*xderiv)+(v.*yderiv)));

end


% figures

% plotting a sequence at any gridpoint
%figure(1)
%clf
%plot(0:1:4,squeeze(t(2,3,:)),'k+-','Linewidth',3)
%ylabel('Temperature / degrees centigrade','Fontsize',16)
%xlabel('Time / hours','Fontsize',16)
%set(gca,'FontSize',16)
%print -dtiff -r300 gridpoint.tif

% plotting a quiver of the wind components
figure(2)
clf
[xgrid,ygrid]=meshgrid(x/1000.,y/1000.)

sizev=30.
for i=1:4
for j=1:4
if u(i,j) ~= 0  
sizex=sizev.*(u(i,j)./max(max(abs(u)))); 
end
if v(i,j) ~= 0 
sizey=sizev.*(v(i,j)./max(max(abs(v))));
end
vectarrow([xgrid(i,j)-sizex,ygrid(i,j)-sizey],[xgrid(i,j)+sizex,ygrid(i,j)+sizey])
hold on
sizex=0;
sizey=0;
end
end

set(gca,'YDir','normal','Clim',[0,30],'Xtickmode','manual','xtick',[0E2,1.0E2,2E2,3E2],'ytickmode','manual','ytick',[0E2,1.0E2,2E2,3E2],'FontSize',18)
xlabel('East-West / km');
ylabel('North-South / km');
title('Winds')

grid on
print -dtiff -r300 winds.tif


% output each solution as an image file

outstr=['rich_0';'rich_1';'rich_2';'rich_3';'rich_4']
for tout=1:5
figure(1)
clf
[h]=image(x/1000.,y/1000.,t(:,:,tout)); 
set(h,'CDataMapping','scaled')
set(gca,'YDir','normal','Clim',[0,30],'Xtickmode','manual','xtick',[0E2,1.0E2,2E2,3E2],'ytickmode','manual','ytick',[0E2,1.0E2,2E2,3E2],'FontSize',4)
xlabel('East-West / km');
ylabel('North-South / km');
colorbar('Fontsize',4)
title('Temperature / degrees Celsius')
set(gcf,'PaperPositionMode','manual');
set(gcf,'PaperPosition',[0.05,0.05,2.0,1.5]);
print('-dtiff','-r300',outstr(tout,1:6))

end
