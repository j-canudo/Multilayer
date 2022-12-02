%% SPR
clear all
close all

theta = linspace(0,90,1000);
lambda = 700e-9;
n = [1.52 0.131+1i*4.0624 1.4553 1];
esp = [50e-9 5e-9];
plasmon = multicapa(n,esp);
plasmon.lambda = lambda;
for i=1:length(theta)
    plasmon.theta = theta(i);
    plasmon.calculo_coeficientes;
    RTE(i) = plasmon.RTE;
    RTM(i) = plasmon.RTM;
    TTE(i) = plasmon.TTE;
    TTM(i) = plasmon.TTM;
end
figure(1);
plot(theta,RTE,'-b',theta,RTM,'-r',theta,TTE,'--b',theta,TTM,'--r');
xlabel('\theta (º)');
ylabel('Factor');
legend('RTE','RTM','TTE','TTM');
title('SPR for Au thickness of 50 nm');

%% Refractive index study for 50nm Au layer
clear all
close all

theta = linspace(0,90,1000);
lambda = 700e-9;
n_study = [0.8 0.85 0.9 0.95 1 1.05 1.1 1.15 1.2];
esp = [50e-9 5e-9];

for i=1:length(n_study)
    n = [1.52 0.131+1i*4.0624 1.4553 n_study(i)];
    plasmon = multicapa(n,esp);
    plasmon.lambda = lambda;
    for j=1:length(theta)
        plasmon.theta = theta(j);
        plasmon.calculo_coeficientes;
        RTM(j) = plasmon.RTM;
    end
    figure(1);
    plot(theta,RTM,'DisplayName',['n = ',num2str(n_study(i))]);
    hold on;
end
xlabel('\theta (º)');
ylabel('Factor');
legend('Location','southeast');
title(['SPR for different refractive index - \lambda = ',num2str(lambda*1e9),' nm']);
hold off;

%% Au thickness study single wavelength
clear all
close all

theta = linspace(0,90,1000);
lambda = 700e-9;
n = [1.52 0.131+1i*4.0624 1.4553 1];
esp_Au = [10 20 30 40 50 60 70 80 90 100]*1e-9;

for i=1:length(esp_Au)
    esp = [esp_Au(i) 5e-9];
    plasmon = multicapa(n,esp);
    plasmon.lambda = lambda;
    for j=1:length(theta)
        plasmon.theta=theta(j);
        plasmon.calculo_coeficientes;
        RTM(j) = plasmon.RTM;
    end
    figure(1);
    plot(theta,RTM,'DisplayName',['Au esp = ',num2str(esp_Au(i)*1e9),' nm']);
    hold on;
end
xlabel('\theta (º)');
ylabel('Factor');
legend('Location','southeast');
title(['SPR for different Au thickness - \lambda = ',num2str(lambda*1e9),' nm']);
hold off;


%% Au thickness study for different wavelengths
clear all
close all

theta = linspace(0,90,100);
lambda = [300 400 500 600 700 800 900 1000]*1e-9;
n_Au_real = [1.5258 1.4684 0.97112 0.24873 0.131 0.15352 0.17435 0.22769];
n_Au_imag = [1.8878 1.953 1.8737 3.074 4.0624 4.9077 5.7227 6.4731];
n_SiO2 = [1.4878 1.4701 1.463 1.458 1.4553 1.4533 1.4518 1.4504];

esp_Au = [20 30 40 50 60 70 80]*1e-9;
for k=1:length(esp_Au)
for i=1:length(lambda)
n = [1.52 n_Au_real(i)+1i*n_Au_imag(i) n_SiO2(i) 1];
esp = [esp_Au(k) 5e-9];
theta = linspace(0,90,1000);

plasmon = multicapa(n,esp);
plasmon.lambda = lambda(i);

for j=1:length(theta)
    plasmon.theta=theta(j);
    plasmon.calculo_coeficientes;
    RTE(j) = plasmon.RTE;
    RTM(j) = plasmon.RTM;
    TTE(j) = plasmon.TTE;
    TTM(j) = plasmon.TTM;
end
figure(k);
plot(theta,RTM,'DisplayName',['\lambda= ',num2str(lambda(i)*1e9),' nm']);
xlabel('\theta (º)');
ylabel('Factor');
title(['RTM - Au thickness: ',num2str(esp_Au(k)*1e9),' nm']);
hold on;
end
figure(k);
legend;
hold off;
end


