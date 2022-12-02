clear all
close all

lambda = 600e-9;
n = [1.52 0.237028009053+1i*2.94028330861 1];
esp = [50e-9];
theta = linspace(0,90,100);

%% Paso a paso
for j=1:length(theta)
    n_ef = n(1)*sin(deg2rad(theta(j)));
    for k=1:length(n)
        n_x(k) = sqrt(n(k)^2-n_ef^2);
    end

    A = [1 1; -n_x(1) n_x(1)];
    B = [1 1; -n_x(2) n_x(2)];
    TE1 = pinv(A)*B;

    A = [1 1; -n_x(1)/n(1)^2 n_x(1)/n(1)^2];
    B = [1 1; -n_x(2)/n(2)^2 n_x(2)/n(2)^2];
    TM1 = pinv(A)*B;

    P = [exp(1i*(2*pi/lambda)*n_x(2)*esp) 0; 0 exp(-1i*(2*pi/lambda)*n_x(2)*esp)];

    A = [1 1; -n_x(2) n_x(2)];
    B = [1 1; -n_x(3) n_x(3)];
    TE2 = pinv(A)*B;

    A = [1 1; -n_x(2)/n(2)^2 n_x(2)/n(2)^2];
    B = [1 1; -n_x(3)/n(3)^2 n_x(3)/n(3)^2];
    TM2 = pinv(A)*B;

    MTE = TE2*P*TE1;
    MTM = TM2*P*TM1;

    RTE(j) = abs(-MTE(2,1)/MTE(2,2))^2;
    TTE(j) = (n_x(3)/n_x(1))*abs(MTE(1,1)-MTE(1,2)*MTE(2,1)/MTE(2,2))^2;

    RTM(j) = abs(-MTM(2,1)/MTM(2,2))^2;
    TTM(j) = (n_x(3)/n_x(1))*(n(1)/n(3))^2*abs(MTM(1,1)-MTM(1,2)*MTM(2,1)/MTM(2,2))^2;
end
figure(1);
plot(theta,RTE,theta,RTM);
xlabel('\theta (º)');
ylabel('Factor');
legend('RTE','RTM');

%% Class
plasmon = multicapa(n,esp);
plasmon.lambda = lambda;

for j=1:length(theta)
    plasmon.theta=theta(j);
    plasmon.calculo_coeficientes;
    RTE(j) = plasmon.RTE;
    RTM(j) = plasmon.RTM;
    TTE(j) = plasmon.TTE;
    TTM(j) = plasmon.TTM;
end
figure(2);
plot(theta,RTE,theta,RTM);
xlabel('\theta (º)');
ylabel('Factor');
legend('RTE','RTM');
