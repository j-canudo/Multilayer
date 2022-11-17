function [TM] = calculo_TM (n_xi, n_xj, n_i, n_j)
A = [1 1; -n_xi/n_i^2 n_xi/n_i^2];
B = [1 1; -n_xj/n_j^2 n_xj/n_j^2];
TM = inv(A)*B;