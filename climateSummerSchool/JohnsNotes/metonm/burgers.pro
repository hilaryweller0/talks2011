function icb,x
;
; Initial condition for Burgers equation
pi = 4.0*atan(1.0)
val = 1.0-cos(2*pi*x)
;
return,val
end



pro burgers
;
; To solve Burgers equation using a CTCS scheme
;
nx=20
dx=1.0/nx
twodx=2.0*dx
x=findgen(nx)*dx
xf=fltarr(nx)
;
u0=fltarr(nx)
um=fltarr(nx)
u=fltarr(nx)
up=fltarr(nx)
;
dt=0.01
lfirst=1
;
;
; Set initial condition
for j=0,nx-1 do u0(j)=icb(x(j))
u=u0
um=u0
;
plot,x,u,yrange=[-0.5,2.5]
;
loop:
print,'How many steps >'
read,nstep
;
if nstep le 0 then goto,finish
;
; Loop over steps
for istep=1,nstep do begin
;
  twodt=2.0*dt
  if lfirst eq 1 then twodt=dt ; Trick to take forward step at first step
  ; Loop over grid points
  for j=0,nx-1 do begin
    jm=j-1
    if jm lt 0 then jm=nx-1
    jp=j+1
    if jp gt nx-1 then jp=0
    up(j) = um(j) - u(j)*(u(jp) - u(jm))*(twodt/twodx)
  endfor
  um=u
  u=up
  lfirst=0
  ;
  ; Diagnose momentum
  mom=0.0
  for j=0,nx-1 do begin
    mom=mom+u(j)*dx
  endfor
  print,'Step ',istep,' Momentum = ',mom
  ;
endfor
;
oplot,x,u
;
;
goto,loop


finish:

end
