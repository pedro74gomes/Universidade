import re

inscritos = open("inscritos.txt")

for linha in inscritos:
  x = re.match(r'(?i:Paulo)', linha)
  y = re.match(r'(?i:Ricardo)', linha)
  num = re.search(r'91[0-9]{7}', linha) #consideramos Vodafone os números que começam em 91
  prova = re.search(r'(([0-9]{2}\/*){3})((?i:[\t ]|[A-z])+)', linha) # procuramos as datas e o texto seguinte que corresponde a provas
  if((x or y) and num and prova):
    print(num.group(),prova.group(3)) # dividimos em groups e escolhemos o group das provas