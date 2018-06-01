    .syntax unified
    
    
    .global asm_add
    
    @ equivalent to following C code
    @ unsigned asm_add(unsigned r0, unsigned r1) { return r0+r1; }
asm_add:
    add r0, r0, r1
    bx  lr
    
