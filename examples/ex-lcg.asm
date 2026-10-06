#include "../lib/ult_cpu.asm"

#d32 start
#d16 0x0000
#d32 start

; Based off of https://gist.github.com/dinosaurfiles-zz/de57c0d64414cca7562a
; Not 1:1 though

start:
    jmp start

cdq:
    psh AB
    and AB, 0x80000000
    cmp AB, 0
    cjp Z, .zero
    mov GH, 0xFFFFFFFF
    jmp .end

    .zero:
        mov GH, 0
        
    .end:
        pek AB
        pop
        ret

rng:
    mov AB, [8+SF]
    mov GH, [12+SF]
    mls XY, AB, GH
    mov GH, [16+SF]
    add AB, GH
    mov EF, [20+SF]
    
    cal cdq

    drs GH, AB, EF ; Hoping this is equivalent to idiv
    mov AB, GH
    cmp AB, 0
    cjp GT, .pos
    
    ; Rough implementation of neg
    mov IJ, 0
    sub IJ, AB
    mov AB, IJ

    .pos:
        mov [8+SF], AB
    
    ret
