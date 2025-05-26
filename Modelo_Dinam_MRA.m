%% SIMULACION MODELO MASA-RESORTE-AMORTIGUADOR
%% CRECIMIENTO POBLACIONAL EN ITALIA (2019-2023)

%% 1. DATOS REALES DE ITALIA
% Datos de poblacion de los ultimos anos (en millones)
annos = [2019, 2020, 2021, 2022, 2023];
P_real = [58.997, 59.236, 59.030, 59.817, 59.641];

%% 2. PARAMETROS DEL MODELO LOGISTICO
% Analogias: Masa ↔ Poblacion, Resorte ↔ Crecimiento, Amortiguador ↔ Limite
P0 = P_real(1);        % Poblacion al inicio (2019), como si fuera la masa que arranca moviendose
K = 58.27;             % Capacidad maxima que puede sostener el sistema, seria como el freno o tope
r = -0.002;            % Tasa de crecimiento, vendria a ser la fuerza del resorte

%% 3. MODELO MATEMATICO LOGISTICO
% P(t) = K / [1 + ((K-P0)/P0) * exp(-r*t)]
% Algo parecido a: x(t) = A*exp(-bt) + equilibrio

% Funcion del modelo logístico
logistic_model = @(t) K ./ (1 + ((K - P0) / P0) * exp(-r * t));

%% 4. SIMULACION EN EL TIEMPO
t_historico = 0:4;                    % Tiempo para datos reales (2019 a 2023)
t_prediccion = 0:0.1:15;              % Simulacion extendida por 15 anos
P_simulado_hist = logistic_model(t_historico);
P_simulado_pred = logistic_model(t_prediccion);

%% 5. CALCULO DE ERRORES
error_abs = abs(P_simulado_hist - P_real);
error_rel = (error_abs ./ P_real) * 100;

%% 6. GRAFICA
figure('Position', [100, 100, 1000, 600]);

% Colores para cada linea
color_real = [0.8500, 0.3250, 0.0980];      % Rojo anaranjado
color_modelo = [0, 0.4470, 0.7410];         % Azul
color_pred = [0.4660, 0.6740, 0.1880];      % Verde

% Arrancamos el grafico
hold on;

% Modelo completo (historico + futuro)
annos_completos = 2019:0.1:2034;
plot(annos_completos, P_simulado_pred, '-', 'Color', color_modelo, ...
     'LineWidth', 2, 'DisplayName', 'Modelo Logistico');

% Puntos reales
plot(annos, P_real, 'o-', 'Color', color_real, 'MarkerSize', 10, ...
     'MarkerFaceColor', color_real, 'LineWidth', 3, ...
     'DisplayName', 'Datos Reales Italia');

% Parte de prediccion (2024 en adelante)
annos_futuros = 2024:0.1:2034;
P_futuros = logistic_model(5:0.1:15);
plot(annos_futuros, P_futuros, '--', 'Color', color_pred, ...
     'LineWidth', 2, 'DisplayName', 'Prediccion 2024-2034');

%% 7. ESTILO DE LA GRAFICA
title('Modelo Logistico Ajustado: Italia 2019-2023 y Prediccion 2024-2034 (15 anos)', ...
      'FontSize', 14, 'FontWeight', 'bold');
xlabel('Ano', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Poblacion (millones)', 'FontSize', 12, 'FontWeight', 'bold');

xlim([2019, 2034]);
ylim([58.0, 60.5]);
grid on;
grid minor;
set(gca, 'GridAlpha', 0.3, 'MinorGridAlpha', 0.1);

legend('Location', 'northeast', 'FontSize', 11, 'Box', 'on');

% Linea que marca hasta donde hay datos reales
line([2023.5, 2023.5], ylim, 'Color', [0.5, 0.5, 0.5], ...
     'LineStyle', ':', 'LineWidth', 1.5);

% Etiqueta la parte de prediccion
text(2029, 59.8, 'Prediccion 15 anos', 'FontSize', 10, ...
     'HorizontalAlignment', 'center', 'Color', color_pred);

hold off;

%% 8. TABLA DE RESULTADOS
fprintf('\n=== RESULTADOS DEL MODELO POBLACIONAL ITALIA ===\n');
fprintf('Analogía: Sistema Masa-Resorte-Amortiguador\n\n');

fprintf('PARAMETROS DEL MODELO:\n');
fprintf('• K (Capacidad de carga): %.3f millones\n', K);
fprintf('• r (Tasa de crecimiento): %.6f\n', r);
fprintf('• P₀ (Poblacion inicial): %.3f millones\n\n', P0);

fprintf('COMPARACION DATOS REALES vs MODELO:\n');
fprintf('Ano\t\tReal\t\tModelo\t\tError Abs\tError Rel(%%)\n');
fprintf('--------------------------------------------------------\n');
for i = 1:length(annos)
    fprintf('%d\t\t%.3f\t\t%.3f\t\t%.3f\t\t%.2f%%\n', ...
            annos(i), P_real(i), P_simulado_hist(i), ...
            error_abs(i), error_rel(i));
end

% Predicciones futuras
P_2024 = logistic_model(5);
P_2029 = logistic_model(10);
P_2034 = logistic_model(15);
fprintf('\nPREDICCIONES FUTURAS:\n');
fprintf('• 2024: %.3f millones\n', P_2024);
fprintf('• 2029: %.3f millones\n', P_2029);
fprintf('• 2034: %.3f millones\n', P_2034);

%% 9. DATOS SIMULADOS A 15 ANOS
fprintf('\n=== DATOS SIMULADOS COMPLETOS (2019-2034) ===\n');
fprintf('Ano\t\tPoblacion Simulada\tTasa Cambio (%%)\n');
fprintf('-------------------------------------------------------\n');

annos_simulacion = 2019:2034;
t_simulacion = 0:15;
P_simulacion_anual = logistic_model(t_simulacion);

for i = 1:length(annos_simulacion)
    if i == 1
        tasa_cambio = 0;
    else
        tasa_cambio = ((P_simulacion_anual(i) - P_simulacion_anual(i-1)) / P_simulacion_anual(i-1)) * 100;
    end
    fprintf('%d\t\t%.3f\t\t\t%.3f%%\n', annos_simulacion(i), P_simulacion_anual(i), tasa_cambio);
end

%% 10. INTERPRETACION DEL MODELO COMO SISTEMA FISICO
fprintf('\n=== INTERPRETACION FISICA DEL MODELO ===\n');
fprintf('ANALOGIA MASA-RESORTE-AMORTIGUADOR:\n\n');

fprintf('🏋️  MASA (m) ↔ POBLACION (P):\n');
fprintf('   • Representa el estado actual del sistema\n');
fprintf('   • Es la variable que va cambiando en el tiempo\n\n');

fprintf('🌱 RESORTE (k) ↔ TASA DE CRECIMIENTO (r):\n');
fprintf('   • Fuerza que empuja al sistema de vuelta al equilibrio: r = %.6f\n', r);
fprintf('   • Tendencia: %s\n', iff(r > 0, 'Crecimiento', 'Decrecimiento'));
fprintf('   • Hace que el sistema no se descontrole\n\n');

fprintf('🛑 AMORTIGUADOR (b) ↔ CAPACIDAD DE CARGA (K):\n');
fprintf('   • Marca el limite: K = %.2f millones\n', K);
fprintf('   • Frena el crecimiento exagerado\n');
fprintf('   • Hace que el sistema se estabilice\n\n');

%% 11. ECUACION DEL MODELO
fprintf('ECUACION DIFERENCIAL:\n');
fprintf('dP/dt = rP(1 - P/K)\n\n');
fprintf('SOLUCION:\n');
fprintf('P(t) = K / [1 + ((K-P₀)/P₀) × e^(-rt)]\n\n');

%% FUNCION PARA CONDICION TERNARIA
function result = iff(condition, true_value, false_value)
    if condition
        result = true_value;
    else
        result = false_value;
    end
end

%% 12. GRAFICA ADICIONAL: TASA DE CAMBIO
figure('Position', [150, 150, 800, 400]);

dPdt = @(t) r * logistic_model(t) .* (1 - logistic_model(t)/K);
t_cambio = 0:0.1:15;
tasa_cambio = dPdt(t_cambio);
annos_cambio = 2019:0.1:2034;

plot(annos_cambio, tasa_cambio, 'r-', 'LineWidth', 2);
title('Tasa de Cambio Poblacional: dP/dt (15 anos)', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('Ano', 'FontSize', 12);
ylabel('Tasa de Cambio (millones/ano)', 'FontSize', 12);
grid on;
xlim([2019, 2034]);

line(xlim, [0, 0], 'Color', 'k', 'LineStyle', '--', 'LineWidth', 1);
text(2027, max(tasa_cambio)*0.5, 'Equilibrio: dP/dt = 0', ...
     'FontSize', 10, 'HorizontalAlignment', 'center');

%% 13. ANALISIS DE TENDENCIAS A 15 ANOS
fprintf('\n=== ANALISIS DE TENDENCIAS A 15 ANOS ===\n');
variacion_total = P_2034 - P_real(1);
variacion_porcentual = (variacion_total / P_real(1)) * 100;

fprintf('CAMBIO TOTAL (2019-2034):\n');
fprintf('• Diferencia absoluta: %.3f millones\n', variacion_total);
fprintf('• Diferencia porcentual: %.2f%%\n', variacion_porcentual);
fprintf('• Tendencia general: %s poblacional\n', iff(variacion_total > 0, 'Crecimiento', 'Decrecimiento'));

fprintf('\nANALISIS POR QUINQUENIOS:\n');
fprintf('• 2019-2024: %.3f → %.3f (%.2f%% cambio)\n', P_real(1), P_2024, ((P_2024-P_real(1))/P_real(1))*100);
fprintf('• 2024-2029: %.3f → %.3f (%.2f%% cambio)\n', P_2024, P_2029, ((P_2029-P_2024)/P_2024)*100);
fprintf('• 2029-2034: %.3f → %.3f (%.2f%% cambio)\n', P_2029, P_2034, ((P_2034-P_2029)/P_2029)*100);

fprintf('\nCONCLUSION DEL MODELO A 15 ANOS:\n');
fprintf('La poblacion italiana tiende a estabilizarse cerca de %.2f millones\n', K);
fprintf('igual que una masa en un resorte que encuentra su punto de equilibrio.\n');

%% FIN

