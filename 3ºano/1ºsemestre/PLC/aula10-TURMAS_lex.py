import ply.lex as lex
import sys

tokens = (
    'TURMA',
    'ID',
    'DP',
    'ALUNO',
    'NOTAS',
    'PF',
    'VIRG',
    'NUM'

)

t_DP=r':'
t_PF=r'\.'
t_VIRG=r','

def t_TURMA(t):
    r'(?i:TURMA)'
    return t

def t_ALUNO(t):
    r'(?i:ALUNO)'
    return t

def t_NOTAS(t):
    r'(?i:NOTAS)'
    return t

def t_NUM(t):
    r'\d+'
    t.value=int(t.value)
    return t

def t_ID(t):
    #r'\w+'
    r'[a-zA-Z][a-zA-Z0-9_\-]'
    return t
    
t_ignore = ' \r\n\t'

def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)
 

lexer = lex.lex() # cria um AnaLex especifico a partir da especificação acima usando o gerador 'lex' do objeto 'lex'

# Reading input
#for linha in sys.stdin:
#    lexer.input(linha) 
#    tok = lexer.token()
#    while tok:
#        print(tok)
#        tok = lexer.token()

