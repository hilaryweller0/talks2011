; Semi-Lagrangian advection of an initial profile given in exterior function
; analyticsolution(x, D) using linear interpolatin onto departure points
pro sl_cubic
    ; File name for final solution
    fileNameOut = 'SLlinear.dat'

    ; First setup the grid of x values
    nx = 81
    xmin = 0.
    xmax = 2.
    dx = (xmax - xmin)/(nx-1)
    x = xmin + FINDGEN(nx)*dx

    ; Next setup other controls
    u  = 1.25
    dt = 0.0123
    nsteps = 60
    
    ; From these calculate the Courant number
    Co = u*dt/dx
    print, 'Courant number = ', Co

    ; Asign initial conditions
    phi = analyticsolution(x, 0.0)

    ; Calculate initial mass
    phiSum = 0;
    for j = 0,nx-1 do begin
        phiSum += phi(j)
    endfor
    phiSum *= dx
    print, 'Initial mass = ', phiSum

    ; plot initial conditions
    PLOT, x, phi, yRANGE=[-0.1,1.1], THICK=4
    dummy=''
    READ, dummy, PROMPT='Press return to continue'

    ; Loop over time steps
    for istep=1,nsteps do begin
        ; set the old phi
        phiOld = phi
        ; Loop over grid points and calculate new phi
        for j=1,nx-1 do begin
            ; Calculate the departure point and the index of the point to the left
            xjD = x(j) - u*dt
            k = floor(xjD/dx)
            ; If the departure point is within the domain, interpolate onto it
            IF (k GT 1) AND (k LT nx-3) THEN BEGIN
                beta = (xjD - x(k))/dx
                phi(j) = - 1./6.*beta*(1-beta)*(2-beta)*phiOld(k-1) $
                       + 0.5*(1+beta)*(1-beta)*(2-beta)*phiOld(k) $
                       + 0.5*(1+beta)*beta*(2-beta)*phiOld(k+1) $
                       - 1./6.*beta*(1-beta)*(1+beta)*phiOld(k+2)
            ENDIF ELSE BEGIN
                phi(j) = 0
            ENDELSE
        endfor
        ; plot results
        IF ((istep MOD 1) eq 0) THEN BEGIN
            OPLOT, x, phi
            ;READ, dummy, PROMPT='Press return to continue'
        ENDIF
    endfor
    
    ; Calculate final mass change
    for j = 0,nx-1 do begin
        phiSum -= phi(j)*dx
    endfor
    print, 'Final mass change = ', phiSum
    
    ; write results to output file
    OPENW, 1, fileNameOut
    printf, 1, nx
    for j = 0, nx-1 do begin
        printf, 1, x(j), phi(j)
    endfor
    CLOSE, 1

finish:

end
