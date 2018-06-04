
#include <stdio.h>
#include "liba.h"
#include "common_filename.h"




void liba_foo(void)
{
    printf("from liba_foo.\n");
    common_function_name();
}



#if !LIBA_BUILD_ASM
#warning "liba_add() C implementation"
unsigned liba_add(unsigned a, unsigned b)
{
    return a+b;
}
#endif
