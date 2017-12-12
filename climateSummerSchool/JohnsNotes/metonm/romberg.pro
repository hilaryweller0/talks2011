function romberg,n
;
; To integrate a function using Romberg integration
f1 = trap(n)
f2 = trap(n/2)
f3 = trap(n/4)
hs1 = 1.0/16.0
hs2 = 1.0/4.0
hs3 = 1.0
;
; Quadratic fit through three data points
val = ((-hs2)*(-hs3))/((hs1-hs2)*(hs1-hs3))*f1 $
    + ((-hs1)*(-hs3))/((hs2-hs1)*(hs2-hs3))*f2 $
    + ((-hs1)*(-hs2))/((hs3-hs1)*(hs3-hs2))*f3
return,val
;
end
