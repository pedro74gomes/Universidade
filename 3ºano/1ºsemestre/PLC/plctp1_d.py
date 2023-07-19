"""d) imprimir os 20 primeiros registos com os nomes convertidos para minúsculas."""

import re

inscritos = open("inscritos.txt")

min = 2
max = 21   

for i, linha in enumerate(inscritos):
  if(i in range(min, max+1)):
    new_line = re.sub(r'\n', '\t\n', linha) #separar o \n da informação final
    lista = re.split(r'\t', new_line)
    lista = list(dict.fromkeys(lista)) #remover informação repetida
    x = '\t'.join(lista)
    x = re.match(r'([^\t]+)(.+)', x)
    if(x):
      print(x.group(1).lower(), x.group(2))