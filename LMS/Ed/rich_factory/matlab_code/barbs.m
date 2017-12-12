function L = barbs(varargin);
% Plots vector fields and vector time series
%
% DESCRIPTION:
%   Plots barbs or arrows conserving angles and can place a scaling bar.
%   The positions of the components u and v can be entered as matrices
%   or vectors as with quiver.m
%   The x axes can be labels of datestr.m
%   A scaling factor (dar) is used between the x axes and y axes 
%   to conserve the angles and another scaling factor (ra) is 
%   used for the length of the barbs ir arrows. 
%
% INPUT VARIABLES:
%   u,v = Vector Componentes
%   t,p = Positions of the vectors u,v
%       t is usually a time series but can also be x coordinates
%       p is usually vertical coordinates
%   ft = datestr.m format for labeling the the x axes
%   dar = Scaling factor between x and y axes
%       This is set as the second element of the property 'DataAspectRatio'
%   ra = Length scaling factor for the barbs or arrows
%   s = Type of line or 'LineStyle'
%   lim = Limits for the axes in the form [xmin,xmax] or
%       [xmin,xmax,ymin,ymax]
%   rv = Magnitude of the scaling bar
%   units = Units of the barbs as a string
%   dx,dy = Normalized position of the scaling bar
%
% OUTPUT VARIABLES:
%   L = Vector of handles of the lines, L(end) is the handle of the 
%       scaling bar if it exist
%
% DEFAULT INPUT VARIABLES:
%   The default values change depending on the input format
%	t = 1:length(u), dar = 1, ra = 1, s = 'b', ft=6, y p=0:10:10*size(u,2)
%	rv y units are omitded if values are not given 
%
% VALID INPUT FORMATS:
%  Number of  |    Posible
%  Arguments  |    Formats
%--------------------------------------------------------------------------
%      <2     |  Runs the barbs demo
%      2      |  (u,v)
%      3      |  (u,v,dar)
%      4      |  (u,v,t,p), (u,v,t,ft), (u,v,dar,ra)
%      5      |  (u,v,t,p,ft), (u,v,t,ft,dar), (u,v,t,ft,s), (u,v,dar,ra,s)
%      6      |  (u,v,t,p,ft,dar), (u,v,t,ft,dar,ra), (u,v,t,ft,dar,s), (u,v,dar,ra,s,lim)
%      7      |  (u,v,t,p,ft,dar,ra), (u,v,t,ft,dar,ra,s), (u,v,t,ft,dar,ra,rv)
%             |                       (u,v,t,ft,dar,ra,lim)
%      8      |  (u,v,t,p,ft,dar,ra,s), (u,v,t,ft,dar,ra,s,lim), (u,v,dar,ra,s,lim,rv,units)
%             |                       (u,v,t,ft,dar,ra,rv,units)
%      9      |  (u,v,t,p,ft,dar,ra,s,lim), (u,v,t,ft,dar,ra,s,lim,rv)
%      10     |  (u,v,t,p,ft,dar,ra,s,lim,rv), (u,v,t,ft,dar,ra,s,lim,rv,units)
%             |                   (u,v,dar,ra,s,lim,rv,units,dx,dy)
%      11     |  (u,v,t,p,ft,dar,ra,s,lim,rv,units),
%      12     |  (u,v,t,ft,dar,ra,s,lim,rv,units,dx,dy)
%      13     |  (u,v,t,p,ft,dar,ra,s,lim,rv,units,dx,dy)
%		
% Notes: 
%   If u and v are vectors, it does not matter if they are
%   column vectors or row vectors.
%   If u, v, t and p are matrices, the variables should be 
%   used as if using quiver.m.
%   If u and v are matrices and t and p are vectors, u and v
%   are separated in length(t) rows amd length(p) columns.
%   For example if t and p are set as:
%       t=-2:.2:2; p=-1:.15:1;
%   this is equivalent to using:
%       [t,p] = meshgrid(t,p);
%   but u and v must correspond in dimensions to t and p
%   as if using quiver.m (see Examples 5 and 6 in demo).
%   If datestr.m labels are not wanted ft can be set as [].
%   If any marker is used for the 'LineStyle', arrows are drawn
%   instead of barbs (lines).
%   At the end of the program is a demo which can be reviewed
%   for further details.
%   The demo is run by executing the program with <2 input variables.
%
% Comments:
%   The section where the input variables are read could be 
%   made more efficient by using a switch for every number 
%   of arguments and then using if's to determine the proper 
%   format but I'm to lazy to change it because
%   the program works fine the way it is. 
%   If someone is up to it be my guest.
%   The only reason I opted to use try's is because it 
%   was faster for me to program because in a sense I programed
%   all formats at once.
%   Oh, and sorry the comments are in spanish...
%
%Copy-Left, Alejandro Sánchez-Barba, 2005

if ~ishold
    newplot;
end
if length(varargin)<2
    barbsdemo
    return
end

[u,v,t,p,ft,dar,ra,st,co,mark, ...
    lim,rv,units,dx,dy] = parseinputs(varargin);

%****** IMPORTANT *******
%Scale correction for u 
u = u./dar;

%Draw a barb
if isempty(mark) | strcmpi(mark,'o') %default
    astilla = [0; 1; NaN]; 
    dim = 3;
elseif strcmpi(mark,'*')
    astilla = [0; 1; 0.8; 1; 0.8; NaN] ...
        + [0; 0; 0.07; 0; -0.07; NaN]*i;
    dim = 6;   
end %if

LL = []; %handle

%If parameters are given in quiver format
if size(t)==size(p) & size(u)==size(t)
    u = u(:);
    v = v(:);
    t = t(:)';
    p = p(:)';
    try
        if ~isempty(lim)
            if length(lim)==2
                ind = (t>=lim(1) & t<=lim(2));
            elseif length(lim)==4
                ind = (t>=lim(1) & t<=lim(2) & p>=lim(3) & p<=lim(4));
            else
                 error('Invalid Lim')
            end %if
            t = t(ind);
            u = u(ind);
            v = v(ind);
            p = p(ind);
        end %if
    end %try
    z = (u + v*i).';
    a = ra*astilla*z + ones(dim,1)*t + ones(dim,1)*p*i;
    LL = plot(a(:),[co,st],'clipping','off');
    if strcmpi(mark,'o')
        b = [0.8; 1; 0.8; 0.85] + [0.07; 0; -0.07; 0]*i;
        dim = 4;
        a = ra*b*z + ones(dim,1)*t + ones(dim,1)*p*i;
        LL = [LL; patch(real(a),imag(a),co,'edgecolor','none')];
    end
else
    %Encuentra los valores fuera del eje en las x y las y, y los elimina
    if ~isempty(lim)
        try
            ind = find(t>=lim(1) & t<=lim(2));
            t = t(ind);
            u = u(ind,:);
            v = v(ind,:);
            in = find(p>=lim(3) & p<=lim(4));
        catch
            in = 1:size(u,2);
        end %try
    else
        in = 1:size(u,2);
    end %if
    for j=in(1):in(end)
        z = (u(:,j) + v(:,j)*i).';
        a = ra*astilla*z + ones(dim,1)*t(:)' + p(j)*i;
        aj(:,j) = a(:);
    end %for
    LL = plot(aj,[co,st],'clipping','off');
end

%Correct axis limits
if ~isempty(lim)
     if length(lim)==2
        set(gca,'xlim',[lim(1), lim(2)])
     elseif length(lim)==4
        axis([lim(1), lim(2), lim(3), lim(4)])            
     else
        error('Invalid Lim')
     end %if
 elseif all(size(t)==1)
   set(gca,'xlim',[t(1), t(end)])
end %if

set(gca,'DataAspectRatio',[1, dar, 1], ...
    'PlotboxAspectRatio',[1, dar, 1]);

if length(t)~=length(p) | length(u)~=length(t)
    set(gca,'ytick',[])
end

%Since the default value for t starts with 1
if t(1)~=1 & ~isempty(ft)
    tcks = get(gca,'xtick');
    tk = datestr(tcks,ft);
    set(gca,'xTickLabel',tk)
end %if

%Scale Bar
if ~isempty(rv)
    yval = get(gca,'ylim');	
    xval = get(gca,'xlim');
    ydist = abs(yval(2)-yval(1));		
    xdist = abs(xval(2)-xval(1));
    px = xval(1) + dx*xdist;		
    py = yval(1) + dy*ydist;
    grad = px + py.*i;
    %para poner la escala por debajo de units cambiar a:
    %ra*[0; 1]*rv/dar + ones(2,1)*grad;
    Legend = ones(2,1)*grad - ra*[0; 1]*rv/dar;
    LL = [LL; line(real(Legend),imag(Legend), ...
        'color',co,'LineStyle',st',...
        'clipping','off','linewidth',1)];
    txt = sprintf('%g %s',rv,units);
    LL = [LL; text(px,py,txt,'verticalAlign','bottom', ...
        'horizontalalign','left')];
end

box on

if nargout==1
    L = LL; 
end

%-----------------------------------------------------------------

function barbsdemo
%demo of barbs

close all

%Example 1
u = linspace(0,-5,30);
v = linspace(-5,5,30);
dar = 1;
ra = 1;

figure
subplot(2,2,1)
feather(u,v);
title('feather')

%Example 2:
subplot(2,2,2)
h = barbs(u,v);
title('barbs')

%It can be seen clearly that feather does
%not conserve the angles but barbs does a good job

%Example 3:
[x,y] = meshgrid(-3:.2:3);
z = peaks(x,y);
%z = x.*exp(-y.^2 - y.^2);
[u,v] = gradient(z,.2,.2);

subplot(2,2,3)
quiver(x,y,u,v)
title('quiver')

%Example 4:
subplot(2,2,4)
%The values for dar and ra can be calculated 
%by trial and error
dar = 1;
ra = 0.02;
s = '-b*';
barbs(u,v,x,y,[],dar,ra,s)
title('barbs')

%Example 5:
%This is the first mode of barbs
%Here, t and p represent time and depths
u = randn(100,5)+1;
v = randn(100,5)-1;
t = linspace(datenum(2003,1,1),datenum(2003,1,30),100);
p = linspace(0,-15,5);
dar = 1.1;
ra = 1;
ft = 6;
s = '-b';
lim = [datenum(2003,1,5),datenum(2003,1,20)];
rv = 2;
units = 'm/s';
dx = 0.8;
dy = 0.02;

figure
subplot(2,2,1)
h = barbs(u,v,t,p,ft,dar,ra,s,lim,rv,units,dx,dy);
ylabel('Depth (m)')
xlabel('Time (mm/dd)')
title('Mode 1')

%Example 6:
%This is the other mode of barbs
%This mode is equivalent to using quiver
[t,p] = meshgrid(t,p);
u = flipdim(rot90(u),1); 
v = flipdim(rot90(v),1);

subplot(2,2,2)
barbs(u,v,t,p,ft,dar,ra,s,lim,rv,units,dx,dy)
xlabel('Time(mm/dd)')
title('Mode 2')

%Example 7:
t = linspace(-116,-104,100);
t = [t; t; t; t; t];
p = linspace(23,30,100);
p = [p+8; flipdim(p,2)+4; p+4; flipdim(p,2); p];

subplot(2,2,3)
quiver(t,p,u,v)
title('quiver')
axis([-118,-102, 22,40]);

%Example 8:
s = '-b*';
dx = 0.3;
dy = 0.8;
ra = 0.5;
units = 'esf';
lim = [-118,-102, 22,40];
subplot(2,2,4)
barbs(u,v,t,p,[],dar,ra,s,lim,rv,units,dx,dy)
ylabel('Latitude')
xlabel('Longitude')
title('barbs')
%grid on

figure
%Now the vectors and positions are given as vectors
u = reshape(u,500,1);
v = reshape(v,500,1);
t = reshape(t,500,1);
p = reshape(p,500,1);
s = '-bo';
dx = 0.3;
dy = 0.8;
dar = 1.1;
ra = 0.5;
rv = 2;
units = 'm/s';
lim = [-118,-102, 22,40];
barbs(u,v,t,p,[],dar,ra,s,[],rv,units,dx,dy)

return

%--------------------------------------------------------------------
function [u,v,t,p,ft,dar,ra,st,co,mark, ...
    lim,rv,units,dx,dy] = parseinputs(a)

u = a{1};
v = a{2};
if prod(size(u))~=prod(size(v))
   error('u & v have to be the same length');
end
if any(size(u)==1) 
    u=u(:); v=v(:);
end

%Initialize
t = [];     p = [];     ft = [];
dar = [];   ra = [];    s = [];
lim = [];   rv = [];    units = [];
dx = [];    dy = [];

try %1
if length(a{3})>1
    t = a{3};
else
    dar = a{3};    
end

try %2
if all(size(a{4})==1)  & ~isempty(t)
    ft = a{4};
elseif any(size(a{4})>1)
    p = a{4};
else  
    ra = a{4};
end

try %3
if isempty(ft) & isnumeric(a{5}) | isempty(a{5})
    ft = a{5};
elseif  isnumeric(a{5}) & isempty(dar)
    dar = a{5};
else   
    s = a{5};
end

try %4
if isempty(dar) & isnumeric(a{6})
    dar = a{6};
elseif isnumeric(a{6}) & length(a{6})==1
    ra = a{6};
elseif isstr(a{6})
    s = a{6};
else 
    lim = a{6};
end

try %5
if isempty(ra)
    ra = a{7};
elseif isstr(a{7})
    s = a{7};
elseif length(a{7})==1
    rv = a{7};
else 
    lim = a{7};
end

try %6
if isempty(s) & isstr(a{8})
    s = a{8};
elseif isstr(a{8})
    units=a{8};
else 
    lim = a{8};
end
try %7
if isempty(lim)
    lim = a{9};
elseif ~isempty(t)
    rv = a{9};
else 
    dx = a{9};
end

try %8
if isempty(rv)
    rv=a{10};
elseif isstr(a{10})
    units=a{10};
else 
    dy = a{10};
end %if

try %9
if isempty(units)
    units=a{11};
else 
    dx = a{11};
end %if

try %10
if isempty(dx)
    dx = a{12};
else 
    dy = a{12};
end %if

try %11
dy = a{13};

%11 end's
end,end,end,end,end,
end,end,end,end,end,end 

%default values
if isempty(t)
    t = 1:size(u,1);  
end
if isempty(dar)
    dar = 1;  
end
if isempty(ra)
    ra = 1;
end
if isempty(s)
    s = 'b';
end
if isempty(p)
    p = 0:10:10*(size(u,2)-1);  
end

[st,co,mark,msg] = colstyle(s); 
error(msg)
if isempty(co),
  co = get(gca,'colororder');
  co = co(1,:);
end %if
if isempty(st);
    st = '-';
end

if ~isempty(rv)
    if isempty(units)
        units = 'm/s';
    end
    if isempty(dx)
        dx = 0.3;
    end
    if isempty(dy)
        dy = 0.8;
    end
end

return
