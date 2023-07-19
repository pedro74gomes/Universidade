import re

inscritos = open("inscritos.txt")

for linha in inscritos:
  x = re.search(r'(?:Individual)', linha)
  y = re.search(r'(?:Valongo)', linha)
  nome = re.match(r'[^\t]+', linha) #[^\t]+ -> inicio até \t
  if(x and y and nome):
    print(nome.group())