% Função principal
function Simpson()
    clc;
    a = 0;
    b = 1;
    tol = 1e-6;
    Valores_N = [3,6,8];
    #f = @(x) x.^3 - 3.*x.^2 + 2;
     f = @(x) x.^7 - 2.*x.^2 - 1;
    integral_exata = integral(f,a,b);
    fprintf("Integral exata = %d \n\n",integral_exata);


  for i = 1:length(Valores_N)
        N = Valores_N(i);

        if mod(N,3)!=0
          fprintf("N = %d nao multiplo de 3 \n",N);
        endif

        Integral_aproximada = simpson38(a, b, N);
        fprintf('Integral aproximada de N: %d == %.6f\n\n', N, Integral_aproximada);
    end

    [segmentonecessario,Integral_aproximada] = calculasegmentonecessario(integral_exata, a, b,1);
    fprintf("Segmentos necessarios para atigir \nprecisao de 6 casas decimais = %d\n\n", segmentonecessario);
    fprintf("Integral aproximada de N: %d == %.6f\n", segmentonecessario,Integral_aproximada);
endfunction




function y = funcao(x)
  #y = x.^3 - 3.*x.^2 + 2;
  y =  x.^7 - 2.*x.^2 - 1;

endfunction

function Integral_aproximada = simpson38(a, b, N)
    h = (b - a) / N;
    s = a:h:b;

    # Trapezio
    #Integral_aproximada = (b - a) .* (funcao(s(1)) + 2.*sum(funcao(s(2:N))) + funcao(s(end))) / (2.*N);

    # 1/3 SIMPSONS
    #Integral_aproximada = (b - a) .* (funcao(s(1)) + 4.*sum(funcao(s(2:2:N))) + 2.*sum(funcao(s(3:2:N-1))) + funcao(s(end))) / (3.*N);

    # 3/8 Simpsons
   Integral_aproximada = 3 .* (b - a) .* (funcao(s(1)) + 3.*sum(funcao(s(2:3:N-1))) + 3.*sum(funcao(s(3:3:N))) + 2.*sum(funcao(s(4:3:N-2))) + funcao(s(end)))/ (8 .* N);

end

function [segmentonecessario,Integral_aproximada] = calculasegmentonecessario(integral_exata, a, b,N)
  while true
     Integral_aproximada = simpson38(a, b, N);
     if abs(Integral_aproximada - integral_exata) <=1e-6
       segmentonecessario = N;
       break;
     endif
     N = N +1;
  endwhile
endfunction

