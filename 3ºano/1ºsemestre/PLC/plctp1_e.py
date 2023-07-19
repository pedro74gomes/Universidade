import re
import json

inscritos = open("inscritos.txt", encoding = "utf8")

registo = {}
min = 2
max = 21
cats = []   
listaregs = []
for i, linha in enumerate(inscritos):
  new_line = re.sub(r'\n', '\t\n', linha) #separar o \n da informação final

  if i==1:
    cats = new_line.split('\t')
    cats.remove('\n') #remover \n das categorias

  if i in range(min, max+1):
    lista = re.split(r'\t', new_line)
  
    for k in range(len(cats)):
      registo[cats[k]] = lista[k]

    newd = {}
    for key,value in registo.items():         #retirar informação repetida
      if value not in newd.values():
        newd[key] = value

    listaregs.append(newd.copy())


with open('output.json','w') as file:
    file.write(json.dumps(listaregs))

with open('output.json','r') as file:
    res = json.load(file)

print(json.dumps(res, indent=4, sort_keys=False))