%% Teste gráfico mesma imagem
clc;
syms x y a
f = sin((x^2 + y^2)/a);

subplot(2, 2, 1)
fsurf(subs(f, a, 10))
title('a = 10')

subplot(2, 2, 2)
fsurf(subs(f, a, 20))
title('a = 20')

subplot(2, 2, 3)
fsurf(subs(f, a, 50))
title('a = 50')

subplot(2, 2, 4)
fsurf(subs(f, a, 100))
title('a = 100')

%% Gráfico de preço, num condutores e tensão

Q1 = tabelaresultadosexcelS6(1:height(tabelaresultadosexcelS6),:);
VarNames = tabelaresultadosexcelS6.Properties.VariableNames; 
ax = Q1{:,9};
ay = Q1{:,8};
az = Q1{:,4};

% create a grid basis and then interpolate on the grid
n = 50;
x11 = linspace(min(ax),max(ax),n);
y11 = linspace(min(ay),max(ay),n);
%z11 = griddata(ax',ay,az,x11',y11);
z11 = griddata(ax,ay,az,x11',y11);

% plot it
%surf(x11',y11,Z11)
surf(x11,y11,z11)
% mesh(x11,y11,z11)
xlabel(VarNames{9})
ylabel(VarNames{8})
zlabel(VarNames{4})

% z2=z11(x,y);
% [x11_opt,y11_opt]=find(z2==min(z2(:))); % searching for optimal x, y for minimum z
% z2
%% Gráfico de potência, preço, tensão

Q1 = tabelaresultadosexcelS2(1:height(tabelaresultadosexcelS2),:);
VarNames = tabelaresultadosexcelS2.Properties.VariableNames; 
ax = Q1{:,20};
ay = Q1{:,9};
az = Q1{:,4};

% create a grid basis and then interpolate on the grid
n = 50;
x11 = linspace(min(ax),max(ax),n);
y11 = linspace(min(ay),max(ay),n);
%z11 = griddata(ax',ay,az,x11',y11);
z11 = griddata(ax,ay,az,x11',y11);

% plot it
%surf(x11',y11,Z11)
surf(x11,y11,z11)
% mesh(x11,y11,z11)
xlabel(VarNames{20})
ylabel(VarNames{9})
zlabel(VarNames{4})

% z2=z11(x,y);
% [x11_opt,y11_opt]=find(z2==min(z2(:))); % searching for optimal x, y for minimum z
% z2
%% Gráfico de potência, preço, tensão

Q1 = tabela_viaveis_ordenada(1:height(tabela_viaveis_ordenada),:);
VarNames = tabela_viaveis_ordenada.Properties.VariableNames; 
ax = Q1{:,15};
ay = Q1{:,5};
az = Q1{:,1};

% create a grid basis and then interpolate on the grid
n = 50;
x11 = linspace(min(ax),max(ax),n);
y11 = linspace(min(ay),max(ay),n);
%z11 = griddata(ax',ay,az,x11',y11);
z11 = griddata(ax,ay,az,x11',y11);

% plot it
%surf(x11',y11,Z11)
surf(x11,y11,z11)
% mesh(x11,y11,z11)
xlabel(VarNames{15})
ylabel(VarNames{5})
zlabel(VarNames{1})

% z2=z11(x,y);
% [x11_opt,y11_opt]=find(z2==min(z2(:))); % searching for optimal x, y for minimum z
% z2
%% Perdas
Q1 = tabela_viaveis_ordenada(1:height(tabela_viaveis_ordenada),:);
VarNames = tabela_viaveis_ordenada.Properties.VariableNames; 
ax = Q1{:,6};
ay = Q1{:,5};
az = Q1{:,13};

% create a grid basis and then interpolate on the grid
n = 50;
x11 = linspace(min(ax),max(ax),n);
y11 = linspace(min(ay),max(ay),n);
%z11 = griddata(ax',ay,az,x11',y11);
z11 = griddata(ax,ay,az,x11',y11);

% plot it
%surf(x11',y11,z11)
surf(x11,y11,z11)
%stem3(x11,y11,z11)
xlabel(VarNames{6})
ylabel(VarNames{5})
zlabel(VarNames{13})