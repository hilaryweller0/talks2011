pro linterp
;
; To demonstrate linear interplation
;
; Set up data values: 9 points on a sine curve
pi=3.14159265
x=findgen(9)*2*pi/8
f=sin(x)
;
; Plot data points
plot,x,f,psym=4,xrange=[0,2*pi],yrange=[-1.1,1.1],xstyle=1,ystyle=1
;
; loop over intervals
for i=1,8 do begin
  xl=x(i-1) & fl=f(i-1)
  xr=x(i) & fr=f(i)
  ; Plot linear fit in this interval
  np=21
  xx=findgen(np)*(xr-xl)/(np-1) + xl
  beta=(xx - xl)/(xr - xl)
  ff=(1.0 - beta)*fl + beta*fr
  oplot,xx,ff
endfor
;
end
