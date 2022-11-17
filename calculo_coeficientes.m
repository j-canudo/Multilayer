function [R_TE, T_TE, R_TM, T_TM] = calculo_coeficientes(M_TE,M_TM,n_xi,n_xj,n_i,n_j)
    R_TE = abs(-M_TE(2,1)/M_TE(2,2))^2;
    R_TM = abs(-M_TM(2,1)/M_TM(2,2))^2;
    T_TE = n_xi/n_xj*abs(M_TE(1,1)-M_TE(1,2)*M_TE(2,1)/M_TE(2,2))^2;
    T_TM = n_xi/n_xj*(n_j/n_i)^2*abs(M_TM(1,1)-M_TM(1,2)*M_TM(2,1)/M_TM(2,2))^2;