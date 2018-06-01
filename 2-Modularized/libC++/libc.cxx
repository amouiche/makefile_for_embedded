
#include <stdio.h>
#include "libc.hxx"


Foo::Foo()
{
    puts("Foo::Foo()");
}

Foo::~Foo()
{
    puts("Foo::Foo()");
}


void Foo::do_something()
{
    puts("Foo::do_something()");
}
