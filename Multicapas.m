clearvars;
close all;

theta = [0:0.5:89];
lambda = [];
n = [1 1.52];
esp = [];


for i=1:length(theta)
    n_ef = calculo_nef(n(1),theta(i));
    n_x = calculo_nx(n_ef,n);

    TE = calculo_TE(n_x(1),n_x(2));
    TM = calculo_TM(n_x(1),n_x(2),n(1),n(2));

    MTE = TE;
    MTM = TM;

    [RTE(i),TTE(i),RTM(i),TTM(i)] = calculo_coeficientes(MTE,MTM,n_x(1),n_x(2),n(1),n(2));
end

figure(1)
plot(theta,RTE);
hold on;
plot(theta,RTM);
plot(theta,TTE);
plot(theta,TTM);
legend('RTE','RTM','TTE','TTM');
xlabel('\theta (grad)');
ylabel('Coef');
title('Aire-Vidrio');