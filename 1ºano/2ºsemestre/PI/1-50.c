#include <stdio.h>
#include <stdlib.h> 
#include <string.h>
#include <assert.h>
#include <ctype.h>

//4
// define a function that computes how many 1's are used in 
// the (binary) representation of a given (unsigned) integer.

int bitsUm (unsigned int x){
    int i, r=0;        
    for(i=x;i>0;i/=2){           
        if (i%2 == 1) r++;
    }    
    return r;  
}

//5
// a função  trailingZ  calcula o número de bits a 0  no final da 
// representação binária de um número (i.e., o expoente da maior 
// potência de 2 que é divisor desse número).

int trailingZ (unsigned int n) {
    int i, r=0;
    for(i=n; i>0; i/=2)
        if(i%2 == 0) r++;
    return r;
}

 /* 6
    Defina uma função int qDig (unsigned int n) 
    que calcula o número de dígitos necessários 
    para escrever o inteiro n em base decimal. 
    Por exemplo, qDig (440) deve retornar 3.
*/

int qDig (int n) {
    int i,r = 0, resto = 1;
    for(i = 1; resto != n; i*=10) {
        resto = n % i;
        if(resto != n)r++;
    }
    return r;
}

/*7
  Apresente uma definição da função pré-definida em C "char *strcat (char s1[], char s2[])"
  que concatena a string s2 a s1 (retornando o endereço da primeira).
*/

char *mystrcat(char s1[], char s2[]) {
    int i, j;
    for(i=0; s1[i]!='\0'; i++);
    for(j=0; s2[j]!='\0'; j++, i++)
        s1[i] = s2[j];
    s1[i] = '\0';
    return s1;
}

/*8
  Apresente uma definição da função pré-definida em C "char *strcpy (char *dest, char source[])"
  que copia a string source para dest retornando o valor desta última.
*/
char *mystrcpy(char *dest, char source[]) {
    int i, p;
    for(i = 0; source[i] != '\0'; i++){
        dest[i] = source[i];
    }   dest[i] = '\0';
    return dest;
}

/*9
  Apresente uma definição da função pré-definida em C "int strcmp (char s1[], char s2[])"
  que compara (lexicograficamente) duas strings. O resultado deverá ser:
   • 0, se as strings forem iguais;
   • <0, se s1<s2;
   • >0, se s1>s2.
*/
int mystrcmp(char s1[], char s2[]) {
    int i;
    for(i = 0; s1[i]!='\0' && s2[i]!='\0' && s1[i] == s2[i]; i++);
    return s1[i]-s2[i];
}

/*10 
  Apresente uma defini¸c˜ao da fun¸c˜ao pr´e-definida em C char *strstr (char s1[], char
  s2[]) que determina a posi¸c˜ao onde a string s2 ocorre em s1. A fun¸c˜ao dever´a retornar
  NULL caso s2 n˜ao ocorra em s1.
*/
char *mystrstr (char s1[], char s2[]) {
    char *res = NULL;
    int i,j;
    if (s2[0] == '\0') return s1;
    for(i = 0; s1[i]!='\0' && res == NULL; i++){
        for(j = 0; s2[j]!='\0' && s2[j] == s1[i+j]; j++);
        if(s2[j]=='\0') res = s1 + i;
    }
    return res;
}

/*11
  Defina uma função "void strrev (char s[])" que inverte uma string.
*/
void strrev (char s[]) {
    int i, N;
    char t;
    for(N=0; s[N]!='\0'; N++);
    for(i=0; i<N/2; i++){
        t = s[i];
        s[i] = s[N-i-1];
        s[N-i-1] = t;
    }
}

/*12
  Defina uma função void strnoV (char s[]) que 
  retira todas as vogais de uma string.
*/
void strnoV (char t[]){
    int i, j;
    for (i = 0, j = 0; t[i] != '\0';i++) {
        if (t[i] != 'a' &&
            t[i] != 'e' &&
            t[i] != 'i' &&
            t[i] != 'o' &&
            t[i] != 'u' &&
            t[i] != 'A' &&
            t[i] != 'E' &&
            t[i] != 'I' &&
            t[i] != 'O' &&
            t[i] != 'U') {
            t[j++] = t[i];
        }
    }
    t[j] = '\0';
}


/* 13
   Defina uma função 
   void truncW (char t[], int n) 
   que dado um texto t com várias palavras 
   (as palavras estão separadas por um ou 
   mais espaços) e um inteiro n, trunca 
   todas as palavras de forma a terem no 
   máximo n caracteres.
*/

void truncW(char t[], int n) {
    int i, adi, pos;
    for (i = 0, pos = 0, adi = 0; t[i] != '\0'; i++) {
        if (t[i] == ' ') {
            adi = 0;
            t[pos++] = ' ';
        } else if (adi < n) {
            t[pos++] = t[i];
            adi++;
        }
    }
    t[pos] = '\0';
}

/*14
  Defina uma função "char charMaisfreq (char s[])" que determina qual o
  caracter mais frequente numa string. A função deverá retornar 0 no caso
  de s ser a string vazia.
*/
char charMaisfreq (char s[]) {
    char r = '0';
    int i, j, n, f=0;
    if(s[0]=='\0')return r;
    for(i=0; s[i]!='\0'; i++){
        n=0;
        for(j=0; s[j]!='\0'; j++){
            if(s[j]==s[i])n++;
        }
        if(n >= f){
            f = n;
            r = s[i];
        }
    }
    return r;
}

/*15
  Defina uma função "int iguaisConsecutivos (char s[])" que, dada uma string s
  calcula o comprimento da maior sub-string com caracteres iguais. Por exemplo, 
  "iguaisConsecutivos ("aabcccaac")" deve dar como resultado 3, correspondendo
  à repetição "ccc".
*/
int iguaisConsecutivos(char s[]){
    int f=0, n=1, i=0;
    while(s[i]){
        while(s[i]==s[i+1]){
            n++;
            i++;
        }
        if(n >= f) f = n;
        n = 1;
        i++;
    }
    return f;
} 

/*16
  Defina uma função "int difConsecutivos (char s[])" que, dada uma string s
  calcula o comprimento da maior sub-string com caracteres diferentes. Por
  exemplo, "difConsecutivos ("aabcccaac")" deve dar como resultado 3,
  correspondendo à string "abc".
*/
int difConsecutivos (char s[]){
    int maior = 0, i = 0, count; 
    while(s[i]){
        count = 1;
        while(s[i] != s[i+1]){
            count++;
            i++;
        }
        if(count >= maior)
            maior = count;
        i++;
    }
    return maior;
}

/*17
  Defina uma função "int maiorPrefixo (char s1 [], char s2 [])" que calcula
  o comprimento do maior prefixo comum entre as duas strings.
*/
int maiorPrefixo (char s1 [], char s2 []) {
    int prefixo = 0;
    int i, j, p;
    for (i = 0, p = 0; s1[i] != '\0' && s2[i] != '\0'; i++, p = 0) {
        for (j = 0; s1[j] != '\0' && s2[j] != '\0' && s1[j] == s2[j]; j++) pre++;
        if (p > prefixo) prefixo = p;
    }
    return prefixo;
}

/*18
  Defina uma função "int maiorSufixo (char s1 [], char s2 [])" que calcula
  o compri- mento do maior sufixo comum entre as duas strings.
*/
int maiorSufixo (char s1 [], char s2 []) {
    int n1 = strlen(s1)-1, n2 = strlen(s2)-1, n=0;
    while(n1>=0 && n2>=0){
        if(s1[n1] == s2[n2]){
            n++;
            n1--;
            n2--;
        }
    }
    return n;
}
