function fact,k
; To compute the factorial of k
;
result=1
for j=1,k do begin
  result=result*j
endfor
;
return,result
;
end
