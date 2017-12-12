; CTCS advection with Robert-Asselin time filtering
pro ctcs_ra
    ; File name for final solution
    fileNameOut = 'CTCSRA01.dat'

    ; First setup the grid of x values
    nx = 81
    xmin = 0.
    xmax = 2.
    dx = (xmax - xmin)/(nx-1)
    x = xmin + FINDGEN(nx)*dx

    ; Next setup other controls
    u  = 1.25
    dt = 0.01
    nsteps = 80
    
    ; From these calculate the Courant number
    Co = u*dt/dx
    print, 'Courant number = ', Co
    
    ; Robert-Asselin filter coefficient
    epsilon = 0.1

    ; Asign initial conditions
    phi = analyticsolution(x, 0.0)

    ; plot initial conditions
    PLOT, x, phi, yRANGE=[-0.1,1.1], THICK=4
    dummy=''
    READ, dummy, PROMPT='Press return to continue'

    ; FTCS for first time step
    phiOld=phi
    ; Loop over grid points and calculate new phi
    for j=1,nx-2 do begin
        phi(j) = phiOld(j) - 0.5*Co*(phiOld(j+1) - phiOld(j-1))
    endfor

    ; Loop over subsequent steps
    for istep=2,nsteps do begin
        ; set the old and oldOld phi
        phiOldOld = phiOld
        phiOld = phi
        ; Loop over grid points and calculate new phi using CTCS
        for j=1,nx-2 do begin
            phi(j) = phiOldOld(j) - Co*(phiOld(j+1) - phiOld(j-1))
        endfor
        phiOld += epsilon*(phi - 2*phiOld + phiOldOld)
        ; plot results
        IF ((istep MOD 1) eq 0) THEN BEGIN
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

    ; write the analytic solution to file 'analytic.dat'
    phi = analyticSolution(x, 1.0)
    OPENW, 1, 'analytic.dat'
    printf, 1, nx
    for j = 0, nx-1 do begin
        printf, 1, x(j), phi(j)
    endfor
    CLOSE, 1


finish:

end
