function bits=fracdectobin(N)
%Dado (na base 10) um número N, fracionário, dá a representação na base
%binária
bits=[];  % inicializa (vazio) o vetor de bits      
while N~=0
    prod=2*N;% multiplicação de m por 2
    partint=floor(prod);
    bits=[bits, partint]; 
    N=prod-partint;
end

