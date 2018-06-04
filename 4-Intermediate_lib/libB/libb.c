
#include <stdio.h>
#include "liba.h"
#include "common_filename.h"

void libb_bar(void)
{
    printf("from libb_bar.\n");
    common_function_name(123);
}

