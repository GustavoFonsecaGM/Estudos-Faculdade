function Gaussiana()
  clc;

  matrizA= [3,    2,    0;
            3,    2,    1;
            2,    1,    3;];
   matrizB = [13;13;9];
   matrizinicial = pivotamentoParcial(matrizA,matrizB)
   matriz = gauss(matrizinicial)
   Raizes = substituicaoRegressiva(matriz)

   [qtdlinha, qtdcoluna] = size(matrizA);

   for i = 1:qtdcoluna
     fprintf("a Raiz de x(%d) = %d \n",i,Raizes(i))
   endfor



endfunction

function matrizinicial = pivotamentoParcial(matrizA,matrizB)

      [qtdlinha, qtdcoluna] = size(matrizA);
      matrizinicial = [matrizA matrizB];
      correcao = 0;

      for pivo = 1:qtdlinha-1
          coluna = matrizinicial(pivo:end,pivo)
          [maiorValor,indiceMaiorValor] = max(coluna)
          indiceNaMatriz = indiceMaiorValor + correcao
          auxiliar = matrizinicial(pivo,:)
          matrizinicial(pivo,:) = matrizinicial(indiceNaMatriz,:)
          matrizinicial(indiceNaMatriz,:) = auxiliar
          correcao = correcao + 1
      endfor

endfunction

function matriz = gauss(matrizinicial)

    [qtdlinha,qtdcoluna] = size(matriz);

    for coluna = 1:qtdlinha-1
      for linha = coluna+1:qtdlinha
        fator = matriz(linha,coluna) / matriz(coluna,coluna)
        matriz(linha,:) = matriz(linha,:)-(fator*matriz(coluna,:))
      endfor
    endfor

endfunction


function Raizes = substituicaoRegressiva(matriz)

    [qtdlinha,qtdcoluna] = size(matriz);
    Raizes = zeros (qtdlinha,1);

    for linha = qtdlinha:-1:1
      Raizes(linha,1) = ( matriz(linha,end) - sum(matriz(linha,linha+1:end-1))) / matriz(linha,linha);
      matriz(:,linha) = matriz(:,linha)*Raizes(linha,1);
    endfor

endfunction








