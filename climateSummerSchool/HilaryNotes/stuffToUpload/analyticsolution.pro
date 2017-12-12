; Function to find analytic solution after the flow has travelled a distance D
; at locations in array x (also for initial conditions with D=0)
FUNCTION analyticsolution, x, D
    pi=3.14159265
    nx = SIZE(x, /N_ELEMENTS)
    xmax = max(x)
    ; Set asside array space for phi
    phi = FLTARR(nx)
    FOR j=0,nx-1 DO BEGIN
        xD = (x(j) - D) MOD xmax
        IF (xD LT 0) THEN xD += xmax
        IF (0.25 LE xD) AND (xD LE 0.75) THEN BEGIN
            phi(j) = 0.5*(1 + COS(4*pi*(xD - 0.5)))
        ENDIF ELSE BEGIN
            phi(j) = 0.0
        ENDELSE
    ENDFOR
    RETURN, phi
END

