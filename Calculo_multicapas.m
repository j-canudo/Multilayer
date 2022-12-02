%% Initial configuration

clear all;
close all;
%Load material data
path = 'INDEX';
files = dir(path);
for i=3:length(files)
    filename = strcat(files(i).folder,'\',files(i).name);
    load(filename);
end
initial_vars = who;

%% Angle study
clearvars('-except',initial_vars{:},'initial_vars');
theta = [0:0.1:90];
lambda = 800e-9; 
n = [1 1.38 1.52];
esp = [50e-9];

mcap = multicapa(n,esp);
mcap.lambda = lambda;

for i=1:length(theta)
    mcap.theta=theta(i);
    mcap.calculo_coeficientes;
    RTE(i) = mcap.RTE;
    TTE(i) = mcap.TTE;
    RTM(i) = mcap.RTM;
    TTM(i) = mcap.TTM;
end

figure(1);
plot(theta,RTE,theta,RTM);
xlabel('\theta (deg)');
ylabel('Factor');
legend('RTE','RTM');

%% Lambda study material
clearvars('-except',initial_vars{:},'initial_vars');
theta = 0;
material = Au;
numero_capas = 1;
lambda = material(:,1)*1e-6;
esp = [50e-9];

mcap = multicapa([],esp);
mcap.theta = theta;

for i=1:length(lambda)
    for j = 1:numero_capas
        n(j) = material(i,2,j)+1i*material(i,3,j);
    end
    mcap.n = [1.52 n 1];
    mcap.lambda = lambda(i);
    mcap.calculo_coeficientes;
    RTE(i) = mcap.RTE;
    TTE(i) = mcap.TTE;
    RTM(i) = mcap.RTM;
    TTM(i) = mcap.TTM;
end

figure(2);
plot(lambda*1e9,RTE,lambda*1e9,RTM);
xlabel('\lambda (nm)');
ylabel('Factor');
legend('RTE','RTM');

%% Lambda study general n
clearvars('-except',initial_vars{:},'initial_vars');
theta = 0;
lambda_min = 750e-9;
lambda = [300:1000]*1e-9;
n = [1 2.413 1.4764 2.413 1.52];
esp = [lambda_min/(4*n(2)) lambda_min/(4*n(3)) lambda_min/(4*n(2))];

mcap = multicapa(n,esp);
mcap.theta = theta;

for i=1:length(lambda)
    mcap.lambda = lambda(i);
    mcap.calculo_coeficientes;
    RTE(i) = mcap.RTE;
    TTE(i) = mcap.TTE;
    RTM(i) = mcap.RTM;
    TTM(i) = mcap.TTM;
end

figure(3);
plot(lambda*1e9,RTE,lambda*1e9,RTM);
xlabel('\lambda (nm)');
ylabel('Factor');
legend('RTE','RTM');

esp_finales = esp*(1e9)/0.75;


