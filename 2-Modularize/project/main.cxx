

#include <stdio.h>
#include "liba.h"
#include "libb.h"
#include "libc.hxx"


int main(void) 
{
    printf("hello world.\n");
#if DEBUG
    printf("warning: DEBUG is enabled\n");
#endif
    liba_foo();
    libb_bar();
    
    Foo obj;
    obj.do_something();

    printf("1 + 2 = %d\n", liba_add(1,2));
    
    return 0;
}
