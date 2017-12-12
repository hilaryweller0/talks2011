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



pro linswe
;
; To solve the linearized shallow water equations using a
; CTCS scheme on an unstaggered grid
phiref = 1.0 ; Mean geopotential
;
nx=40
dx=1.0/nx
twodx=2.0*dx
; Grid for phi values
xphi=findgen(nx)*dx
; grid for u values - same for unstaggered grid
xu=findgen(nx)*dx
;
; Set aside array space
phi=fltarr(nx)
phim=fltarr(nx)
phip=fltarr(nx)
u=fltarr(nx)
um=fltarr(nx)
up=fltarr(nx)
;
dt=0.01
;
;
; Set initial condition
for j=0,nx-1 do phi(j)=ic(xphi(j))
for j=0,nx-1 do u(j)=ic(xu(j))*sqrt(phiref)

lfirst=1 ; Flag to indicate first step
phim=phi
um=u
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
  ; Trick to take FTCS step on first step
  twodt=2.0*dt
  if lfirst eq 1 then twodt=dt
  ; Loop over grid points
  for j=0,nx-1 do begin
    jm=j-1
    if jm lt 0 then jm=nx-1
    jp=j+1
    if jp gt nx-1 then jp=0
    phip(j) = phim(j) - (u(jp)   - u(jm))*(phiref*twodt/twodx)
    up(j)   = um(j)   - (phi(jp) - phi(jm))*(twodt/twodx)
  endfor
  um=u
  u=up
  phim=phi
  phi=phip
  lfirst=0
endfor
;
;
plot,xphi,phi
oplot,xu,u
;
goto,loop


finish:

end
