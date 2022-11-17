function [TE] = calculo_TE(n_xi,n_xj)
A = [1 1; -n_xi n_xi];
B = [1 1; -n_xj n_xj];
TE = inv(A)*B;