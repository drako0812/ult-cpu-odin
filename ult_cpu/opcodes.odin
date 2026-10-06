package ult_cpu

OpCode :: enum u16 {
    Mov, // 0x0000
    Inc, // 0x0001
    Icc, // 0x0002
    Dec, // 0x0003
    Dcb, // 0x0004
    Add, // 0x0005
    Adc, // 0x0006
    Sub, // 0x0007
    Sbb, // 0x0008
    Mul, // 0x0009
    Mls, // 0x000A
    Div, // 0x000B
    Dvs, // 0x000C
    Mod, // 0x000D
    Mds, // 0x000E
    Dvm, // 0x000F
    Dms, // 0x0010
    Rem, // 0x0011
    Rms, // 0x0012
    Dvr, // 0x0013
    Drs, // 0x0014
    Cpl, // 0x0015
    And, // 0x0016
    Ior, // 0x0017
    Xor, // 0x0018
    Bst, // 0x0019
    Brs, // 0x001A
    Bts, // 0x001B
    Shl, // 0x001C
    Asr, // 0x001D
    Lsr, // 0x001E
    Rtl, // 0x001F
    Rtr, // 0x0020
    Rlc, // 0x0021
    Rrc, // 0x0022
    Cmp, // 0x0023
    Jmp, // 0x0024
    Cjp, // 0x0025
    Cal, // 0x0026
    Ccl, // 0x0027
    Ret, // 0x0028
    Irt, // 0x0029
    Crt, // 0x002A
    Cir, // 0x002B
    Ien, // 0x002C
    Idi, // 0x002D
    Iti, // 0x002E
    Imi, // 0x002F
    Int, // 0x0030
    Psh, // 0x0031
    Psr, // 0x0032
    Pzm, // 0x0033
    Pop, // 0x0034
    Ppb, // 0x0035
    Pek, // 0x0036
    Pko, // 0x0037
    Ppr, // 0x0038
    Out, // 0x0039
    Inp, // 0x003A
    Lod, // 0x003B
    Sto, // 0x003C
    Hlt = 0xFFFC,
    Brk = 0xFFFD,
    Nop = 0xFFFE,
    Mov8 = 0x1000,
    Inc8,
    Icc8,
    Dec8,
    Dcb8,
    Add8,
    Adc8,
    Sub8,
    Sbb8,
    Mul8,
    Mls8,
    Div8,
    Dvs8,
    Mod8,
    Mds8,
    Dvm8,
    Dms8,
    Rem8,
    Rms8,
    Dvr8,
    Drs8,
    Cpl8,
    And8,
    Ior8,
    Xor8,
    Bst8,
    Brs8,
    Bts8,
    Shl8,
    Asr8,
    Lsr8,
    Rtl8,
    Rtr8,
    Rlc8,
    Rrc8,
    Cmp8,
    Psh8,
    Pop8,
    Pek8,
    Pko8,
    Lod8,
    Sto8,
    Mov16 = 0x2000,
    Inc16,
    Icc16,
    Dec16,
    Dcb16,
    Add16,
    Adc16,
    Sub16,
    Sbb16,
    Mul16,
    Mls16,
    Div16,
    Dvs16,
    Mod16,
    Mds16,
    Dvm16,
    Dms16,
    Rem16,
    Rms16,
    Dvr16,
    Drs16,
    Cpl16,
    And16,
    Ior16,
    Xor16,
    Bst16,
    Brs16,
    Bts16,
    Shl16,
    Asr16,
    Lsr16,
    Rtl16,
    Rtr16,
    Rlc16,
    Rrc16,
    Cmp16,
    Psh16,
    Pop16,
    Pek16,
    Pko16,
    Lod16,
    Sto16,
    Incf = 0x3000,
    Decf,
    Addf,
    Subf,
    Mulf,
    Divf,
    Modf,
    Dvmf,
    Remf,
    Dvrf,
    Sincf,
    Sdecf,
    Saddf,
    Ssubf,
    Smulf,
    Sdivf,
    Smodf,
    Sdvmf,
    Cmpf,
    Fabsf,
    Nanf,
    Fmaxf,
    Fminf,
    Expf,
    Exp2f,
    Expm1f,
    Logf,
    Log10f,
    Log2f,
    Log1pf,
    Powf,
    Sqrtf,
    Cbrtf,
    Hypotf,
    Sinf,
    Cosf,
    Tanf,
    Asinf,
    Acosf,
    Atanf,
    Atan2f,
    Sinhf,
    Coshf,
    Tanhf,
    Asinhf,
    Acoshf,
    Atanhf,
    Errf,
    Erfcf,
    Tgammaf,
    Lgammaf,
    Ceilf,
    Floorf,
    Truncf,
    Roundf,
    Frexpf,
    Ldexpf,
    Ilogbf,
    Logbf,
    Nafterf,
    F2if,
    I2ff,
    Inc16x2 = 0x4000,
    Dec16x2,
    Add16x2,
    Sub16x2,
    Mul16x2,
    Mls16x2,
    Div16x2,
    Dvs16x2,
    Mod16x2,
    Mds16x2,
    Dvm16x2,
    Dms16x2,
    Rem16x2,
    Rms16x2,
    Dvr16x2,
    Drs16x2,
    Bst16x2,
    Brs16x2,
    Shl16x2,
    Asr16x2,
    Lsr16x2,
    Rtl16x2,
    Rtr16x2,
    Inc8x4 = 0x5000,
    Dec8x4,
    Add8x4,
    Sub8x4,
    Mul8x4,
    Mls8x4,
    Div8x4,
    Dvs8x4,
    Mod8x4,
    Mds8x4,
    Dvm8x4,
    Dms8x4,
    Rem8x4,
    Rms8x4,
    Dvr8x4,
    Drs8x4,
    Bst8x4,
    Brs8x4,
    Shl8x4,
    Asr8x4,
    Lsr8x4,
    Rtl8x4,
    Rtr8x4,
}
