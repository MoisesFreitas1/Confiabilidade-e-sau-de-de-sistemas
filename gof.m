
clear all
close all
clc

% Dados:
a = 0.05; % N�vel de Confian�a
x = 100:40:500; % Intervalos
j = 10; % N�mero de Intervalos
h = [3 2 4 10 8 7 7 5 6 3]; % Histograma de observa��es

% Observa��es:     
k = length(h) - 1; % graus de liberdade
CHI_D = chi2inv(1-a,k); % Valor cr�tico

% MODELO NORMAL
med = 308.3636; % Estimativa da M�dia
desv = 96.6621; % Estimativa do Desvio Padr�o

E_Norm = zeros(length(h),1);
for i = 1:j
    xI = x(i); % In�cio do Intervalo
    xF = x(i+1); % Final do Intervalo
    E_Norm(i) = (normcdf(x(i+1),med,desv) - normcdf(x(i),med,desv)) * sum(h);
end

% CHI_2:
Chi_Norm = 0;
for i = 1:j
    Chi_Norm = Chi_Norm + ((h(i)-E_Norm(i))^2/E_Norm(i));
end

% MODELO EXPONENCIAL:
lambda = 308.3636; % Estimativa da Taxa

F_Exp = expcdf(x,lambda);
E_Exp = diff(F_Exp) * sum(h);

Chi_Exp = 0;
for i = 1:j
    Chi_Exp = Chi_Exp + ((h(i)-E_Exp(i))^2/E_Exp(i));
end



Chi_Norm
Chi_Exp

% % MODELO NORMAL
% med = 308.3636; % Estimativa da M�dia
% desv = 96.6621; % Estimativa do Desvio Padr�o
% 
% E_Norm = zeros(length(h),1);
% for i = 1:j
%     xI = x(i); % In�cio do Intervalo
%     xF = x(i+1); % Final do Intervalo
%     E_Norm(i) = (normcdf(x(i+1),med,desv) - normcdf(x(i),med,desv)) * sum(h);
% end


