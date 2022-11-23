function [n_x] = calculo_nx(n_ef,n)
n_x = zeros(1,length(n));
for i=1:length(n)
    n_x(i) = sqrt(n(i)^2-n_ef^2);
end
