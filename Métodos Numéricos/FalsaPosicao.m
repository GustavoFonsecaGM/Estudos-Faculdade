function FalsaPosicao()
  clc;
  xl = 0;
  xu = 1;
  max_iter =1000;
  tol = 1e-5;
  [xr, contagem, vetorxr, vetorfxr] = metodoFalsaPosicao(xl,xu,max_iter,tol);

  for i = 1:contagem
    fprintf('iteracao %d:\n', i);
    fprintf('xr: %.6f\n',vetorxr(i));
    fprintf('fxr: %.6f\n\n',vetorfxr(i));
  endfor

  fprintf("------------------------------\n");
  fprintf("raiz encontrada: %.6f\n", xr);
  fprintf('Numero de iteracoes: %d\n', contagem);
  fprintf("------------------------------");

  fig1 = figure;
  set(fig1, 'Position', [300, 200, 600, 600]);
  plotagraficoconvergencia(vetorxr,vetorfxr,xl,xu,contagem)
  fig2 = figure;
  set(fig2, 'Position', [900, 200, 600, 600]);
  plotagraficoanimado(xl,xu,vetorxr,vetorfxr,contagem)

end

function [xr,contagem,vetorxr,vetorfxr] = metodoFalsaPosicao(xl,xu,max_iter,tol)
  x0 = inf;
  vetorxr = zeros(max_iter,1);
  vetorfxr = zeros(max_iter,1);

  for contagem = 1:max_iter
    fxl = funcao(xl);
    fxu = funcao(xu);
    xr = xu-((fxu*(xl - xu))/(fxl-fxu));
    fxr = funcao(xr);

    vetorxr(contagem) = xr;
    vetorfxr(contagem) = fxr;


    if fxl*fxr >0
      xl=xr;
    else
      xu=xr;
    end

   if abs(x0-xr) <= tol
     break;
    endif
    x0 = xr;


  endfor
  vetorxr = vetorxr(1:contagem);
  vetorfxr = vetorfxr(1:contagem);

endfunction

function y = funcao(x)
   y = x.^3 + 2.*x.^2 - 2;
 endfunction

function plotagraficoanimado(xl,xu,vetorxr,vetorfxr,contagem)
    intX = xl:0.1:xu;
    intY = funcao(intX);

    for i = 1:contagem
      plot(intX,intY,"linewidth",2);
      hold on;

      plot(vetorxr(i), vetorfxr(i), 'o', "linewidth", 2, "markersize", 10, "color", [1 0 0]);
      text(vetorxr(i), vetorfxr(i), sprintf('x = %0.6f', vetorxr(i)), "fontsize", 12, "color", [0.5 0 0]);

      set(gca,"fontsize",20);
      title(sprintf("Método da Falsa Posição - Iteração: %i \n F(x) = x^3+2x^2-2", i));
      ylabel("f(x)");
      xlabel("x");
      legend("Função f(x)", "Raiz de x", "location", "northeast");
      grid on;
      hold off;
      pause(0.75);
    endfor
    hold on;
end


function plotagraficoconvergencia(vetorxr,vetorfxr,xl,xu,contagem)
  numIteracoes = size(vetorxr,1);

  subplot(211);
  plot(1:numIteracoes, vetorxr, '-o', 'linewidth', 2, 'color', [0 0 1], 'MarkerSize', 6);
  legend('Convergência de x', "location", "southeast");
  grid on;
  set(gca,'fontsize',25);
  title('Convergência de x', 'fontsize', 25);
  xlabel('Iteração', 'fontsize', 20);
  ylabel('x', 'fontsize', 20);
  xlim([1 contagem]);
  ylim([xl xu]);

  subplot(212);
  plot(1:numIteracoes, vetorfxr, 'linewidth', 2, 'color', [1 0 0]);
  legend('Convergência de f(x)', "location", "southeast");
  grid on;
  set(gca, 'fontsize', 20);
  title('Convergência de f(x)', 'fontsize', 25);
  xlabel('Iteração', 'fontsize', 20);
  ylabel('f(x)', 'fontsize', 20);
  xlim([1 contagem]);

endfunction


