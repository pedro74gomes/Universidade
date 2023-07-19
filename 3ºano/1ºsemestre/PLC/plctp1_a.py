import re

inscritos = open("inscritos.txt")

min = 6 #5o inscrito = 6o index #porque não contamos as (duas) linhas que não têem info relativa aos inscritos 
max = 16                        #e tendo em conta que index começa em 0

for i, linha in enumerate(inscritos):
  if (i in range(min, max+1)):
    x = re.match(r'[^@]+@[^\t]+', linha) #[^@]+ -> inicio até @         #@[^\t]+ -> @ até \t
    if(x):
      print(x.group())