function f = interpToFace(vf)

f = zeros(length(vf)+1, 1);
f(1) = vf(1);
f(end) = vf(end);

for i = 2:length(vf)
    f(i) = 0.5*(vf(i-1) + vf(i));
endfor

