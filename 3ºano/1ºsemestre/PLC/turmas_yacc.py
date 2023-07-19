
# desenvolver um parser e um analisador lexico para a DSL Turmas que permite escrever frases
##  TURMA idturma:
##    ALUNO nome NOTAS 1,2,3.
##    ALUNO nome NOTAS 12, 13, 14, 15, 16.

import ply.yacc as yacc
import sys

from turmas_lex import tokens

## incio da GIC

def p_lisp_grammar(p):
    """
       Turmas : Cabec Alunos
       Cabec  : TURMA ID DP
       Alunos : Aluno
       Alunos : Alunos Aluno
       Aluno  : ALUNO ID NOTAS LstN PF
       LstN   : NUM
       LstN   : LstN VIRG NUM
    """

def p_error(p):
    parser.success = False
    print('Syntax error!')

###inicio do parsing
parser = yacc.yacc()
parser.success = True

fonte = ""
for linha in sys.stdin:
    fonte += linha

parser.parse(fonte)
if parser.success:
   print('Parsing completed!')
