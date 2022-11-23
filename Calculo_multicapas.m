clear all;
close all;

%Initial parameters
theta = 0;
lambda = 800e-9; 
n = [1.52 1.7 1.38 1];
esp = [lambda/(4*n(2)) lambda/(4*n(3))];

mcap = multicapa(n,esp);
mcap.theta = theta;
lambda = [300:1000]*1e-9;

for i=1:length(lambda)
    mcap.lambda = lambda(i);
    mcap.calculo_coeficientes;
    RTE(i) = mcap.RTE;
    TTE(i) = mcap.TTE;
    RTM(i) = mcap.RTM;
    TTM(i) = mcap.TTM;
end

figure(3)
plot(lambda*1e9,RTE);
hold on;
plot(lambda*1e9,RTM);
xlabel('\lambda (nm)');
ylabel('Factor');
legend('RTE','RTM');
