function simp,n
;
; To integrate a function using Simpson's rule
;
fn=trap(n)
fnb2=trap(n/2)
res=(4*fn - fnb2)/3.0
return,res
;
end
