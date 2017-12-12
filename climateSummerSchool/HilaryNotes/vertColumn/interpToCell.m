function fc = interpToCell(f)

fc = zeros(length(f)-1, 1);

for i = 1:length(fc)
    fc(i) = 0.5*(f(i) + f(i+1));
endfor

