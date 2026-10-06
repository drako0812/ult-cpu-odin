#include "../lib/ult_cpu.asm"

#d32 start
#d16 0x0000
#d32 start

DBG_OUT_ADDR = 0x600000
DBG_OUT_BYTES = 256

; null terminated string version
; void strcpy(char * dest, char * src) {
;   for(; *src != '\0'; src++, dest++) {
;     *dest = *src;
;   }
; }
strcpy:
    .dest = 0
    .src  = 1

    .test:
        lod8 Al, [.src+SF]
        cmp8 Al, 0
        cjp EQ, .end

        sto8 [.dest+SF], Al
        inc [.dest+SF]
        inc [.src+SF]
        jmp .test
    
    .end:
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
        sto [.idx], 0
        inc [.idx]
        jmp .test

    .end:
        ret

.idx: #d32 0x00000000

start:
    cal dbg_out_clear

    psh SF
    mov SF, SP
    psh DBG_OUT_ADDR
    psh hello_msg
    cal strcpy
    ppb 8
    pek SF
    pop

    jmp start

hello_msg: #d "Hello, World!\0"
