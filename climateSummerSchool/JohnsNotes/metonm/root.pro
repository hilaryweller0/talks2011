pro root
;
count=0
err=1
;
x=1
while (count lt 20) and (err gt 0.001) do begin
  x=0.5*(x+(2/x))
  err=abs((x*x-2)/2)
  count=count+1
endwhile
;
print,'After ',count,' iterations x=',x
;
end
