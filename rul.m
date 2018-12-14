
% clear all
close all
% clc

% Inicializaçao do Gerador de Números Aleatórios:
rng('shuffle') % Inicialização Aleatória
rng (100) % Mesma Sequencia

% Dados:
T = (1:10)';
Y = [4.5 14.9 13.4 18.7 17.7 22.0 28.9 27.9 35.2 35.6]';

LF = 50;

% Visualização:
figure(1)
hold on
plot(T,Y,'bo','MarkerFaceColor','y','MarkerSize',7)

plot([0 25],[LF,LF],'r--')
axis([0 25 0 LF+10])
xlabel('Tempo')
ylabel('Índice de Degradação')

% Bootstrap:
n = 10; % Iterações
np = length(T); % Número de pontos
ind = ceil(10 * rand(np,1)); % Sorteio

K = zeros(n,2);
for i = 1:n
    t = T;
    y = Y;
    t(ind(i),:) = [];
    y(ind(i),:) = [];
    K(i,:) = polyfit(t,y,1); % [a b] ==> y = a.x + b
end

% Visualização dos Modelos:
TF = zeros(n,1); % Tempos de Falhas
for i = 1:n
    TF(i) = (LF - K(i,2)) / K(i,1); % y = a.x + b => LF = a.TF + b
    plot([0,TF(i)],[K(i,2),LF],'c');
end

% Tempo de Falha (Assumindo Dist. Normal):
[med,desv] = normfit(TF);

% Visualização do RUL:
inf = med - 3*desv;
sup = med + 3*desv;
range = sup - inf;
xf = inf:range/100:sup;
yf = normpdf(xf,med,desv) * 5;
plot(xf,yf+LF,'b')

% TF:
% med = 20.5788;
% desv = 0.6375;
% 
% RUL:
% med = 10.5788;
% desv = 0.6375;

% %%%%%%%%%%%%%%%%%%%%%%
% % Ruído:
% Y = [2.2 10.5 12.6 19.1 15.8 29.2 31.4 23.2 29.5 41.2]';
% % Poucos Pontos:
% T = 2:2:10;
% Y = [14.9 18.7 22.0 27.9 35.6]';
% %%%%%%%%%%%%%%%%%%%%%%%

