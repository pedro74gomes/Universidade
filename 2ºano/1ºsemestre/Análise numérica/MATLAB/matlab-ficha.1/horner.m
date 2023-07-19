function [px] = horner(a,x)
%Input: a, vetor dos coeficientes de um polinomio por ordem decrescente 
%dos graus, x ponto onde se quer calcular o polinómio
%Output: valor px
%Método implementado: algoritmo de horner
n=length(a)-1;
px = a(1);
for i=2:n+1
    px=px*x+a(i);
end

end