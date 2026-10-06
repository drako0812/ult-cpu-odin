#once

#subruledef reg32 {
    AB => 0x00
    CD => 0x01
    EF => 0x02
    GH => 0x03
    IJ => 0x04
    XY => 0x05
    PC => 0x06
    SP => 0x07
    SF => 0x08
    ST => 0x09
    KL => 0x0A
    MN => 0x0B
    OP => 0x0C
    QR => 0x0D
    UV => 0x0E
    r01 => 0x0F
    r02 => 0x10
    r03 => 0x11
    r04 => 0x12
    r05 => 0x13
    r06 => 0x14
    r07 => 0x15
}

#subruledef reg16 {
    A => 0x00
    C => 0x01
    E => 0x02
    G => 0x03
    I => 0x04
    X => 0x05
    K => 0x06
    M => 0x07
    O => 0x08
    Q => 0x09
    B => 0x0A
    D => 0x0B
    F => 0x0C
    H => 0x0D
    J => 0x0E
    Y => 0x0F
    L => 0x10
    N => 0x11
    P => 0x12
    R => 0x13
    V => 0x14
    r01l => 0x15
}

#subruledef reg8 {
    Al => 0x00
    Cl => 0x01
    El => 0x02
    Gl => 0x03
    Il => 0x04
    Xl => 0x05
    Ah => 0x06
    Ch => 0x07
    Eh => 0x08
    Gh => 0x09
    Bl => 0x0A
    Dl => 0x0B
    Fl => 0x0C
    Hl => 0x0D
    Jl => 0x0E
    Yl => 0x0F
    Bh => 0x10
    Dh => 0x11
    Fh => 0x12
    Hh => 0x13
    Jh => 0x14
    Yh => 0x15
}

__Z  = 0b00000000000000000000000000000001
__GT = 0b00000000000000000000000000000010
__LT = 0b00000000000000000000000000000100
__EQ = 0b00000000000000000000000000001000
__NE = 0b00000000000000000000000000010000
__CA = 0b00000000000000000000000000100000
__OF = 0b00000000000000000000000001000000
__UF = 0b00000000000000000000000010000000
__I  = 0b00000000000000000000000100000000
__I2 = 0b00000000000000000000001000000000
__FLAG_ENC_REVERSE_BIT = 0b10000000000000000000000000000000

#subruledef flag {
    Z => __Z
    NZ => __Z | __FLAG_ENC_REVERSE_BIT
    GT => __GT
    NGT => __GT | __FLAG_ENC_REVERSE_BIT
    LT => __LT
    NLT => __LT | __FLAG_ENC_REVERSE_BIT
    EQ => __EQ
    NE => __NE
    CA => __CA
    NCA => __CA | __FLAG_ENC_REVERSE_BIT
    OF => __OF
    NOF => __OF | __FLAG_ENC_REVERSE_BIT
    UF => __UF
    NUF => __UF | __FLAG_ENC_REVERSE_BIT
    I => __I
    NI => __I | __FLAG_ENC_REVERSE_BIT
    I2 => __I2
    NI2 => __I2 | __FLAG_ENC_REVERSE_BIT
}

#subruledef src8 {
    {imm: i8} => imm
    [{imm: i32}] => imm
    {reg: reg8} => reg
    [{reg: reg32}] => reg
    {imm: i8}+{reg: reg8} => imm @ reg
    [{imm: i32}+{reg: reg32}] => imm @ reg
    {reg: reg8}+{reg2: reg8} => reg @ reg2
    [{reg: reg32}+{reg2: reg32}] => reg @ reg2
    {imm: i8}-{reg: reg8} => imm @ reg
    [{imm: i32}-{reg: reg32}] => imm @ reg
    {reg: reg8}-{reg2: reg8} => reg @ reg2
    [{reg: reg32}-{reg2: reg32}] => reg @ reg2
    {imm: i8}*{reg: reg8} => imm @ reg
    [{imm: i32}*{reg: reg32}] => imm @ reg
    {reg: reg8}*{reg2: reg8} => reg @ reg2
    [{reg: reg32}*{reg2: reg32}] => reg @ reg2
}

#ruledef {
    __src8_enc {imm: i8} => 0x0`4
    __src8_enc [{imm: i32}] => 0x1`4
    __src8_enc {reg: reg8} => 0x2`4
    __src8_enc [{reg: reg32}] => 0x3`4
    __src8_enc {imm: i8}+{reg: reg8} => 0x4`4
    __src8_enc [{imm: i32}+{reg: reg32}] => 0x5`4
    __src8_enc {reg: reg8}+{reg2: reg8} => 0x6`4
    __src8_enc [{reg: reg32}+{reg2: reg32}] => 0x7`4
    __src8_enc {imm: i8}-{reg: reg8} => 0x8`4
    __src8_enc [{imm: i32}-{reg: reg32}] => 0x9`4
    __src8_enc {reg: reg8}-{reg2: reg8} => 0xA`4
    __src8_enc [{reg: reg32}-{reg2: reg32}] => 0xB`4
    __src8_enc {imm: i8}*{reg: reg8} => 0xC`4
    __src8_enc [{imm: i32}*{reg: reg32}] => 0xD`4
    __src8_enc {reg: reg8}*{reg2: reg8} => 0xE`4
    __src8_enc [{reg: reg32}*{reg2: reg32}] => 0xF`4
}

#subruledef src16 {
    {imm: i16} => imm
    [{imm: i32}] => imm
    {reg: reg16} => reg
    [{reg: reg32}] => reg
    {imm: i16}+{reg: reg16} => imm @ reg
    [{imm: i32}+{reg: reg32}] => imm @ reg
    {reg: reg16}+{reg2: reg16} => reg @ reg2
    [{reg: reg32}+{reg2: reg32}] => reg @ reg2
    {imm: i16}-{reg: reg16} => imm @ reg
    [{imm: i32}-{reg: reg32}] => imm @ reg
    {reg: reg16}-{reg2: reg16} => reg @ reg2
    [{reg: reg32}-{reg2: reg32}] => reg @ reg2
    {imm: i16}*{reg: reg16} => imm @ reg
    [{imm: i32}*{reg: reg32}] => imm @ reg
    {reg: reg16}*{reg2: reg16} => reg @ reg2
    [{reg: reg32}*{reg2: reg32}] => reg @ reg2
}

#ruledef {
    __src16_enc {imm: i16} => 0x0`4
    __src16_enc [{imm: i32}] => 0x1`4
    __src16_enc {reg: reg16} => 0x2`4
    __src16_enc [{reg: reg32}] => 0x3`4
    __src16_enc {imm: i16}+{reg: reg16} => 0x4`4
    __src16_enc [{imm: i32}+{reg: reg32}] => 0x5`4
    __src16_enc {reg: reg16}+{reg2: reg16} => 0x6`4
    __src16_enc [{reg: reg32}+{reg2: reg32}] => 0x7`4
    __src16_enc {imm: i16}-{reg: reg16} => 0x8`4
    __src16_enc [{imm: i32}-{reg: reg32}] => 0x9`4
    __src16_enc {reg: reg16}-{reg2: reg16} => 0xA`4
    __src16_enc [{reg: reg32}-{reg2: reg32}] => 0xB`4
    __src16_enc {imm: i16}*{reg: reg16} => 0xC`4
    __src16_enc [{imm: i32}*{reg: reg32}] => 0xD`4
    __src16_enc {reg: reg16}*{reg2: reg16} => 0xE`4
    __src16_enc [{reg: reg32}*{reg2: reg32}] => 0xF`4
}

#subruledef src32 {
    {imm: i32} => imm
    [{imm: i32}] => imm
    {reg: reg32} => reg
    [{reg: reg32}] => reg
    {imm: i32}+{reg: reg32} => imm @ reg
    [{imm: i32}+{reg: reg32}] => imm @ reg
    {reg: reg32}+{reg2: reg32} => reg @ reg2
    [{reg: reg32}+{reg2: reg32}] => reg @ reg2
    {imm: i32}-{reg: reg32} => imm @ reg
    [{imm: i32}-{reg: reg32}] => imm @ reg
    {reg: reg32}-{reg2: reg32} => reg @ reg2
    [{reg: reg32}-{reg2: reg32}] => reg @ reg2
    {imm: i32}*{reg: reg32} => imm @ reg
    [{imm: i32}*{reg: reg32}] => imm @ reg
    {reg: reg32}*{reg2: reg32} => reg @ reg2
    [{reg: reg32}*{reg2: reg32}] => reg @ reg2
}

#ruledef {
    __src32_enc {imm: i32} => 0x0`4
    __src32_enc [{imm: i32}] => 0x1`4
    __src32_enc {reg: reg32} => 0x2`4
    __src32_enc [{reg: reg32}] => 0x3`4
    __src32_enc {imm: i32}+{reg: reg32} => 0x4`4
    __src32_enc [{imm: i32}+{reg: reg32}] => 0x5`4
    __src32_enc {reg: reg32}+{reg2: reg32} => 0x6`4
    __src32_enc [{reg: reg32}+{reg2: reg32}] => 0x7`4
    __src32_enc {imm: i32}-{reg: reg32} => 0x8`4
    __src32_enc [{imm: i32}-{reg: reg32}] => 0x9`4
    __src32_enc {reg: reg32}-{reg2: reg32} => 0xA`4
    __src32_enc [{reg: reg32}-{reg2: reg32}] => 0xB`4
    __src32_enc {imm: i32}*{reg: reg32} => 0xC`4
    __src32_enc [{imm: i32}*{reg: reg32}] => 0xD`4
    __src32_enc {reg: reg32}*{reg2: reg32} => 0xE`4
    __src32_enc [{reg: reg32}*{reg2: reg32}] => 0xF`4
}

#subruledef dst8 {
    [{imm: i32}] => imm
    {reg: reg8} => reg
    [{reg: reg32}] => reg
    [{imm: i32}+{reg: reg32}] => imm @ reg
    [{reg: reg32}+{reg2: reg32}] => reg @ reg2
    [{imm: i32}-{reg: reg32}] => imm @ reg
    [{reg: reg32}-{reg2: reg32}] => reg @ reg2
    [{imm: i32}*{reg: reg32}] => imm @ reg
    [{reg: reg32}*{reg2: reg32}] => reg @ reg2
}

#ruledef {
    __dst8_enc [{imm: i32}] => 0x1`4
    __dst8_enc {reg: reg8} => 0x2`4
    __dst8_enc [{reg: reg32}] => 0x3`4
    __dst8_enc [{imm: i32}+{reg: reg32}] => 0x5`4
    __dst8_enc [{reg: reg32}+{reg2: reg32}] => 0x7`4
    __dst8_enc [{imm: i32}-{reg: reg32}] => 0x9`4
    __dst8_enc [{reg: reg32}-{reg2: reg32}] => 0xB`4
    __dst8_enc [{imm: i32}*{reg: reg32}] => 0xD`4
    __dst8_enc [{reg: reg32}*{reg2: reg32}] => 0xF`4
}

#subruledef dst16 {
    [{imm: i32}] => imm
    {reg: reg16} => reg
    [{reg: reg32}] => reg
    [{imm: i32}+{reg: reg32}] => imm @ reg
    [{reg: reg32}+{reg2: reg32}] => reg @ reg2
    [{imm: i32}-{reg: reg32}] => imm @ reg
    [{reg: reg32}-{reg2: reg32}] => reg @ reg2
    [{imm: i32}*{reg: reg32}] => imm @ reg
    [{reg: reg32}*{reg2: reg32}] => reg @ reg2
}

#ruledef {
    __dst16_enc [{imm: i32}] => 0x1`4
    __dst16_enc {reg: reg16} => 0x2`4
    __dst16_enc [{reg: reg32}] => 0x3`4
    __dst16_enc [{imm: i32}+{reg: reg32}] => 0x5`4
    __dst16_enc [{reg: reg32}+{reg2: reg32}] => 0x7`4
    __dst16_enc [{imm: i32}-{reg: reg32}] => 0x9`4
    __dst16_enc [{reg: reg32}-{reg2: reg32}] => 0xB`4
    __dst16_enc [{imm: i32}*{reg: reg32}] => 0xD`4
    __dst16_enc [{reg: reg32}*{reg2: reg32}] => 0xF`4
}

#subruledef dst32 {
    [{imm: i32}] => imm
    {reg: reg32} => reg
    [{reg: reg32}] => reg
    [{imm: i32}+{reg: reg32}] => imm @ reg
    [{reg: reg32}+{reg2: reg32}] => reg @ reg2
    [{imm: i32}-{reg: reg32}] => imm @ reg
    [{reg: reg32}-{reg2: reg32}] => reg @ reg2
    [{imm: i32}*{reg: reg32}] => imm @ reg
    [{reg: reg32}*{reg2: reg32}] => reg @ reg2
}

#ruledef {
    __dst32_enc [{imm: i32}] => 0x1`4
    __dst32_enc {reg: reg32} => 0x2`4
    __dst32_enc [{reg: reg32}] => 0x3`4
    __dst32_enc [{imm: i32}+{reg: reg32}] => 0x5`4
    __dst32_enc [{reg: reg32}+{reg2: reg32}] => 0x7`4
    __dst32_enc [{imm: i32}-{reg: reg32}] => 0x9`4
    __dst32_enc [{reg: reg32}-{reg2: reg32}] => 0xB`4
    __dst32_enc [{imm: i32}*{reg: reg32}] => 0xD`4
    __dst32_enc [{reg: reg32}*{reg2: reg32}] => 0xF`4
}

#ruledef {
    ; System
    hlt => 0xFFFC
    brk => 0xFFFD
    nop => 0xFFFE

    ; 32-bit/Base
    mov {d: dst32}, {s: src32} => 0x0000`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    inc {d: dst32} => 0x0001`16 @ asm { __dst32_enc {d} } @ 0x0`4 @ d
    icc {d: dst32} => 0x0002`16 @ asm { __dst32_enc {d} } @ 0x0`4 @ d
    dec {d: dst32} => 0x0003`16 @ asm { __dst32_enc {d} } @ 0x0`4 @ d
    dcb {d: dst32} => 0x0004`16 @ asm { __dst32_enc {d} } @ 0x0`4 @ d
    add {d: dst32}, {s: src32} => 0x0005`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    adc {d: dst32}, {s: src32} => 0x0006`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    sub {d: dst32}, {s: src32} => 0x0007`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    sbb {d: dst32}, {s: src32} => 0x0008`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    mul {d1: dst32}, {d2: dst32}, {s: src32} => 0x0009`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    mls {d1: dst32}, {d2: dst32}, {s: src32} => 0x000A`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    div {d: dst32}, {s: src32} => 0x000B`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    dvs {d: dst32}, {s: src32} => 0x000C`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    mod {d: dst32}, {s: src32} => 0x000D`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    mds {d: dst32}, {s: src32} => 0x000E`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    dvm {d1: dst32}, {d2: dst32}, {s: src32} => 0x000F`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    dms {d1: dst32}, {d2: dst32}, {s: src32} => 0x0010`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    rem {d: dst32}, {s: src32} => 0x0011`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    rms {d: dst32}, {s: src32} => 0x0012`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    dvr {d1: dst32}, {d2: dst32}, {s: src32} => 0x0013`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    drs {d1: dst32}, {d2: dst32}, {s: src32} => 0x0014`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    cpl {d: dst32} => 0x0015`16 @ asm { __dst32_enc {d} } @ 0x0`4 @ d
    and {d: dst32}, {s: src32} => 0x0016`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    ior {d: dst32}, {s: src32} => 0x0017`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    xor {d: dst32}, {s: src32} => 0x0018`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    bst {d: dst32}, {s: src32} => 0x0019`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    brs {d: dst32}, {s: src32} => 0x001A`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    bts {d: dst32}, {s: src32} => 0x001B`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    shl {d: dst32}, {s: src32} => 0x001C`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    asr {d: dst32}, {s: src32} => 0x001D`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    lsr {d: dst32}, {s: src32} => 0x001E`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    rtl {d: dst32}, {s: src32} => 0x001F`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    rtr {d: dst32}, {s: src32} => 0x0020`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    rlc {d: dst32}, {s: src32} => 0x0021`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    rrc {d: dst32}, {s: src32} => 0x0022`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    cmp {s1: src32}, {s2: src32} => 0x0023`16 @ asm { __src32_enc {s1} } @ asm { __src32_enc {s2} } @ s1 @ s2
    jmp {s: src32} => 0x0024`16 @ asm { __src32_enc {s} } @ 0x0`4 @ s
    cjp {f: flag}, {s: src32} => 0x0025`16 @ 0x0`4 @ asm { __src32_enc {s} } @ f @ s
    cal {s: src32} => 0x0026`16 @ asm { __src32_enc {s} } @ 0x0`4 @ s
    ccl {f: flag}, {s: src32} => 0x0027`16 @ 0x0`4 @ asm { __src32_enc {s} } @ f @ s
    ret => 0x0028`16
    irt => 0x0029`16
    crt {f: flag} => 0x002A`16 @ 0x00`8 @ f
    cir {f: flag} => 0x002B`16 @ 0x00`8 @ f
    ien => 0x002C`16
    idi => 0x002D`16
    iti {s: src32} => 0x002E`16 @ asm { __src32_enc {s} } @ 0x0`4 @ s
    imi {s: src32} => 0x002F`16 @ asm { __src32_enc {s} } @ 0x0`4 @ s
    int {s: src16} => 0x0030`16 @ asm { __src16_enc {s} } @ 0x0`4 @ s
    psh {s: src32} => 0x0031`16 @ asm { __src32_enc {s} } @ 0x0`4 @ s
    psr {s: src32} => 0x0032`16 @ asm { __src32_enc {s} } @ 0x0`4 @ s
    pzm {s: src32} => 0x0033`16 @ asm { __src32_enc {s} } @ 0x0`4 @ s
    pop => 0x0034`16
    ppb {s: src32} => 0x0035`16 @ asm { __src32_enc {s} } @ 0x0`4 @ s
    pek {d: dst32} => 0x0036`16 @ asm { __dst32_enc {d} } @ 0x0`4 @ d
    pko {d: dst32}, {s: src32} => 0x0037`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    ppr {s: src32} => 0x0038`16 @ asm { __src32_enc {s} } @ 0x0`4 @ s
    out {p: src16}, {v: src8} => 0x0039`16 @ asm { __src16_enc {p} } @ asm { __src8_enc {v} } @ p @ v
    inp {v: dst8}, {p: src16} => 0x003A`16 @ asm { __dst8_enc {v} } @ asm { __src16_enc {p} } @ v @ p
    lod {d: dst32}, {s: src32} => 0x003B`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    sto {s1: src32}, {s2: src32} => 0x003C`16 @ asm { __src32_enc {s1} } @ asm { __src32_enc {s2} } @ s1 @ s2

    ; 8-bit
    mov8 {d: dst8}, {s: src8} => 0x1000`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    inc8 {d: dst8} => 0x1001`16 @ asm { __dst8_enc {d} } @ 0x0`4 @ d
    icc8 {d: dst8} => 0x1002`16 @ asm { __dst8_enc {d} } @ 0x0`4 @ d
    dec8 {d: dst8} => 0x1003`16 @ asm { __dst8_enc {d} } @ 0x0`4 @ d
    dcb8 {d: dst8} => 0x1004`16 @ asm { __dst8_enc {d} } @ 0x0`4 @ d
    add8 {d: dst8}, {s: src8} => 0x1005`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    adc8 {d: dst8}, {s: src8} => 0x1006`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    sub8 {d: dst8}, {s: src8} => 0x1007`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    sbb8 {d: dst8}, {s: src8} => 0x1008`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    mul8 {d1: dst8}, {d2: dst8}, {s: src8} => 0x1009`16 @ asm { __dst8_enc {d1} } @ asm { __dst8_enc {d2} } @ asm { __src8_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    mls8 {d1: dst8}, {d2: dst8}, {s: src8} => 0x100A`16 @ asm { __dst8_enc {d1} } @ asm { __dst8_enc {d2} } @ asm { __src8_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    div8 {d: dst8}, {s: src8} => 0x100B`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    dvs8 {d: dst8}, {s: src8} => 0x100C`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    mod8 {d: dst8}, {s: src8} => 0x100D`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    mds8 {d: dst8}, {s: src8} => 0x100E`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    dvm8 {d1: dst8}, {d2: dst8}, {s: src8} => 0x100F`16 @ asm { __dst8_enc {d1} } @ asm { __dst8_enc {d2} } @ asm { __src8_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    dms8 {d1: dst8}, {d2: dst8}, {s: src8} => 0x1010`16 @ asm { __dst8_enc {d1} } @ asm { __dst8_enc {d2} } @ asm { __src8_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    rem8 {d: dst8}, {s: src8} => 0x1011`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    rms8 {d: dst8}, {s: src8} => 0x1012`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    dvr8 {d1: dst8}, {d2: dst8}, {s: src8} => 0x1013`16 @ asm { __dst8_enc {d1} } @ asm { __dst8_enc {d2} } @ asm { __src8_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    drs8 {d1: dst8}, {d2: dst8}, {s: src8} => 0x1014`16 @ asm { __dst8_enc {d1} } @ asm { __dst8_enc {d2} } @ asm { __src8_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    cpl8 {d: dst8} => 0x1015`16 @ asm { __dst8_enc {d} } @ 0x0`4 @ d
    and8 {d: dst8}, {s: src8} => 0x1016`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    ior8 {d: dst8}, {s: src8} => 0x1017`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    xor8 {d: dst8}, {s: src8} => 0x1018`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    bst8 {d: dst8}, {s: src8} => 0x1019`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    brs8 {d: dst8}, {s: src8} => 0x101A`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    bts8 {d: dst8}, {s: src8} => 0x101B`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    shl8 {d: dst8}, {s: src8} => 0x101C`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    asr8 {d: dst8}, {s: src8} => 0x101D`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    lsr8 {d: dst8}, {s: src8} => 0x101E`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    rtl8 {d: dst8}, {s: src8} => 0x101F`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    rtr8 {d: dst8}, {s: src8} => 0x1020`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    rlc8 {d: dst8}, {s: src8} => 0x1021`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    rrc8 {d: dst8}, {s: src8} => 0x1022`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    cmp8 {s1: src8}, {s2: src8} => 0x1023`16 @ asm { __src8_enc {s1} } @ asm { __src8_enc {s2} } @ s1 @ s2
    psh8 {s: src8} => 0x1024`16 @ asm { __src8_enc {s} } @ 0x0`4 @ s
    pop8 => 0x1025`16
    pek8 {d: dst8} => 0x1026`16 @ asm { __dst8_enc {d} } @ 0x0`4 @ d
    pko8 {d: dst8}, {s: src8} => 0x1027`16 @ asm { __dst8_enc {d} } @ asm { __src8_enc {s} } @ d @ s
    lod8 {d: dst8}, {s: src32} => 0x1028`16 @ asm { __dst8_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    sto8 {s1: src32}, {s2: src8} => 0x1029`16 @ asm { __src32_enc {s1} } @ asm { __src8_enc {s2} } @ s1 @ s2

    ; 16-bit
    mov16 {d: dst16}, {s: src16} => 0x2000`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    inc16 {d: dst16} => 0x2001`16 @ asm { __dst16_enc {d} } @ 0x0`4 @ d
    icc16 {d: dst16} => 0x2002`16 @ asm { __dst16_enc {d} } @ 0x0`4 @ d
    dec16 {d: dst16} => 0x2003`16 @ asm { __dst16_enc {d} } @ 0x0`4 @ d
    dcb16 {d: dst16} => 0x2004`16 @ asm { __dst16_enc {d} } @ 0x0`4 @ d
    add16 {d: dst16}, {s: src16} => 0x2005`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    adc16 {d: dst16}, {s: src16} => 0x2006`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    sub16 {d: dst16}, {s: src16} => 0x2007`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    sbb16 {d: dst16}, {s: src16} => 0x2008`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    mul16 {d1: dst16}, {d2: dst16}, {s: src16} => 0x2009`16 @ asm { __dst16_enc {d1} } @ asm { __dst16_enc {d2} } @ asm { __src16_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    mls16 {d1: dst16}, {d2: dst16}, {s: src16} => 0x200A`16 @ asm { __dst16_enc {d1} } @ asm { __dst16_enc {d2} } @ asm { __src16_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    div16 {d: dst16}, {s: src16} => 0x200B`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    dvs16 {d: dst16}, {s: src16} => 0x200C`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    mod16 {d: dst16}, {s: src16} => 0x200D`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    mds16 {d: dst16}, {s: src16} => 0x200E`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    dvm16 {d1: dst16}, {d2: dst16}, {s: src16} => 0x200F`16 @ asm { __dst16_enc {d1} } @ asm { __dst16_enc {d2} } @ asm { __src16_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    dms16 {d1: dst16}, {d2: dst16}, {s: src16} => 0x2010`16 @ asm { __dst16_enc {d1} } @ asm { __dst16_enc {d2} } @ asm { __src16_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    rem16 {d: dst16}, {s: src16} => 0x2011`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    rms16 {d: dst16}, {s: src16} => 0x2012`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    dvr16 {d1: dst16}, {d2: dst16}, {s: src16} => 0x2013`16 @ asm { __dst16_enc {d1} } @ asm { __dst16_enc {d2} } @ asm { __src16_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    drs16 {d1: dst16}, {d2: dst16}, {s: src16} => 0x2014`16 @ asm { __dst16_enc {d1} } @ asm { __dst16_enc {d2} } @ asm { __src16_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    cpl16 {d: dst16} => 0x2015`16 @ asm { __dst16_enc {d} } @ 0x0`4 @ d
    and16 {d: dst16}, {s: src16} => 0x2016`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    ior16 {d: dst16}, {s: src16} => 0x2017`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    xor16 {d: dst16}, {s: src16} => 0x2018`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    bst16 {d: dst16}, {s: src16} => 0x2019`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    brs16 {d: dst16}, {s: src16} => 0x201A`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    bts16 {d: dst16}, {s: src16} => 0x201B`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    shl16 {d: dst16}, {s: src16} => 0x201C`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    asr16 {d: dst16}, {s: src16} => 0x201D`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    lsr16 {d: dst16}, {s: src16} => 0x201E`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    rtl16 {d: dst16}, {s: src16} => 0x201F`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    rtr16 {d: dst16}, {s: src16} => 0x2020`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    rlc16 {d: dst16}, {s: src16} => 0x2021`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    rrc16 {d: dst16}, {s: src16} => 0x2022`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    cmp16 {s1: src16}, {s2: src16} => 0x2023`16 @ asm { __src16_enc {s1} } @ asm { __src16_enc {s2} } @ s1 @ s2
    psh16 {s: src16} => 0x2024`16 @ asm { __src16_enc {s} } @ 0x0`4 @ s
    pop16 => 0x2025`16
    pek16 {d: dst16} => 0x2026`16 @ asm { __dst16_enc {d} } @ 0x0`4 @ d
    pko16 {d: dst16}, {s: src16} => 0x2027`16 @ asm { __dst16_enc {d} } @ asm { __src16_enc {s} } @ d @ s
    lod16 {d: dst16}, {s: src32} => 0x2028`16 @ asm { __dst16_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    sto16 {s1: src32}, {s2: src16} => 0x2029`16 @ asm { __src32_enc {s1} } @ asm { __src16_enc {s2} } @ s1 @ s2

    ; Float

    ; 16x2
    inc16x2 {d: dst32} => 0x4000`16 @ asm { __dst32_enc {d} } @ 0x0`4 @ d
    dec16x2 {d: dst32} => 0x4001`16 @ asm { __dst32_enc {d} } @ 0x0`4 @ d
    add16x2 {d: dst32}, {s: src32} => 0x4002`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    sub16x2 {d: dst32}, {s: src32} => 0x4003`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    mul16x2 {d1: dst32}, {d2: dst32}, {s: src32} => 0x4004`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    mls16x2 {d1: dst32}, {d2: dst32}, {s: src32} => 0x4005`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    div16x2 {d: dst32}, {s: src32} => 0x4006`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    dvs16x2 {d: dst32}, {s: src32} => 0x4007`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    mod16x2 {d: dst32}, {s: src32} => 0x4008`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    mds16x2 {d: dst32}, {s: src32} => 0x4009`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    dvm16x2 {d1: dst32}, {d2: dst32}, {s: src32} => 0x400A`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    dms16x2 {d1: dst32}, {d2: dst32}, {s: src32} => 0x400B`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    rem16x2 {d: dst32}, {s: src32} => 0x400C`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    rms16x2 {d: dst32}, {s: src32} => 0x400D`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    dvr16x2 {d1: dst32}, {d2: dst32}, {s: src32} => 0x400E`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    drs16x2 {d1: dst32}, {d2: dst32}, {s: src32} => 0x400F`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    bst16x2 {d: dst32}, {s: src32} => 0x4010`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    brs16x2 {d: dst32}, {s: src32} => 0x4012`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    shl16x2 {d: dst32}, {s: src32} => 0x4013`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    asr16x2 {d: dst32}, {s: src32} => 0x4014`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    lsr16x2 {d: dst32}, {s: src32} => 0x4015`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    rtl16x2 {d: dst32}, {s: src32} => 0x4016`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    rtr16x2 {d: dst32}, {s: src32} => 0x4017`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s

    ; 8x4
    inc8x4 {d: dst32} => 0x5000`16 @ asm { __dst32_enc {d} } @ 0x0`4 @ d
    dec8x4 {d: dst32} => 0x5001`16 @ asm { __dst32_enc {d} } @ 0x0`4 @ d
    add8x4 {d: dst32}, {s: src32} => 0x5002`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    sub8x4 {d: dst32}, {s: src32} => 0x5003`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    mul8x4 {d1: dst32}, {d2: dst32}, {s: src32} => 0x5004`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    mls8x4 {d1: dst32}, {d2: dst32}, {s: src32} => 0x5005`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    div8x4 {d: dst32}, {s: src32} => 0x5006`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    dvs8x4 {d: dst32}, {s: src32} => 0x5007`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    mod8x4 {d: dst32}, {s: src32} => 0x5008`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    mds8x4 {d: dst32}, {s: src32} => 0x5009`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    dvm8x4 {d1: dst32}, {d2: dst32}, {s: src32} => 0x500A`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    dms8x4 {d1: dst32}, {d2: dst32}, {s: src32} => 0x500B`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    rem8x4 {d: dst32}, {s: src32} => 0x500C`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    rms8x4 {d: dst32}, {s: src32} => 0x500D`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    dvr8x4 {d1: dst32}, {d2: dst32}, {s: src32} => 0x500E`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    drs8x4 {d1: dst32}, {d2: dst32}, {s: src32} => 0x500F`16 @ asm { __dst32_enc {d1} } @ asm { __dst32_enc {d2} } @ asm { __src32_enc {s} } @ 0x0`4 @ d1 @ d2 @ s
    bst8x4 {d: dst32}, {s: src32} => 0x5010`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    brs8x4 {d: dst32}, {s: src32} => 0x5012`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    shl8x4 {d: dst32}, {s: src32} => 0x5013`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    asr8x4 {d: dst32}, {s: src32} => 0x5014`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    lsr8x4 {d: dst32}, {s: src32} => 0x5015`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    rtl8x4 {d: dst32}, {s: src32} => 0x5016`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
    rtr8x4 {d: dst32}, {s: src32} => 0x5017`16 @ asm { __dst32_enc {d} } @ asm { __src32_enc {s} } @ d @ s
}
