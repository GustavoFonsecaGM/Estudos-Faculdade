function NewtonRaphson()
  clc
  x0 =[1; 1];
  tol =1e-5;
  max_iter =1000;

  [vetorraiz,vetorfuncao,contagem,x1] = newtonRaphson(x0,max_iter,tol);

  for i = 1:contagem
    fprintf('iteracao %d:\n', i);
    fprintf('raizes x e y : %.6f , %.6f\n',vetorraiz(i,1),vetorraiz(i,2));
    fprintf('f(x,y)       : %.6f , %.6f\n\n',vetorfuncao(i,1),vetorfuncao(i,2));
  endfor

  fprintf("------------------------------\n");
  fprintf("raiz x encontrada: %.6f\n", x1(1));
  fprintf("raiz y encontrada: %.6f\n", x1(2));
  fprintf('Numero de iteracoes: %d\n', contagem);
  fprintf("------------------------------");

  plotagraficoconvergencia(vetorfuncao,vetorraiz,contagem)
  plotagraficoanimado(vetorfuncao,vetorraiz)



endfunction


function [vetorraiz,vetorfuncao,contagem,x1] = newtonRaphson(x0,max_iter,tol)

  vetorraiz = zeros(max_iter,2);
  vetorfuncao = zeros(max_iter,2);

  for contagem = 1:max_iter

    J = derivadafuncao(x0);
    x1 = x0 - inv(J)*funcao(x0);

    vetorfuncao(contagem,:) = funcao(x0);
    vetorraiz(contagem,:) = x1;

    if abs(x1-x0)<=tol
      break;
    endif

    x0 = x1;

  endfor

  vetorfuncao = vetorfuncao(1:contagem,:);
  vetorraiz = vetorraiz(1:contagem,:);


endfunction


function y = funcao(x)
  x1 = x(1);
  x2 = x(2);
  y = [ x1 + x2 - sqrt(x2) - 0.25;
        8.* x1.^2 + 16.* x2 - 8.*x1.* x2 - 10];

endfunction


function J = derivadafuncao(x)
  x1 = x(1);
  x2 = x(2);

  J = [       1         ,   1 - 1./ (2.* sqrt(x2));
       16.* x1- 8.*x2 ,   16 - 8.* x1];
endfunction


function plotagraficoconvergencia(vetorfuncao,vetorraiz,contagem)
  fig1 = figure;
  set(fig1, 'Position', [200, 200, 600, 600]);

  subplot(211)
  plot(1:contagem,vetorraiz(1:contagem,1), '-o', 'linewidth', 2, 'color', [0 0 1], 'MarkerSize', 6);
  hold on;
  plot(1:contagem,vetorraiz(1:contagem,2), '-o', 'linewidth', 2, 'color', [1 0 0], 'MarkerSize', 6);
  legend('Convergencia de x', 'convergencia de y');
  grid on;
  set(gca,'fontsize',20);
  title('Convergencia de x e y', 'fontsize', 20);
  xlabel('Iteração', 'fontsize', 20);
  ylabel('Raiz', 'fontsize', 20);

  subplot(212)
  plot(1:contagem,vetorfuncao(1:contagem,1), '-o', 'linewidth', 2, 'color', [0 0 1], 'MarkerSize', 6);
  hold on;
  plot(1:contagem,vetorfuncao(1:contagem,2), '-o', 'linewidth', 2, 'color', [1 0 0], 'MarkerSize', 6);
  legend('Convergencia de f1(x,y)', 'convergencia de f2(x,y)');
  grid on;
  set(gca,'fontsize',20);
  title('Convergencia de f(x,y)', 'fontsize', 20);
  xlabel('Iteracao', 'fontsize', 20);
  ylabel('Y', 'fontsize', 20);

endfunction


function plotagraficoanimado(vetorfuncao,vetorraiz)
  fig2 = figure;
  set(fig2, 'Position', [800, 100, 900, 900]);

  eixox = 0:0.1:2;
  eixoy = eixox;

  eixoz = zeros(numel(eixox), numel(eixoy), 2);
  for i = 1:numel(eixox)
    for j = 1:numel(eixoy)
      parametroEntrada = [eixox(i),eixoy(j)];
      eixoz(i,j,1:2) = funcao(parametroEntrada);
    endfor
  endfor

  numIter = size(vetorraiz,1);
  for i = 1:numIter

    subplot(211)

    surf(eixox,eixoy,eixoz(:,:,1));
    hold on;
    plot3(vetorraiz(1:i,1),vetorraiz(1:i,2),vetorfuncao(1:i,1),"color","r","linewidth",2)
    plot3(vetorraiz(i,1),vetorraiz(i,2),vetorfuncao(i,1), 'o', 'markersize', 15, 'color', 'r', 'markerfacecolor', [1 1 1], 'linewidth', 2)
    hold off;
    set(gca,"fontsize",20);
    grid on;
    title(sprintf("Iteracao %i \n\n x + y - sqrt(y) - 0.25 = 0",i));
    legend('Funcao', 'Trajeto Raiz', 'Raiz');
    xlabel('x');
    ylabel('y');
    zlabel('z');


    subplot(212)
    surf(eixox,eixoy,eixoz(:,:,2));
    hold on;
    plot3(vetorraiz(1:i,1),vetorraiz(1:i,2),vetorfuncao(1:i,2),"color","r","linewidth",2)
    plot3(vetorraiz(i,1),vetorraiz(i,2),vetorfuncao(i,2), 'o', 'markersize', 15, 'color', 'r', 'markerfacecolor', [1 1 1], 'linewidth', 2)
    hold off;
    set(gca,"fontsize",20);
    grid on;
    title(sprintf("8x^2 + 16y - 8xy - 10 = 0"));
    legend('Funcao', 'Trajeto Raiz', 'Raiz');
    xlabel('x');
    ylabel('y');
    zlabel('z');
    pause(0.5);




endfor
endfunction









