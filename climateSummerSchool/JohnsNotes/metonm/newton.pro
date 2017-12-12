function dpoly,x
;
; Evaluate a polynomial in x
; and its derivative
a=3.0 & b=1.0 & c=-5.0 & d=-1.0
val=d + x*(c + x*(b + x*a))
dval=c + x*(2*b + x*3*a)
;
; Return result as 2-element array
return,[val,dval]
end

pro newton
;

x=0.0
;
for iter=1,5 do begin
  v=dpoly(x)
  f=v(0) & df=v(1)  
  xnew=x - f/df
  x=xnew
endfor
;
v=dpoly(x)
print,'Estimate for root is ',x
print,'Function value there is ',v(0)
;
end
