
% Resetar tabelas
clc;
tabela_viaveis1 = table(); tabela_50MW = table(); tabela_200MW = table();
tabela_350MW = table(); tabela_500MW = table();
writetable(tabela_viaveis1, "tabela_resultados_excel.xlsx", "Sheet", "tabela_viaveis",...
    WriteMode='overwritesheet', AutoFitWidth=true, UseExcel=false);
writetable(tabela_50MW, "tabela_resultados_excel.xlsx", "Sheet", "50MW",...
    WriteMode='overwritesheet', AutoFitWidth=true, UseExcel=false);
writetable(tabela_200MW, "tabela_resultados_excel.xlsx", "Sheet", "200MW",...
    WriteMode='overwritesheet', AutoFitWidth=true, UseExcel=false);
writetable(tabela_350MW, "tabela_resultados_excel.xlsx", "Sheet", "350MW",...
    WriteMode='overwritesheet', AutoFitWidth=true, UseExcel=false);
writetable(tabela_500MW, "tabela_resultados_excel.xlsx", "Sheet", "500MW",...
    WriteMode='overwritesheet', AutoFitWidth=true, UseExcel=false);

% Criar tabela de cenários viáveis
tabela_viaveis1 = readtable("tabela_resultados_excel.xlsx", "Sheet","tabela_completa");
tabela_viaveis = tabela_viaveis1(tabela_viaveis1.viavel == 1,:);
tabela_viaveis_ordenada = sortrows(tabela_viaveis, [20 4]);     % Potência e custo
writetable(tabela_viaveis_ordenada, "tabela_resultados_excel.xlsx", "Sheet", "tabela_viaveis",...
    WriteMode="append", AutoFitWidth=true, UseExcel=false);


% Porcentagem de cenarios viáveis
% Abrir tabela de resultados do script anterior
tabela_entrada = readtable("tabela_resultados_excel.xlsx", "Sheet", "tabela_entrada");
linhas = height(tabela_entrada);

% cenarios_possiveis = linhas * width(tensoes) * width(num_condutores) * length(potencia_real)
cenarios_possiveis = linhas * 5 * 4 * 4
cenarios_viaveis = height(tabela_viaveis_ordenada)
porcentagem_cenarios_viaveis = 100 * (cenarios_viaveis/cenarios_possiveis)


% Tabelas separadas por potência
T = tabela_viaveis_ordenada;
tabela_50MW = T(T.Sr_real == 50000000,:);
numero_50MW = height(tabela_50MW);
porcentagem_cenarios_50MW = 100 * (height(tabela_50MW)/cenarios_viaveis)
writetable(tabela_50MW, "tabela_resultados_excel.xlsx", "Sheet", "50MW",...
    WriteMode="append", AutoFitWidth=true, UseExcel=false);

tabela_200MW = T(T.Sr_real == 200000000,:);
numero_200MW = height(tabela_200MW);
porcentagem_cenarios_200MW = 100 * (height(tabela_200MW)/cenarios_viaveis)
writetable(tabela_200MW, "tabela_resultados_excel.xlsx", "Sheet", "200MW",...
    WriteMode="append", AutoFitWidth=true, UseExcel=false);

tabela_350MW = T(T.Sr_real == 350000000,:);
numero_350MW = height(tabela_350MW);
porcentagem_cenarios_350MW = 100 * (height(tabela_350MW)/cenarios_viaveis)
writetable(tabela_350MW, "tabela_resultados_excel.xlsx", "Sheet", "350MW", WriteMode="append", AutoFitWidth=true, UseExcel=false);

tabela_500MW = T(T.Sr_real == 500000000,:);
numero_500MW = height(tabela_500MW);
porcentagem_cenarios_500MW = 100 * (height(tabela_500MW)/cenarios_viaveis)
writetable(tabela_500MW, "tabela_resultados_excel.xlsx", "Sheet", "500MW", WriteMode="append", AutoFitWidth=true, UseExcel=false);

% Checar porcentagens
porcentagem_total = porcentagem_cenarios_50MW + porcentagem_cenarios_200MW + porcentagem_cenarios_350MW + porcentagem_cenarios_500MW
