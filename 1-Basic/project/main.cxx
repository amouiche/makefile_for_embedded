

#include <stdio.h>
#include "liba.h"
#include "libb.h"


int main(void) 
{
    printf("hello world.\n");
    liba_foo();
    libb_bar();
    
    printf("1 + 2 = %d\n", asm_add(1,2));
    
    return 0;
}
