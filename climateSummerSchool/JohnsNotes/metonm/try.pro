pro try
; Example of a PV-WAVE procedure
;
x=findgen(21)*0.05
y=findgen(21)*0.05
;
z=fltarr(21,21); Create a floating point array
;
for i=0,20 do begin
  for j=0,20 do begin
    r2=(x(i)-0.5)^2 + (y(j)-0.5)^2
    z(i,j)=sin(10*x(i))*exp(-4*r2)
  endfor
endfor
;
contour,z,x,y,nlevels=10
;
end
