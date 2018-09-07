%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();

void yyerror(char *msg);
%}


%union {
    float f;
}

%token <f> NUM

%%

S : NUM
  ;

%%

void yyerror(char *msg) {
    fprintf(stderr, "%s\n", msg);
    exit(1);
}
