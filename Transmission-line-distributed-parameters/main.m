% INFO
% Trabalho de Conclusão de Curso
% Lorenzo F.C.
% 2022
clc;
clear;
format shortEng;
fclose all;

% Resetar tabelas de saída
tabela_viaveis = table();
writetable(tabela_viaveis, "tabela_resultados_excel.xlsx", "Sheet", "tabela_viaveis", ...
    WriteMode='overwritesheet', AutoFitWidth=false, UseExcel=false);

tabela_completa = table();
writetable(tabela_completa, "tabela_resultados_excel.xlsx", "Sheet", "tabela_completa", ...
    WriteMode='overwritesheet', AutoFitWidth=false, UseExcel=false);

% Abrir tabela de entrada
tabela_entrada = readtable("tabela_resultados_excel.xlsx", "Sheet", "tabela_entrada")
linhas = height(tabela_entrada);

% Vetores de potência ativa/reativa
potencia_real = linspace(50e6,500e6,4);
potencia_imag = linspace(20e6,200e6,4);

for x = 1:length(potencia_real)
    Sr = potencia_real(x) + (potencia_imag(x)*i);
    for row = 1:linhas

    % DADOS DOS CONDUTORES
    nome_cabo = tabela_entrada.nome_cabo(row);    
    diametro = tabela_entrada.diametro(row);        % Em metros
    Res_50 = tabela_entrada.Res_50(row);            % Resistência a 50º [ohms/km]
    RMG = tabela_entrada.RMG(row);
    custo_cabo_tabela = tabela_entrada.custo(row);
    ampacidade = tabela_entrada.ampacidade(row);

    % DADOS DA LINHA DE TRANSMISSÃO
    f = 60;
    d = 0.5;    % Distância entre condutores da mesma fase
    anos = 30;  % Horizonte de investimento
    km = 500;   % Comprimento da LT
    
    % Critérios de viabilidade
    angulo_carga = 30;
    reg_tensao_min = 0.9;
    reg_tensao_max = 1.1;
    
    % CÁLCULO   
    % Vetor 1x5 - Parâmetros dos níveis de tensão
    tensoes = [230e3 345e3 440e3 500e3 765e3];
    dist_min = [3.5 5 6.5 7.5 11];
    custo_km = [10 20 40 80 160];
    
    % Vetor 1x4 - Variação do número de condutores por fase
    num_condutores = [1 2 3 4];

    % Loop for p/ Variação dos Parâmetros
    qtd_tensoes = length(tensoes);    
    for x = 1:qtd_tensoes
        for y = 1:4
            R = Res_50;
            raio = diametro/2;
            VrL = tensoes(x);
            num_cond = num_condutores(y);
            dist_f = dist_min(x);   % Distância entre fases, espaçamento horizontal

            % Vetores 1x4 de Distância média própria p/ Indutância e Capacitância
            DsL_cond = [RMG sqrt(RMG*d) nthroot(RMG*(d^2), 3)...
                nthroot(RMG*(d^3)*sqrt(2), 4)];
            
            DsC_cond = [raio sqrt(raio*d) nthroot(raio*(d^2), 3)...
                nthroot(raio*(d^3)*sqrt(2), 4)];

            % 1º) Cálculo dos parâmetros da LT:
            % Resistência, com 'n' condutores por fase:
            R = R/num_cond;         % [ohms/km]

            %Indutância e reatância capacitiva:
            Deq = (dist_f * dist_f * (2*dist_f))^(1/3);
            DsL = DsL_cond(y);
            L = (2e-7) * log(Deq/DsL);
            L = L * 1000;
            XL = 2*pi * f * L;

            % Capacitância e admitância em derivação:
            E0 = 8.85418e-12;  % Constante
            DsC = DsC_cond(y);
            C = (2*pi * E0)/(log(Deq/DsC));
            C = C * 1000;
            Yc = j* 2*pi*f * C;


            % 2º) Cálculo das constantes ABCD:
            % Constante de propagação
            Z = (R + j*XL);
            Z_polar = abs(Z);
            Z_theta = angle(Z)*180/pi;

            CP = sqrt(Z * Yc);
            CP_polar = abs(CP);
            CP_theta = angle(CP)*180/pi;

            CP = CP * km;   % LT de x km
            CP_polar = abs(CP);
            CP_theta = angle(CP)*180/pi;

            % Impedância característica natural
            Zc = sqrt(Z/Yc);
            Zc_polar = abs(Zc);
            Zc_theta = angle(Zc)*180/pi;

            % Constantes ABCD
            A = cosh(CP);
            A_polar = abs(A);
            A_theta = angle(A)*180/pi;

            B = Zc * sinh(CP);
            B_polar = abs(B);
            B_theta = angle(B)*180/pi;

            C = (1/Zc) * sinh(CP);
            C_polar = abs(C);
            C_theta = angle(C)*180/pi;

            D = A;
            D_polar = abs(D);
            D_theta = angle(D)*180/pi;


            % 3º) Cálculo da tensão e corrente na barra emissora:
            Sr_polar = abs(Sr);
            Sr_theta = angle(Sr)*180/pi;
            Sr_real = real(Sr);
            Sr_imag = imag(Sr);

            VrF = VrL/sqrt(3);
            Ir = conj(Sr/(3*VrF));
            Ir_polar = abs(Ir);
            Ir_theta = angle(Ir)*180/pi;

            Ir_polar_amperagem = Ir_polar/num_cond;

            VsF = A * VrF + B * Ir;
            Vsf_polar = abs(VsF);
            Vsf_theta = angle(VsF)*180/pi;

            Is = C * VrF + D * Ir;
            Is_polar = abs(Is);
            Is_theta = angle(Is)*180/pi;
            
            Is_polar_amperagem = Is_polar/num_cond;

            % 4º) Cálculo das potências - barra emissora e receptora:
            Ss = 3*VsF*(conj(Is));
            Ss_polar = abs(Ss);
            Ss_theta = angle(Ss)*180/pi;
            
            % Perdas de potência ativa na LT
            PLT = (real(Ss)) - (real(Sr));

            % Eficiência
            eficiencia = Sr/(Sr + PLT);

            % 5º) Cálculo dos custos em função das perdas estimadas,
            % tipo de estrutura(nível de tensão) e do cabo escolhido:

            % Perdas em MWh, considerando período de análise de x anos            
            PLT = PLT*(1e-6); % Correção pois custo é em U.M./MWh            
            perdas = PLT * 24 * 30 * 12 * anos;
            custo = 7e-3;
            custo_perdas = perdas * custo;

            % Custo das torres de transmissão, de acordo com os dados fornecidos
            custo_torres = custo_km(x) * km;                 % U.M./km para a tensão
            custo_cabos = num_cond * custo_cabo_tabela * km;
            custo_total = custo_perdas + custo_torres + custo_cabos;

            VsL = VsF * sqrt(3);
            VsL_polar = abs(VsL);
            reg_tensao = abs(VsL/VrL);


            % EXPORTAR P/ TABELA
            %   Aplicação dos 3 critérios de viabilidade:
            if (((reg_tensao < reg_tensao_max) && (reg_tensao > reg_tensao_min)) && ...
                    (Vsf_theta < angulo_carga) && ...
                    (ampacidade > Ir_polar_amperagem) && ...
                    (ampacidade > Is_polar_amperagem))
                viavel = 1;
            else
                viavel = 0;
            end
            tabela_completa = table(nome_cabo, custo_cabo_tabela, diametro,...
                custo_total, custo_cabos, custo_torres,...
                custo_perdas, num_cond, VrL, VsL_polar, Vsf_theta, reg_tensao, ampacidade,...
                Is_polar_amperagem, Is_theta, Ir_polar_amperagem, Ir_theta, perdas,...
                eficiencia, Sr_real, Sr_imag, viavel);

            writetable(tabela_completa, "tabela_resultados_excel.xlsx", "Sheet", "tabela_completa", WriteMode="append", AutoFitWidth=false, UseExcel=false);
            fclose all;
        end
    end
end
end