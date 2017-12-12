function ic,x
;
; Initial condition for diffusion problem
if (0.25 le x) and (x le 0.75) then begin
  val=1.0
endif else begin
  val=0.0
endelse
;
return,val
end



pro diffuse2
;
; To solve the linear diffusion equation using a FTBS scheme
;
K=1.0
;
nx=40
dx=1.0/nx
x=findgen(nx)*dx
;
phi=fltarr(nx)
phip=fltarr(nx)
;
dt=0.01
;
nu=(K*dt)/(dx*dx)
;
; Set initial condition
for j=0,nx-1 do phi(j)=ic(x(j))
;
plot,x,phi
;
loop:
print,'How many steps >'
read,nstep
;
if nstep le 0 then goto,finish
;
; Loop over steps
for istep=1,nstep do begin
  a=-nu
  b=1.0+2*nu
  c=-nu
  phip=trisolve(a,b,c,phi)
  phi=phip
endfor
;
oplot,x,phi
;
goto,loop


finish:

end
