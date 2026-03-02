function Gradiente_Newton()

	clc;
	x0= [ (4.5/5).*pi ;  (4.5/5).*pi  ];
	max_iter = 1000;
	tol = 1e-3;
  x = [pi;pi];

  metodo = 1;
  if metodo == 1
    a = 0.333;
    [vetorfuncao,vetorraiz,xr,contagem] = metodogradiente(x0,max_iter,tol,a);
  elseif metodo == 2
    a = 0.666;
    [vetorfuncao,vetorraiz,xr,contagem] = metodonewton(x0,max_iter,tol,a);

endif

  [r] = distanciaeuclidiana(x,xr);
  fprintf("x1 = %.6f  \nx2 = %.6f\n",xr(1),xr(2));
  fprintf("Iteracoes = %d\n",contagem);
  fprintf("Distancia euclidiana = %.6f\n",r);


  plotagraficoconvergencia(vetorfuncao,vetorraiz,contagem);
  plotagraficoanimado(vetorfuncao,vetorraiz)



endfunction

function [r] = distanciaeuclidiana(x,xr)
  r = sqrt((xr(1)-x(1))^2 + (xr(2)-x(2))^2);
endfunction

function [vetorfuncao,vetorraiz,xr,contagem] = metodogradiente(x0,max_iter,tol,a)

	vetorfuncao = zeros(max_iter,2);
	vetorraiz = zeros(max_iter,2);

	for contagem = 1:max_iter

		xr = x0 - a.*gradiente(x0);

		vetorfuncao(contagem,:) = funcao(x0);
		vetorraiz(contagem,:) = xr;

		if abs(xr-x0)<=tol
			break
		endif

		x0=xr;

	endfor

	vetorfuncao = vetorfuncao(1:contagem,:);
	vetorraiz = vetorraiz(1:contagem,:);

endfunction



function [vetorfuncao,vetorraiz,xr,contagem] = metodonewton(x0,max_iter,tol,a);

	vetorfuncao = zeros(max_iter,2);
	vetorraiz = zeros(max_iter,2);

	for contagem = 1:max_iter

		xr = x0 - a*inv(hessiana(x0))*gradiente(x0);

		vetorfuncao(contagem,:) = funcao(x0);
		vetorraiz(contagem,:) = xr;

		if abs(xr-x0)<=tol
			break
		endif

		x0=xr;

	endfor

	vetorfuncao = vetorfuncao(1:contagem,:);
	vetorraiz = vetorraiz(1:contagem,:);

endfunction



function y = funcao(x0)

  x1 = x0(1);
  x2 = x0(2);
  y = -cos(x1) .* cos(x2) .* exp(-((x1 - pi).^2 + (x2 - pi).^2));

endfunction



function g = gradiente(x0)

  x1 = x0(1);
  x2 = x0(2);

  g = [ exp(-((-pi + x1).^2 - (-pi + x2).^2)) .* cos(x2) .* (2 .* (-pi + x1) .* cos(x1) + sin(x1));
        exp(-((-pi + x1).^2 - (-pi + x2).^2)) .* cos(x1) .* (2 .* (-pi + x2) .* cos(x2) + sin(x2)) ];

endfunction



function h = hessiana(x0)
  x1 = x0(1);
  x2 = x0(2);

  h = [-exp(-(-pi + x1).^2 - (-pi + x2).^2) .* cos(x2) .*((-3 + 4 .* pi^2 - 8 .* pi .* x1 + 4 .* x1.^2) .* cos(x1) + 4 .* (-pi + x1) .* sin(x1))      ,     -exp(-(-pi + x1).^2 - (-pi + x2).^2) .*(-2 .* (-pi + x1) .* cos(x1) - sin(x1)) .*(-2 .* (-pi + x2) .* cos(x2) - sin(x2));
  -exp(-(-pi + x1).^2 - (-pi + x2).^2) .*(-2 .* (-pi + x1) .* cos(x1) - sin(x1)) .*(-2 .* (-pi + x2) .* cos(x2) - sin(x2))                       ,     -exp(-(-pi + x1).^2 - (-pi + x2).^2) .* cos(x1) .*((-3 + 4 .* pi^2 - 8 .* pi .* x2 + 4 .* x2.^2) .* cos(x2) + 4 .* (-pi + x2) .* sin(x2))];


endfunction


function plotagraficoconvergencia(vetorfuncao,vetorraiz,contagem)

  fig1 = figure;
  set(fig1, 'Position', [200, 200, 600, 600]);

  subplot(211)
  plot(1:contagem,vetorraiz(1:contagem,1));
  hold on;
  plot(1:contagem,vetorraiz(1:contagem,2));
  hold off;
  legend('Convergencia de x','Convergencia de y');
  title("Convergencia de xr");
  xlabel("iteracoes");
  ylabel("x1,x2");
  grid on;

  subplot(212)
  plot(1:contagem,vetorfuncao(1:contagem,1));
  hold on;
  plot(1:contagem,vetorfuncao(1:contagem,2));
  legend('Convergencia de x', 'convergencia de y');
  title("Convergencia de f(xr)");
  xlabel("iteracoes");
  ylabel("f(x1,x2)");
  grid on;

endfunction


function plotagraficoanimado(vetorfuncao,vetorraiz)
  fig2 = figure;
  set(fig2, 'Position', [800, 100, 900, 900]);

  eixox = -10:0.1:10;
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

    surf(eixox,eixoy,eixoz(:,:,1));
    hold on;
    plot3(vetorraiz(1:i,1),vetorraiz(1:i,2),vetorfuncao(1:i,1),"color","r","linewidth",2)
    plot3(vetorraiz(i,1),vetorraiz(i,2),vetorfuncao(i,1), 'o', 'markersize', 15, 'color', 'r', 'markerfacecolor', [1 1 1], 'linewidth', 2)
    hold off;
    set(gca,"fontsize",20);
    grid on;
    title(sprintf("Iteracao %i \n\n f(%.6f, %.6f) = %.6f",i,vetorraiz(i,1),vetorraiz(i,2),vetorraiz(i,1)));
    legend('Funcao', 'Trajeto Raiz', 'Raiz');
    xlabel('x1');
    ylabel('x2');
    zlabel('f(x1,x2)');

    pause(1);
endfor

endfunction
