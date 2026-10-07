#include "../lib/ult_cpu.asm"

#d32 start
#d16 0x0000
#d32 start

DBG_OUT_ADDR = 0x600000
DBG_OUT_BYTES = 256

IO_WAIT_PORT = 0x100
IO_WAIT_TIME0 = 0x101
IO_WAIT_TIME1 = 0x102
IO_WAIT_TIME2 = 0x103
IO_WAIT_TIME3 = 0x104

; Wait loops stored in AB
wait:
    mov CD, AB
    out IO_WAIT_TIME3, Dl
    out IO_WAIT_TIME2, Dh
    out IO_WAIT_TIME1, Cl
    out IO_WAIT_TIME0, Ch
    out IO_WAIT_PORT, 1
    .test:
        inp Dl, IO_WAIT_PORT
        cmp8 Dl, 0
        cjp EQ, .end
        jmp .test
    
    .end:
        ret

; null terminated string version
; void strcpy(char * dest, char * src) {
;   for(; *src != '\0'; src++, dest++) {
;     *dest = *src;
;   }
; }
strcpy:
    .dest = 0
    .src  = 4

    .test:
        lod8 Al, [.src+SF]
        cmp8 Al, 0
        cjp EQ, .end

        sto8 [.dest+SF], Al
        inc [.dest+SF]
        inc [.src+SF]
        jmp .test
    
    .end:
        mov AB, 2000000
        cal wait
        ret

; strcpy usage:
; psh SF
; mov SF, SP
; psh some_dest
; psh some_src
; cal strcpy
; ppb 8
; pek SF
; pop

dbg_out_clear:
    mov [.idx], DBG_OUT_ADDR

    .test:
        cmp [.idx], DBG_OUT_ADDR + DBG_OUT_BYTES
        cjp EQ, .end
        sto8 [.idx], 0x20
        inc [.idx]
        jmp .test

    .end:
        ret

.idx: #d32 0x00000000

start:
    cal dbg_out_clear

    mov AB, 2000000
    cal wait

    psh SF
    psh hello_msg
    psh DBG_OUT_ADDR
    mov SF, SP
    cal strcpy
    ppb 8
    pek SF
    pop

    jmp start

hello_msg: #d "Hello, World!\0"
