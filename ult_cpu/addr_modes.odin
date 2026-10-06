package ult_cpu

AddrMode :: enum u8 {
    Imm,
    ImmPtr,
    Reg,
    RegPtr,
    ImmPlusReg,
    ImmPlusRegPtr,
    RegPlusReg,
    RegPlusRegPtr,
    ImmMinusReg,
    ImmMinusRegPtr,
    RegMinusReg,
    RegMinusRegPtr,
    ImmTimesReg,
    ImmTimesRegPtr,
    RegTimesReg,
    RegTimesRegPtr,
}

@(rodata)
ADDR_MODE_TICKS := [?]u64{
    1, 2, 0, 1,
    1, 2, 1, 2,
    1, 2, 1, 2,
    2, 3, 1, 2,
}
