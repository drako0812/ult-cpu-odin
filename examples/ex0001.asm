#include "../lib/ult_cpu.asm"

#d32 start
#d16 0x0000
#d32 start

start:
    mov AB, 0
.loop1:
    inc AB
    cmp AB, 100
    cjp LT, .loop1

    mov [0xDEADBEEF], 0
.loop2:
    inc [0xDEADBEEF]
    cmp [0xDEADBEEF], 100
    cjp LT, .loop2

    mov AB, 0xDEADBEEF
    mov [0x1000+AB], 0
.loop3:
    inc [0x1000+AB]
    cmp [0x1000+AB], 100
    cjp LT, .loop3

    jmp start

