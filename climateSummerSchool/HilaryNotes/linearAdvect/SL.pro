function ic,x
;
; Initial condition for linear advection
pi=3.14159265
if (0.25 le x) and (x le 0.75) then begin
  val=0.5*(1.0 + cos(4.0*pi*(x-0.5)))
endif else begin
  val=0.0
endelse
;
return,val
end


pro SL
u=1.1
dt=0.03
nsteps=20

; Grid of x values
nx=40
xmin = 0.
xmax = 1.
dx=(xmax - xmin)/nx
x = xmin + findgen(nx)*dx*(xmax-xmin)

dummy=''
PRINT, 'Courant number = ', u*dt/dx
; Set aside array space
phi=fltarr(nx)
; Set initial condition
for j=0,nx-1 do phi(j)=ic(x(j))
phiOld=phi
PLOT,x,phi, yRANGE=[-0.1,1.1]
READ, dummy, PROMPT='Press return to continue'

; Loop over steps
for istep=1,nsteps do begin
    ; Loop over grid points
    for j=0,nx-1 do begin
        xD = x(j) - u*dt
        IF (xD LT xmin) THEN xD += (xmax-xmin) $
        ELSE IF (xD GT xmax) THEN xD -= (xmax-xmin)
        jD0 = floor(xD*nx)
        jD1 = (jd0+1) MOD nx
        beta = (xD - x(jD0))/dx
        phi(j) = (1-beta)*phiOld(jD0) + beta*phiOld(jD1)
    endfor
    phiOld = phi
    OPLOT,x,phi
    READ, dummy, PROMPT='Press return to continue'
endfor

finish:

end
