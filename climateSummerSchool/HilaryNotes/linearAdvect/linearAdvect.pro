; Set of functions to perform 1d linear advection of scalar field, phi, on a
; uniform 1d grid, x


; Function to find analytic solution after the flow has travelled a distance D
; (also for initial conditions with D=0)
FUNCTION analyticSolution, x, D, xmax
    pi=3.14159265
    nx = SIZE(x, /N_ELEMENTS)
    ; Set asside array space for phi
    phi = FLTARR(nx)
    FOR j=0,nx-1 DO BEGIN
        xD = (x(j) - D) MOD xmax
        IF (xD LT 0) THEN xD += xmax
        IF (0.15 LE xD) AND (xD LE 0.65) THEN BEGIN
            phi(j) = 0.5*(1 + COS(4*pi*(xD - 0.4)))
        ENDIF ELSE BEGIN
            phi(j) = 0.0
        ENDELSE
    ENDFOR
    RETURN, phi
END


; Procedure for FTBS advection for one time step
PRO ftbs,phi,Co
    nx = SIZE(phi, /N_ELEMENTS)
    FOR j=nx-1,1,-1 DO BEGIN
        phi(j) -= Co*(phi(j) - phi(j-1))
    ENDFOR
    phi(0) -= Co*(phi(0) - phi(nx-1))
    RETURN
END


; Procedure for linear semi-Lagrangian advection for one time step
PRO linearSemiLagrange, phi, phiOld, Co
    nx = SIZE(phi, /N_ELEMENTS)
    FOR j=0,nx-1 DO BEGIN
        jDL = floor(j - Co)
        beta = j - Co - jDL
        IF (jDL LT 0) THEN jDL += nx $
        ELSE IF (jDL GE nx) THEN jDL -= nx
        jDR = jDL+1
        if (jDR GE nx) THEN jDR -= nx
        phi(j) = (1-beta)*phiOld(jDL) + beta*phiOld(jDR)
    ENDFOR
    phiOld = phi
END


; Procedure for cubic semi-Lagrangian advection for one time step
PRO cubicSemiLagrange, phi, phiOld, Co
    nx = SIZE(phi, /N_ELEMENTS)
    FOR j=0,nx-1 DO BEGIN
        jDL = floor(j - Co)
        beta = j - Co - jDL
        IF (jDL LT 0) THEN jDL += nx $
        ELSE IF (jDL GE nx) THEN jDL -= nx
        jDR = jDL+1
        IF (jDR GE nx) THEN jDR -= nx
        jDLL = jDL - 1
        IF (jDLL LT 0) THEN jDLL += nx
        jDRR = jDR + 1
        IF (jDRR GE nx) THEN jDRR -= nx
        phi(j) = -1./6.*beta*(1-beta)*(2-beta)*phiOld(jDLL) $
               + 0.5*(1+beta)*(1-beta)*(2-beta)*phiOld(jDL) $
               + 0.5*(1+beta)*beta*(2-beta)*phiOld(jDR) $
               - 1./6.*(1+beta)*beta*(1-beta)*phiOld(jDRR)
    ENDFOR
    phiOld = phi
END


; Procedure for CTCS advection for one time step
PRO ctcs, phi, phiOld, phiOldOld, Co
    nx = SIZE(phi, /N_ELEMENTS)
    
    FOR j=1,nx-2 DO BEGIN
        phi(j) = phiOldOld(j) - Co*(phiOld(j+1) - phiOld(j-1))
    ENDFOR
    phi(0) = phiOldOld(0) - Co*(phiOld(1) - phiOld(nx-1))
    phi(nx-1) = phiOldOld(nx-1) - Co*(phiOld(0) - phiOld(nx-2))

    phiOldOld = phiOld
    phiOld = phi
    
    RETURN
END


; Function to sum the total mass in the domain
FUNCTION totalMass,phi,dx
    mass = 0.0
    nx = SIZE(phi, /N_ELEMENTS)
    FOR j=0, nx-1 DO BEGIN
        mass += dx*phi(j)
    ENDFOR
    RETURN, mass
END


; Controlling programme to setup the grid, time through time, advect the 
; solution and plot the results
PRO linearAdvect

    ; First setup the grid of x values
    nx = 40
    xmin = 0.
    xmax = 1.
    dx = (xmax - xmin)/nx
    x = xmin + FINDGEN(nx)*dx*(xmax-xmin)

    ; Next setup other controls
    u  = 1.1
    dt = 0.2
    nsteps = 2
    
    ; From these calculate the Courant number
    Co = u*dt/dx
    print, 'Courant number = ', Co

    ; Asign initial conditions and old and oldOld time step values
    phi = analyticSolution(x, 0.0, xmax)
    phiOld=phi
    phiOldOld=phi
    
    ; Plot initial conditions
    PLOT,x,phi, YRANGE=[-0.1,1.1]
    ; Print the total amount of mass
    PRINT, 'Total mass at time 0 is ', totalMass(phi,dx), $
            ' Press return to continue'
    dummy=''
    ;READ, dummy

    ; Loop over time steps, advect the solution using ftbs and plot each step
    FOR istep = 1,nsteps DO BEGIN
        ftbs,phi,Co
        OPLOT,x,phi
    ENDFOR
    PRINT, 'FTBS, total mass at time ', dt*istep, ' is ', totalMass(phi,dx)
    
    ; Save the ftbs solution
    phiFTBS = phi
    
    ; Asign initial conditions and old and oldOld time step values
    phi = analyticSolution(x, 0.0, xmax)
    phiOld=phi
    phiOldOld=phi

    ; Loop over time steps, advect the solution using ctcs and plot each step
    FOR istep = 1,nsteps DO BEGIN
        ctcs,phi,phiOld,phiOldOld,Co
        OPLOT,x,phi
    ENDFOR
    PRINT, 'CTCS, total mass at time ', dt*istep, ' is ', totalMass(phi,dx)
    
    ; Save the ctcs solution
    phiCTCS = phi
    
    ; Asign initial conditions and old and oldOld time step values
    phi = analyticSolution(x, 0.0, xmax)
    phiOld=phi
    phiOldOld=phi

    ; Loop over time steps, advect the solution using linear semi-Lagrangian
    FOR istep = 1,nsteps DO BEGIN
        linearSemiLagrange,phi,phiOld,Co
        OPLOT,x,phi
    ENDFOR
    PRINT, 'linear semi-Lagrangian, total mass at time ', dt*istep, ' is ', totalMass(phi,dx)
    
    ; Save the linear semi-Lagrangian solution
    phiLSL = phi
    
    ; Asign initial conditions and old and oldOld time step values
    phi = analyticSolution(x, 0.0, xmax)
    phiOld=phi
    phiOldOld=phi

    ; Loop over time steps, advect the solution using cubic semi-Lagrangian
    FOR istep = 1,nsteps DO BEGIN
        cubicSemiLagrange,phi,phiOld,Co
        OPLOT,x,phi
    ENDFOR
    PRINT, 'cubic semi-Lagrangian, total mass at time ', dt*istep, ' is ', totalMass(phi,dx)
    
    ; Save the cubic semi-Lagrangian solution
    phiCSL = phi
    
    ; Plot the final solutions in comparison to the analytic solution
    phiTrue = analyticSolution(x, u*dt*nsteps, xmax)
    PLOT, x, phiTrue, YRANGE=[-0.1,1.1]
    OPLOT, x, phiFTBS, LINESTYLE=2, THICK=2
    OPLOT, x, phiCTCS, LINESTYLE=3, THICK=2
    ;OPLOT, x, phiLSL, LINESTYLE=4, THICK=4
    OPLOT, x, phiCSL, LINESTYLE=1, THICK=4
    legend,['exact','FTBS','CTCS','CSL'],lines=[0,2,3,1],/left,box=0,$
           thick=[1,2,2,4]

FINISH:
END
