    .syntax unified
    
    
    .global liba_add
    
    @ equivalent to following C code
    @ unsigned liba_add(unsigned r0, unsigned r1) { return r0+r1; }
liba_add:
    add r0, r0, r1
    bx  lr
    
