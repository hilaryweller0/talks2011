pro ftcs
    ; File name for final solution
    fileNameOut = 'FTCS.dat'

    ; First setup the grid of x values
    nx = 81
    xmin = 0.
    xmax = 2.
    dx = (xmax - xmin)/(nx-1)
    x = xmin + FINDGEN(nx)*dx

    ; Next setup other controls
    u  = 1.25
    dt = 0.001
    nsteps = 800
    
    ; From these calculate the Courant number
    Co = u*dt/dx
    print, 'Courant number = ', Co
    
    ; Asign initial conditions and old time step values
    phi = analyticSolution(x, 0.0)
    phiOld=phi

    ; plot initial conditions
    PLOT, x, phi, yRANGE=[-0.1,1.1], THICK=4
    dummy=''
    READ, dummy, PROMPT='Press return to continue'

    ; Loop over steps
    for istep=1,nsteps do begin
        ; Loop over grid points and calculate new phi
        for j=1,nx-2 do begin
            phi(j) = phiOld(j) - 0.5*Co*(phiOld(j+1) - phiOld(j-1))
        endfor
        phi(nx-1) = phiOld(nx-1) - Co*(phiOld(nx-1) - phiOld(nx-2))
        phiOld = phi
        ; plot results
        IF ((istep MOD 10) eq 0) THEN BEGIN
            OPLOT, x, phi
            READ, dummy, PROMPT='Press return to continue'
        ENDIF
    endfor
    
    ; write results to output file
    OPENW, 1, fileNameOut
    printf, 1, nx
    for j = 0, nx-1 do begin
        printf, 1, x(j), phi(j)
    endfor
    CLOSE, 1
finish:

end
