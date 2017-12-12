; Plot linear advection results from different schemes together

PRO plotadvectresults
    ; List of files to plot
    files = ['analytic.dat', 'CTCS.dat', 'FTBS.dat']

    ; List of legends for the files
    legendText = ['analytic', 'CTCS', 'FTBS']
    
    ; List of line styles
    lineStyles = [0,2,3]
    
    ; List of line thicknesses
    lineWidth = [1,1,1]
    
    ; plot graph axes
    plot, [0,2],[0,0], XRANGE=[0,2], YRANGE=[-0.2,1.1], LINESTYLE=1
    oplot, [0,2],[1,1], LINESTYLE=1

    ; plot phi for each file
    FOR i = 0, SIZE(files, /N_ELEMENTS)-1 DO BEGIN
        ; Open the file and read the number of elements in the file
        OPENR, 1, files[i]
        READF, 1, nx
        
        ; assign arrays for x and phi
        x = FLTARR(nx)
        phi = FLTARR(nx)
        
        ; read x and phi then close the file
        for j = 0, nx-1 do begin
            READF, 1, xj, phij
            x(j) = xj
            phi(j) = phij
        endfor
        CLOSE, 1

        ; overplot x and phi
        oplot, x, phi, LINESTYLE=lineStyles(i), THICK=lineWidth(i)
    ENDFOR
    
    legend, legendText, lines=lineStyles, box=0, thick=lineWidth,$
            CHARSIZE=3, POSITION=[0.1,0.8]

FINISH:
END

