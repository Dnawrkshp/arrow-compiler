%{
#include <stdio.h>
#include "arrow.y.h"

%}

%%

[0-9]+          { return atof(yytext); }

%%
