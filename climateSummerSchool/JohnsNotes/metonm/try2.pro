pro try2
; Example of a PV-WAVE procedure
;
x=findgen(101)*0.01
;
z=fltarr(101)
;
lim=0.4
for i=0,100 do begin
  y=sin(x(i)*16)
  if y lt lim then begin
    z(i)=y
  endif else begin
    z(i)=2*lim-y
  endelse
endfor
;
plot,x,z,title='Modified sine wave'
;
end
