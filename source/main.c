#include "arrow.y.h"

extern int yyparse();

int main(void) {

    yyparse();
    return 1;
}
