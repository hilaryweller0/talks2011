function f,x
;
; Function to be integrated
val=sin(x)
return,val
end


function trap,n
;
; Integrate using trapezoidal rule with n intervals
;
pi=3.14159265
a=0
b=5*pi
h=(b-a)/n
s=0.5*(f(a)+f(b))
for k=1,n-1 do begin
  x=a+k*h
  s=s+f(x)
endfor
s=h*s
;
return,s
end



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


pro conv
;
; To examine the convergence of an integration scheme
;
np=10
num=fltarr(np)
err1=fltarr(np)
err2=fltarr(np)
err3=fltarr(np)
n=4
for k=0,np-1 do begin
  print,'k=',k
  err1(k)=abs(trap(n) - 2.0)
  err2(k)=abs(simp(n) - 2.0)
  err3(k)=abs(romberg(n) - 2.0)
  num(k)=n
  n=n*2
endfor
;
plot_oo,num,err3,xtitle='Number of intervals',ytitle='Error'
oplot,num,err2,linestyle=1
oplot,num,err1,linestyle=2

end

