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
