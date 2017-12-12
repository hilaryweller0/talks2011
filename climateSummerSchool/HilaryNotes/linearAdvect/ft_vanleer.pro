; Forward in time with van Leer advection
pro ft_vanleer
    ; File name for final solution
    fileNameOut = 'FT_vanLeer.dat'

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
    
    ; Asign initial conditions
    phi = analyticsolution(x, 0.0)

    ; plot initial conditions
    PLOT, x, phi, yRANGE=[-0.1,1.1], THICK=4
    dummy=''
    READ, dummy, PROMPT='Press return to continue'

    ; Loop over time steps
    for istep=1,nsteps do begin
        ; set the old phi
        phiOld = phi
        ; Loop over grid points and calculate new phi using van Leer
        for j=1,nx-2 do begin
            ratio = (phiOld(j)-phiOld(j-1))/(phiOld(j+1)-phiOld(j) + 1e-12)
            limiter = (ratio + abs(ratio))/(1 + abs(ratio))
            if (limiter lt 0) or (limiter gt 1) then begin
                print, 'limiter = ', limiter
            endif
            phi(j) = phiOld(j) - Co*$
            ($
                0.5*limiter*(phiOld(j+1) - phiOld(j-1))$
              + (1-limiter)*(phiOld(j) - phiOld(j-1))$
            )
        endfor
        ; plot results
        IF ((istep MOD 10) eq 0) THEN BEGIN
            OPLOT, x, phi
            READ, dummy, PROMPT='Press return to continue'
        ENDIF
    endfor
    
    ; plot the final solution
    oplot, x, phi, THICK=4
    
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
