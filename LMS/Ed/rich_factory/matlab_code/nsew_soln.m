

% Code to plot students calculated solution

fin='soln_4.txt'
fout='soln_4'

tsoln=load('-ascii',fin);
tsoln


dx=100.E3;
dy=100.E3;

x=0.+dx*(0:3);
y=0.+dx*(0:3);

% output student solution as an image file


figure(1)
clf
[h]=image(x/1000.,y/1000.,tsoln); 
set(h,'CDataMapping','scaled')
set(gca,'YDir','normal','Clim',[0,30],'Xtickmode','manual','xtick',[0E2,1.0E2,2E2,3E2],'ytickmode','manual','ytick',[0E2,1.0E2,2E2,3E2],'FontSize',4)
xlabel('East-West / km');
ylabel('North-South / km');
colorbar('FontSize',4)
title('Temperature / degrees Celsius')

set(gcf,'PaperPositionMode','manual');
set(gcf,'PaperPosition',[0.05,0.05,2.0,1.5]);
print('-dtiff','-r300',fout)

