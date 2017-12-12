function ic,x
;
; Initial condition for gravity wave problem
pi=3.14159265
if (0.25 le x) and (x le 0.75) then begin
  val=0.5*(1.0 + cos(4.0*pi*(x-0.5)))
endif else begin
  val=0.0
endelse
;
return,val
end



pro impswe
;
; To solve the linearized shallow water equations using an
; implicit time scheme on a staggered grid
phiref = 1.0 ; Mean geopotential
;
nx=40
dx=1.0/nx
; Grid for phi values
xphi=findgen(nx)*dx
; grid for u values
xu=(findgen(nx)+0.5)*dx
;
; Set aside array space
phi=fltarr(nx)
phip=fltarr(nx)
u=fltarr(nx)
up=fltarr(nx)
rhs=fltarr(nx)
;
dt=0.01
;
nu=dt*dt*phiref/(4*dx*dx)
;
;
; Set initial condition
for j=0,nx-1 do phi(j)=ic(xphi(j))
for j=0,nx-1 do u(j)=ic(xu(j))*sqrt(phiref)
;
plot,xphi,phi
oplot,xu,u
;
loop:
print,'How many steps >'
read,nstep
;
if nstep le 0 then goto,finish
;
; Loop over steps
for istep=1,nstep do begin
  ; Loop over grid points to set up RHS of Helmholtz equation
  for j=0,nx-1 do begin
    jm=j-1
    if jm lt 0 then jm=nx-1
    jp=j+1
    if jp gt nx-1 then jp=0
    rhs(j) = ; ***********
  endfor
  ; Solve Helmholtz problem
  a= ;*******
  b= ; *******
  c=; *******
  phip=trisolve(a,b,c,rhs)
  ; Now use new phi to compute new u
  for j=0,nx-1 do begin
    jp=j+1
    if jp gt nx-1 then jp=0
    up(j) = ; ************
  endfor
  u=up
  phi=phip
endfor
;
;
plot,xphi,phi
oplot,xu,u
;
goto,loop


finish:

end
