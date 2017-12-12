function poly,x
;
; Evaluate a polynomial in x
a=3.0 & b=1.0 & c=-5.0 & d=-1.0
val=d + x*(c + x*(b + x*a))
;
return,val
end

pro regula
;
xl=-1.0 & fl=poly(xl)
xr=1.0 & fr=poly(xr)
;
for iter=1,5 do begin
  xnew=(xl*fr-xr*fl)/(fr-fl)
  fnew=poly(xnew)
  if (fl*fnew) gt 0 then begin
    xl=xnew & fl=fnew
  endif else begin
    xr=xnew & fr=fnew
  endelse
endfor
;
print,'Root lies between ',xl,' and ',xr
print,'Best guess is ',xnew,' Function value ',fnew
;
;
end
