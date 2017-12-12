function trisolve,a,b,c,r
;
; To solve the constant coefficient, periodic domain,
; tridiagnonal linear system
; Ax = r
; where a is the value below the diagonal of A,
; b is the value on the diagnonal of A,
; c is the value above the diagonal of A,
; and r is the known vector right hand side.
;
n=n_elements(r); determine size of problem
;
x=fltarr(n); array for result
q=fltarr(n); workspace
s=fltarr(n); workspace
;
rmx=r(n-1)
;
; Forward elimination sweep
q(0)=-c/b
x(0)=r(0)/b
s(0)=-a/b
for j=1,n-1 do begin
  p=1.0/(b+a*q(j-1))
  q(j)=-c*p
  x(j)=(r(j)-a*x(j-1))*p
  s(j)=-a*s(j-1)*p
endfor
;
; Backward pass
q(n-1)=0.0
s(n-1)=1.0
for j=n-2,0,-1 do begin
  s(j)=s(j)+q(j)*s(j+1)
  q(j)=x(j)+q(j)*q(j+1)
endfor
;
; Final pass
x(n-1)=(rmx-c*q(0)-a*q(n-2))/(c*s(0)+a*s(n-2)+b)
for j=0,n-2 do begin
  x(j)=x(n-1)*s(j)+q(j)
endfor
;
return,x
;
end
