function Regressao()
    clc;

    x = [4; 8; 12; 16; 20; 24];
    y = [1590; 1320; 1000; 900; 650; 560];
    graus = [1; 2; 5];
    x_estimado = 14;

    for grau = graus'
        coeficientes = regressao(x, y, grau);
        [r2, r] = calcularR(x, y, coeficientes);
        y_estimado = calcularY(coeficientes, x_estimado);



       fprintf('\nPolinômio de grau %d:\n', grau);
        fprintf('Polinômio ajustado: ');
        imprimir_polinomio(coeficientes);
        fprintf('\nEstimativa em x=%d: %.6f\n', x_estimado, y_estimado);
        fprintf('R²: %.6f\n', r2);
        fprintf('R : %.6f\n\n', r);

        plotagrafico(x, y, coeficientes, grau, x_estimado, y_estimado);
    end
end

function coeficientes = regressao(x, y, grau)
    M = zeros(grau+1, grau+1);
    b = zeros(grau+1, 1);

    for i = 0:grau
        for j = 0:grau
            M(i+1, j+1) = sum( x.^(i+j) );
        end
        b(i+1) = sum( y .* (x.^i) );
    end

    coeficientes = M\b;
end

function [r2, r] = calcularR(x, y, coeficientes)
    y_estimado = calcularY(coeficientes, x);
    media_y   = mean(y);

    SST = sum((y - media_y).^2);
    SSE = sum((y - y_estimado).^2);

    r2 = 1 - (SSE / SST);
    r = sqrt(r2);
end

function y_estimado = calcularY(coeficientes, x_estimado)
    y_estimado = zeros(size(x_estimado));
    for i = 1:length(coeficientes)
        expoente = i - 1;
        y_estimado = y_estimado + coeficientes(i) * (x_estimado.^expoente);
    end
end

function imprimir_polinomio(coeficientes)

    for i = 1:length(coeficientes)
        termo = i - 1;
        if termo == 0
            fprintf('%.6f', coeficientes(i));
        elseif termo == 1
            fprintf(' + %.6f x', coeficientes(i));
        else
            fprintf(' + %.6f x^%d', coeficientes(i), termo);
        end
    end
end

function plotagrafico(x, y, coeficientes, grau, x_estimado, y_estimado)
    x_grafico = min(x):0.1:max(x);
    y_grafico = calcularY(coeficientes, x_grafico);

    figure;

    plot(x_grafico, y_grafico, 'b-', 'LineWidth', 2, 'DisplayName',sprintf('Polinômio Grau %d', grau));
    hold on;


    plot(x, y, 'ro', 'MarkerSize', 8, 'LineWidth', 2,'DisplayName', 'Dados Originais');

    plot(x_estimado, y_estimado, 's', 'MarkerSize', 10, 'MarkerFaceColor', 'g','DisplayName', sprintf('Estimativa (x=%d)', x_estimado));

    xlabel('Tempo (horas)');
    ylabel('UFC/100 mL');
    title(sprintf('Ajuste Polinomial (Grau %d)', grau));
    legend('Location', 'northeast');
    grid on;
    hold off;
end

