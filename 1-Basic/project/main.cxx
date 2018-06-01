

#include <stdio.h>
#include "liba.h"
#include "libb.h"
#include "libc.hxx"


int main(void) 
{
    printf("hello world.\n");
    liba_foo();
    libb_bar();
    
    Foo obj;
    obj.do_something();

    printf("1 + 2 = %d\n", asm_add(1,2));
    
    return 0;
}
