
#include <stdio.h>
#include "liba.h"

void liba_foo(void)
{
    printf("from liba_foo.\n");
}



#if !LIBA_BUILD_ASM
#warning "liba_add() C implementation"
unsigned liba_add(unsigned a, unsigned b)
{
    return a+b;
}
#endif
