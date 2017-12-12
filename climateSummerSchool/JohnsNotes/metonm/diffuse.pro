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



pro diffuse
;
; To solve the linear diffusion equation using a FTBS scheme
;
K=1.0
;
nx=20
dx=1.0/nx
x=findgen(nx)*dx
;
phi=fltarr(nx)
phip=fltarr(nx)
;
dt=0.001
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
  ; Loop over grid points
  for j=0,nx-1 do begin
    jm=j-1
    if jm lt 0 then jm=nx-1
    jp=j+1
    if jp gt nx-1 then jp=0
    phip(j) = phi(j) + nu*(phi(jp) - 2*phi(j) + phi(jm))
  endfor
  phi=phip
endfor
;
oplot,x,phi
;
goto,loop


finish:

end
