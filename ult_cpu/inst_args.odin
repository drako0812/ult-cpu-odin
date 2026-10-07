package ult_cpu

import "core:fmt"
InstArg :: union {
    ImmArg,
    ImmPtrArg,
    RegArg,
    RegPtrArg,
    ImmPlusRegArg,
    ImmPlusRegPtrArg,
    RegPlusRegArg,
    RegPlusRegPtrArg,
    ImmMinusRegArg,
    ImmMinusRegPtrArg,
    RegMinusRegArg,
    RegMinusRegPtrArg,
    ImmTimesRegArg,
    ImmTimesRegPtrArg,
    RegTimesRegArg,
    RegTimesRegPtrArg,
}

ArgMode :: enum u8 {
    Nil,
    In,
    Out,
    InOut,
}

ArgList :: struct {
    Arg1, Arg2, Arg3, Arg4:     InstArg,
    Mode1, Mode2, Mode3, Mode4: ArgMode,
}

InstArg_get_u8 :: proc(arg: ^InstArg, ucpu: ^Cpu) -> u8 {
    switch &v in arg {
    case ImmArg: return ImmArg_get_u8(&v, ucpu)
    case ImmPtrArg: return ImmPtrArg_get_u8(&v, ucpu)
    case RegArg: return RegArg_get_u8(&v, ucpu)
    case RegPtrArg: return RegPtrArg_get_u8(&v, ucpu)
    case ImmPlusRegArg: return ImmPlusRegArg_get_u8(&v, ucpu)
    case ImmPlusRegPtrArg: return ImmPlusRegPtrArg_get_u8(&v, ucpu)
    case RegPlusRegArg: return RegPlusRegArg_get_u8(&v, ucpu)
    case RegPlusRegPtrArg: return RegPlusRegPtrArg_get_u8(&v, ucpu)
    case ImmMinusRegArg: return ImmMinusRegArg_get_u8(&v, ucpu)
    case ImmMinusRegPtrArg: return ImmMinusRegPtrArg_get_u8(&v, ucpu)
    case RegMinusRegArg: return RegMinusRegArg_get_u8(&v, ucpu)
    case RegMinusRegPtrArg: return RegMinusRegPtrArg_get_u8(&v, ucpu)
    case ImmTimesRegArg: return ImmTimesRegArg_get_u8(&v, ucpu)
    case ImmTimesRegPtrArg: return ImmTimesRegPtrArg_get_u8(&v, ucpu)
    case RegTimesRegArg: return RegTimesRegArg_get_u8(&v, ucpu)
    case RegTimesRegPtrArg: return RegTimesRegPtrArg_get_u8(&v, ucpu)
    }
    return 0
}

InstArg_get_u16 :: proc(arg: ^InstArg, ucpu: ^Cpu) -> u16 {
    switch &v in arg {
    case ImmArg: return ImmArg_get_u16(&v, ucpu)
    case ImmPtrArg: return ImmPtrArg_get_u16(&v, ucpu)
    case RegArg: return RegArg_get_u16(&v, ucpu)
    case RegPtrArg: return RegPtrArg_get_u16(&v, ucpu)
    case ImmPlusRegArg: return ImmPlusRegArg_get_u16(&v, ucpu)
    case ImmPlusRegPtrArg: return ImmPlusRegPtrArg_get_u16(&v, ucpu)
    case RegPlusRegArg: return RegPlusRegArg_get_u16(&v, ucpu)
    case RegPlusRegPtrArg: return RegPlusRegPtrArg_get_u16(&v, ucpu)
    case ImmMinusRegArg: return ImmMinusRegArg_get_u16(&v, ucpu)
    case ImmMinusRegPtrArg: return ImmMinusRegPtrArg_get_u16(&v, ucpu)
    case RegMinusRegArg: return RegMinusRegArg_get_u16(&v, ucpu)
    case RegMinusRegPtrArg: return RegMinusRegPtrArg_get_u16(&v, ucpu)
    case ImmTimesRegArg: return ImmTimesRegArg_get_u16(&v, ucpu)
    case ImmTimesRegPtrArg: return ImmTimesRegPtrArg_get_u16(&v, ucpu)
    case RegTimesRegArg: return RegTimesRegArg_get_u16(&v, ucpu)
    case RegTimesRegPtrArg: return RegTimesRegPtrArg_get_u16(&v, ucpu)
    }
    return 0
}

InstArg_get_u32 :: proc(arg: ^InstArg, ucpu: ^Cpu) -> u32 {
    switch &v in arg {
    case ImmArg: return ImmArg_get_u32(&v, ucpu)
    case ImmPtrArg: return ImmPtrArg_get_u32(&v, ucpu)
    case RegArg: return RegArg_get_u32(&v, ucpu)
    case RegPtrArg: return RegPtrArg_get_u32(&v, ucpu)
    case ImmPlusRegArg: return ImmPlusRegArg_get_u32(&v, ucpu)
    case ImmPlusRegPtrArg: return ImmPlusRegPtrArg_get_u32(&v, ucpu)
    case RegPlusRegArg: return RegPlusRegArg_get_u32(&v, ucpu)
    case RegPlusRegPtrArg: return RegPlusRegPtrArg_get_u32(&v, ucpu)
    case ImmMinusRegArg: return ImmMinusRegArg_get_u32(&v, ucpu)
    case ImmMinusRegPtrArg: return ImmMinusRegPtrArg_get_u32(&v, ucpu)
    case RegMinusRegArg: return RegMinusRegArg_get_u32(&v, ucpu)
    case RegMinusRegPtrArg: return RegMinusRegPtrArg_get_u32(&v, ucpu)
    case ImmTimesRegArg: return ImmTimesRegArg_get_u32(&v, ucpu)
    case ImmTimesRegPtrArg: return ImmTimesRegPtrArg_get_u32(&v, ucpu)
    case RegTimesRegArg: return RegTimesRegArg_get_u32(&v, ucpu)
    case RegTimesRegPtrArg: return RegTimesRegPtrArg_get_u32(&v, ucpu)
    }
    return 0
}

InstArg_set_u8 :: proc(arg: ^InstArg, ucpu: ^Cpu, value: u8) {
    switch &v in arg {
    case ImmArg: ImmArg_set_u8(&v, ucpu, value)
    case ImmPtrArg: ImmPtrArg_set_u8(&v, ucpu, value)
    case RegArg: RegArg_set_u8(&v, ucpu, value)
    case RegPtrArg: RegPtrArg_set_u8(&v, ucpu, value)
    case ImmPlusRegArg: ImmPlusRegArg_set_u8(&v, ucpu, value)
    case ImmPlusRegPtrArg: ImmPlusRegPtrArg_set_u8(&v, ucpu, value)
    case RegPlusRegArg: RegPlusRegArg_set_u8(&v, ucpu, value)
    case RegPlusRegPtrArg: RegPlusRegPtrArg_set_u8(&v, ucpu, value)
    case ImmMinusRegArg: ImmMinusRegArg_set_u8(&v, ucpu, value)
    case ImmMinusRegPtrArg: ImmMinusRegPtrArg_set_u8(&v, ucpu, value)
    case RegMinusRegArg: RegMinusRegArg_set_u8(&v, ucpu, value)
    case RegMinusRegPtrArg: RegMinusRegPtrArg_set_u8(&v, ucpu, value)
    case ImmTimesRegArg: ImmTimesRegArg_set_u8(&v, ucpu, value)
    case ImmTimesRegPtrArg: ImmTimesRegPtrArg_set_u8(&v, ucpu, value)
    case RegTimesRegArg: RegTimesRegArg_set_u8(&v, ucpu, value)
    case RegTimesRegPtrArg: RegTimesRegPtrArg_set_u8(&v, ucpu, value)
    }
}

InstArg_set_u16 :: proc(arg: ^InstArg, ucpu: ^Cpu, value: u16) {
    switch &v in arg {
    case ImmArg: ImmArg_set_u16(&v, ucpu, value)
    case ImmPtrArg: ImmPtrArg_set_u16(&v, ucpu, value)
    case RegArg: RegArg_set_u16(&v, ucpu, value)
    case RegPtrArg: RegPtrArg_set_u16(&v, ucpu, value)
    case ImmPlusRegArg: ImmPlusRegArg_set_u16(&v, ucpu, value)
    case ImmPlusRegPtrArg: ImmPlusRegPtrArg_set_u16(&v, ucpu, value)
    case RegPlusRegArg: RegPlusRegArg_set_u16(&v, ucpu, value)
    case RegPlusRegPtrArg: RegPlusRegPtrArg_set_u16(&v, ucpu, value)
    case ImmMinusRegArg: ImmMinusRegArg_set_u16(&v, ucpu, value)
    case ImmMinusRegPtrArg: ImmMinusRegPtrArg_set_u16(&v, ucpu, value)
    case RegMinusRegArg: RegMinusRegArg_set_u16(&v, ucpu, value)
    case RegMinusRegPtrArg: RegMinusRegPtrArg_set_u16(&v, ucpu, value)
    case ImmTimesRegArg: ImmTimesRegArg_set_u16(&v, ucpu, value)
    case ImmTimesRegPtrArg: ImmTimesRegPtrArg_set_u16(&v, ucpu, value)
    case RegTimesRegArg: RegTimesRegArg_set_u16(&v, ucpu, value)
    case RegTimesRegPtrArg: RegTimesRegPtrArg_set_u16(&v, ucpu, value)
    }
}

InstArg_set_u32 :: proc(arg: ^InstArg, ucpu: ^Cpu, value: u32) {
    switch &v in arg {
    case ImmArg: ImmArg_set_u32(&v, ucpu, value)
    case ImmPtrArg: ImmPtrArg_set_u32(&v, ucpu, value)
    case RegArg: RegArg_set_u32(&v, ucpu, value)
    case RegPtrArg: RegPtrArg_set_u32(&v, ucpu, value)
    case ImmPlusRegArg: ImmPlusRegArg_set_u32(&v, ucpu, value)
    case ImmPlusRegPtrArg: ImmPlusRegPtrArg_set_u32(&v, ucpu, value)
    case RegPlusRegArg: RegPlusRegArg_set_u32(&v, ucpu, value)
    case RegPlusRegPtrArg: RegPlusRegPtrArg_set_u32(&v, ucpu, value)
    case ImmMinusRegArg: ImmMinusRegArg_set_u32(&v, ucpu, value)
    case ImmMinusRegPtrArg: ImmMinusRegPtrArg_set_u32(&v, ucpu, value)
    case RegMinusRegArg: RegMinusRegArg_set_u32(&v, ucpu, value)
    case RegMinusRegPtrArg: RegMinusRegPtrArg_set_u32(&v, ucpu, value)
    case ImmTimesRegArg: ImmTimesRegArg_set_u32(&v, ucpu, value)
    case ImmTimesRegPtrArg: ImmTimesRegPtrArg_set_u32(&v, ucpu, value)
    case RegTimesRegArg: RegTimesRegArg_set_u32(&v, ucpu, value)
    case RegTimesRegPtrArg: RegTimesRegPtrArg_set_u32(&v, ucpu, value)
    }
}

ImmArg :: struct {
    value: u32,
}

ImmArg_get_u8 :: proc(arg: ^ImmArg, ucpu: ^Cpu) -> u8 {
    return u8(arg^.value & 0xFF)
}

ImmArg_get_u16 :: proc(arg: ^ImmArg, ucpu: ^Cpu) -> u16 {
    return u16(arg^.value & 0xFFFF)
}

ImmArg_get_u32 :: proc(arg: ^ImmArg, ucpu: ^Cpu) -> u32 {
    return arg^.value
}

ImmArg_set_u8 :: proc(arg: ^ImmArg, ucpu: ^Cpu, value: u8) {
    // Do nothing, because you can't set an immediate value.
}

ImmArg_set_u16 :: proc(arg: ^ImmArg, ucpu: ^Cpu, value: u16) {
    // Do nothing
}

ImmArg_set_u32 :: proc(arg: ^ImmArg, ucpu: ^Cpu, value: u32) {
    // Do nothing
}

ImmPtrArg :: struct {
    value: u32,
}

ImmPtrArg_get_u8 :: proc(arg: ^ImmPtrArg, ucpu: ^Cpu) -> u8 {
    ptr := arg^.value
    val := read8(&ucpu^.mem, ucpu, ptr)
    return val
}

ImmPtrArg_get_u16 :: proc(arg: ^ImmPtrArg, ucpu: ^Cpu) -> u16 {
    ptr := arg^.value
    val := read16(&ucpu^.mem, ucpu, ptr)
    return val
}

ImmPtrArg_get_u32 :: proc(arg: ^ImmPtrArg, ucpu: ^Cpu) -> u32 {
    ptr := arg^.value
    val := read32(&ucpu^.mem, ucpu, ptr)
    return val
}

ImmPtrArg_set_u8 :: proc(arg: ^ImmPtrArg, ucpu: ^Cpu, value: u8) {
    ptr := arg^.value
    write8(&ucpu^.mem, ucpu, ptr, value)
}

ImmPtrArg_set_u16 :: proc(arg: ^ImmPtrArg, ucpu: ^Cpu, value: u16) {
    ptr := arg^.value
    write16(&ucpu^.mem, ucpu, ptr, value)
}

ImmPtrArg_set_u32 :: proc(arg: ^ImmPtrArg, ucpu: ^Cpu, value: u32) {
    ptr := arg^.value
    write32(&ucpu^.mem, ucpu, ptr, value)
}

RegArg :: struct {
    idx: u8,
}

RegArg_get_u8 :: proc(arg: ^RegArg, ucpu: ^Cpu) -> u8 {
    return get_reg8(&ucpu^.regs, arg^.idx)^
}

RegArg_get_u16 :: proc(arg: ^RegArg, ucpu: ^Cpu) -> u16 {
    return u16(get_reg16(&ucpu^.regs, arg^.idx)^)
}

RegArg_get_u32 :: proc(arg: ^RegArg, ucpu: ^Cpu) -> u32 {
    return u32(get_reg32(&ucpu^.regs, arg^.idx)^)
}

RegArg_set_u8 :: proc(arg: ^RegArg, ucpu: ^Cpu, value: u8) {
    get_reg8(&ucpu^.regs, arg^.idx)^ = value
}

RegArg_set_u16 :: proc(arg: ^RegArg, ucpu: ^Cpu, value: u16) {
    get_reg16(&ucpu^.regs, arg^.idx)^ = u16be(value)
}

RegArg_set_u32 :: proc(arg: ^RegArg, ucpu: ^Cpu, value: u32) {
    get_reg32(&ucpu^.regs, arg^.idx)^ = u32be(value)
}

RegPtrArg :: struct {
    idx: u8,
}

RegPtrArg_get_u8 :: proc(arg: ^RegPtrArg, ucpu: ^Cpu) -> u8 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.idx)^)
    val := read8(&ucpu^.mem, ucpu, ptr)
    return val
}

RegPtrArg_get_u16 :: proc(arg: ^RegPtrArg, ucpu: ^Cpu) -> u16 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.idx)^)
    val := read16(&ucpu^.mem, ucpu, ptr)
    return val
}

RegPtrArg_get_u32 :: proc(arg: ^RegPtrArg, ucpu: ^Cpu) -> u32 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.idx)^)
    val := read32(&ucpu^.mem, ucpu, ptr)
    return val
}

RegPtrArg_set_u8 :: proc(arg: ^RegPtrArg, ucpu: ^Cpu, value: u8) {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.idx)^)
    write8(&ucpu^.mem, ucpu, ptr, value)
}

RegPtrArg_set_u16 :: proc(arg: ^RegPtrArg, ucpu: ^Cpu, value: u16) {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.idx)^)
    write16(&ucpu^.mem, ucpu, ptr, value)
}

RegPtrArg_set_u32 :: proc(arg: ^RegPtrArg, ucpu: ^Cpu, value: u32) {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.idx)^)
    write32(&ucpu^.mem, ucpu, ptr, value)
}

ImmPlusRegArg :: struct {
    value: u32,
    reg:   u8,
}

ImmPlusRegArg_get_u8 :: proc(arg: ^ImmPlusRegArg, ucpu: ^Cpu) -> u8 {
    return u8(arg^.value & 0xFF) + get_reg8(&ucpu^.regs, arg^.reg)^
}

ImmPlusRegArg_get_u16 :: proc(arg: ^ImmPlusRegArg, ucpu: ^Cpu) -> u16 {
    return u16(arg^.value & 0xFFFF) + u16(get_reg16(&ucpu^.regs, arg^.reg)^)
}

ImmPlusRegArg_get_u32 :: proc(arg: ^ImmPlusRegArg, ucpu: ^Cpu) -> u32 {
    val := arg^.value
    reg := arg^.reg
    return val + u32(get_reg32(&ucpu^.regs, reg)^)
}

ImmPlusRegArg_set_u8 :: proc(arg: ^ImmPlusRegArg, ucpu: ^Cpu, value: u8) {
    // Do nothing, because you can't set an immediate value.
}

ImmPlusRegArg_set_u16 :: proc(arg: ^ImmPlusRegArg, ucpu: ^Cpu, value: u16) {
    // Do nothing
}

ImmPlusRegArg_set_u32 :: proc(arg: ^ImmPlusRegArg, ucpu: ^Cpu, value: u32) {
    // Do nothing
}

ImmPlusRegPtrArg :: struct {
    value: u32,
    reg:   u8,
}

ImmPlusRegPtrArg_get_u8 :: proc(arg: ^ImmPlusRegPtrArg, ucpu: ^Cpu) -> u8 {
    ptr := arg^.value + u32(get_reg32(&ucpu^.regs, arg^.reg)^)
    val := read8(&ucpu^.mem, ucpu, ptr)
    return val
}

ImmPlusRegPtrArg_get_u16 :: proc(arg: ^ImmPlusRegPtrArg, ucpu: ^Cpu) -> u16 {
    ptr := arg^.value + u32(get_reg32(&ucpu^.regs, arg^.reg)^)
    val := read16(&ucpu^.mem, ucpu, ptr)
    return val
}

ImmPlusRegPtrArg_get_u32 :: proc(arg: ^ImmPlusRegPtrArg, ucpu: ^Cpu) -> u32 {
    imm := arg^.value
    reg := arg^.reg
    //fmt.printfln("[%08X+%02X]", imm, reg)
    ptr := imm + u32(get_reg32(&ucpu^.regs, reg)^)
    val := read32(&ucpu^.mem, ucpu, ptr)
    return val
}

ImmPlusRegPtrArg_set_u8 :: proc(arg: ^ImmPlusRegPtrArg, ucpu: ^Cpu, value: u8) {
    ptr := arg^.value + u32(get_reg32(&ucpu^.regs, arg^.reg)^)
    write8(&ucpu^.mem, ucpu, ptr, value)
}

ImmPlusRegPtrArg_set_u16 :: proc(arg: ^ImmPlusRegPtrArg, ucpu: ^Cpu, value: u16) {
    ptr := arg^.value + u32(get_reg32(&ucpu^.regs, arg^.reg)^)
    write16(&ucpu^.mem, ucpu, ptr, value)
}

ImmPlusRegPtrArg_set_u32 :: proc(arg: ^ImmPlusRegPtrArg, ucpu: ^Cpu, value: u32) {
    ptr := arg^.value + u32(get_reg32(&ucpu^.regs, arg^.reg)^)
    write32(&ucpu^.mem, ucpu, ptr, value)
}

RegPlusRegArg :: struct {
    reg1: u8,
    reg2: u8,
}

RegPlusRegArg_get_u8 :: proc(arg: ^RegPlusRegArg, ucpu: ^Cpu) -> u8 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) + u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read8(&ucpu^.mem, ucpu, ptr)
    return val
}

RegPlusRegArg_get_u16 :: proc(arg: ^RegPlusRegArg, ucpu: ^Cpu) -> u16 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) + u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read16(&ucpu^.mem, ucpu, ptr)
    return val
}

RegPlusRegArg_get_u32 :: proc(arg: ^RegPlusRegArg, ucpu: ^Cpu) -> u32 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) + u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read32(&ucpu^.mem, ucpu, ptr)
    return val
}

RegPlusRegArg_set_u8 :: proc(arg: ^RegPlusRegArg, ucpu: ^Cpu, value: u8) {

}

RegPlusRegArg_set_u16 :: proc(arg: ^RegPlusRegArg, ucpu: ^Cpu, value: u16) {

}

RegPlusRegArg_set_u32 :: proc(arg: ^RegPlusRegArg, ucpu: ^Cpu, value: u32) {

}

RegPlusRegPtrArg :: struct {
    reg1: u8,
    reg2: u8,
}

RegPlusRegPtrArg_get_u8 :: proc(arg: ^RegPlusRegPtrArg, ucpu: ^Cpu) -> u8 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) + u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read8(&ucpu^.mem, ucpu, ptr)
    return val
}

RegPlusRegPtrArg_get_u16 :: proc(arg: ^RegPlusRegPtrArg, ucpu: ^Cpu) -> u16 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) + u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read16(&ucpu^.mem, ucpu, ptr)
    return val
}

RegPlusRegPtrArg_get_u32 :: proc(arg: ^RegPlusRegPtrArg, ucpu: ^Cpu) -> u32 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) + u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read32(&ucpu^.mem, ucpu, ptr)
    return val
}

RegPlusRegPtrArg_set_u8 :: proc(arg: ^RegPlusRegPtrArg, ucpu: ^Cpu, value: u8) {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) + u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    write8(&ucpu^.mem, ucpu, ptr, value)
}

RegPlusRegPtrArg_set_u16 :: proc(arg: ^RegPlusRegPtrArg, ucpu: ^Cpu, value: u16) {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) + u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    write16(&ucpu^.mem, ucpu, ptr, value)
}

RegPlusRegPtrArg_set_u32 :: proc(arg: ^RegPlusRegPtrArg, ucpu: ^Cpu, value: u32) {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) + u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    write32(&ucpu^.mem, ucpu, ptr, value)
}

ImmMinusRegArg :: struct {
    value: u32,
    reg:   u8,
}

ImmMinusRegArg_get_u8 :: proc(arg: ^ImmMinusRegArg, ucpu: ^Cpu) -> u8 {
    return u8(arg^.value & 0xFF) - get_reg8(&ucpu^.regs, arg^.reg)^
}

ImmMinusRegArg_get_u16 :: proc(arg: ^ImmMinusRegArg, ucpu: ^Cpu) -> u16 {
    return u16(arg^.value & 0xFFFF) - u16(get_reg16(&ucpu^.regs, arg^.reg)^)
}

ImmMinusRegArg_get_u32 :: proc(arg: ^ImmMinusRegArg, ucpu: ^Cpu) -> u32 {
    return arg^.value - u32(get_reg32(&ucpu^.regs, arg^.reg)^)
}

ImmMinusRegArg_set_u8 :: proc(arg: ^ImmMinusRegArg, ucpu: ^Cpu, value: u8) {
    // Do nothing, because you can't set an immediate value.
}

ImmMinusRegArg_set_u16 :: proc(arg: ^ImmMinusRegArg, ucpu: ^Cpu, value: u16) {
    // Do nothing
}

ImmMinusRegArg_set_u32 :: proc(arg: ^ImmMinusRegArg, ucpu: ^Cpu, value: u32) {
    // Do nothing
}

ImmMinusRegPtrArg :: struct {
    value: u32,
    reg:   u8,
}

ImmMinusRegPtrArg_get_u8 :: proc(arg: ^ImmMinusRegPtrArg, ucpu: ^Cpu) -> u8 {
    ptr := arg^.value - u32(get_reg32(&ucpu^.regs, arg^.reg)^)
    val := read8(&ucpu^.mem, ucpu, ptr)
    return val
}

ImmMinusRegPtrArg_get_u16 :: proc(arg: ^ImmMinusRegPtrArg, ucpu: ^Cpu) -> u16 {
    ptr := arg^.value - u32(get_reg32(&ucpu^.regs, arg^.reg)^)
    val := read16(&ucpu^.mem, ucpu, ptr)
    return val
}

ImmMinusRegPtrArg_get_u32 :: proc(arg: ^ImmMinusRegPtrArg, ucpu: ^Cpu) -> u32 {
    ptr := arg^.value - u32(get_reg32(&ucpu^.regs, arg^.reg)^)
    val := read32(&ucpu^.mem, ucpu, ptr)
    return val
}

ImmMinusRegPtrArg_set_u8 :: proc(arg: ^ImmMinusRegPtrArg, ucpu: ^Cpu, value: u8) {
    ptr := arg^.value - u32(get_reg32(&ucpu^.regs, arg^.reg)^)
    write8(&ucpu^.mem, ucpu, ptr, value)
}

ImmMinusRegPtrArg_set_u16 :: proc(arg: ^ImmMinusRegPtrArg, ucpu: ^Cpu, value: u16) {
    ptr := arg^.value - u32(get_reg32(&ucpu^.regs, arg^.reg)^)
    write16(&ucpu^.mem, ucpu, ptr, value)
}

ImmMinusRegPtrArg_set_u32 :: proc(arg: ^ImmMinusRegPtrArg, ucpu: ^Cpu, value: u32) {
    ptr := arg^.value - u32(get_reg32(&ucpu^.regs, arg^.reg)^)
    write32(&ucpu^.mem, ucpu, ptr, value)
}

RegMinusRegArg :: struct {
    reg1: u8,
    reg2: u8,
}

RegMinusRegArg_get_u8 :: proc(arg: ^RegMinusRegArg, ucpu: ^Cpu) -> u8 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) - u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read8(&ucpu^.mem, ucpu, ptr)
    return val
}

RegMinusRegArg_get_u16 :: proc(arg: ^RegMinusRegArg, ucpu: ^Cpu) -> u16 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) - u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read16(&ucpu^.mem, ucpu, ptr)
    return val
}

RegMinusRegArg_get_u32 :: proc(arg: ^RegMinusRegArg, ucpu: ^Cpu) -> u32 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) - u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read32(&ucpu^.mem, ucpu, ptr)
    return val
}

RegMinusRegArg_set_u8 :: proc(arg: ^RegMinusRegArg, ucpu: ^Cpu, value: u8) {

}

RegMinusRegArg_set_u16 :: proc(arg: ^RegMinusRegArg, ucpu: ^Cpu, value: u16) {

}

RegMinusRegArg_set_u32 :: proc(arg: ^RegMinusRegArg, ucpu: ^Cpu, value: u32) {

}

RegMinusRegPtrArg :: struct {
    reg1: u8,
    reg2: u8,
}

RegMinusRegPtrArg_get_u8 :: proc(arg: ^RegMinusRegPtrArg, ucpu: ^Cpu) -> u8 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) - u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read8(&ucpu^.mem, ucpu, ptr)
    return val
}

RegMinusRegPtrArg_get_u16 :: proc(arg: ^RegMinusRegPtrArg, ucpu: ^Cpu) -> u16 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) - u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read16(&ucpu^.mem, ucpu, ptr)
    return val
}

RegMinusRegPtrArg_get_u32 :: proc(arg: ^RegMinusRegPtrArg, ucpu: ^Cpu) -> u32 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) - u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read32(&ucpu^.mem, ucpu, ptr)
    return val
}

RegMinusRegPtrArg_set_u8 :: proc(arg: ^RegMinusRegPtrArg, ucpu: ^Cpu, value: u8) {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) - u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    write8(&ucpu^.mem, ucpu, ptr, value)
}

RegMinusRegPtrArg_set_u16 :: proc(arg: ^RegMinusRegPtrArg, ucpu: ^Cpu, value: u16) {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) - u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    write16(&ucpu^.mem, ucpu, ptr, value)
}

RegMinusRegPtrArg_set_u32 :: proc(arg: ^RegMinusRegPtrArg, ucpu: ^Cpu, value: u32) {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) - u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    write32(&ucpu^.mem, ucpu, ptr, value)
}

ImmTimesRegArg :: struct {
    value: u32,
    reg:   u8,
}

ImmTimesRegArg_get_u8 :: proc(arg: ^ImmTimesRegArg, ucpu: ^Cpu) -> u8 {
    return u8(arg^.value & 0xFF) * get_reg8(&ucpu^.regs, arg^.reg)^
}

ImmTimesRegArg_get_u16 :: proc(arg: ^ImmTimesRegArg, ucpu: ^Cpu) -> u16 {
    return u16(arg^.value & 0xFFFF) * u16(get_reg16(&ucpu^.regs, arg^.reg)^)
}

ImmTimesRegArg_get_u32 :: proc(arg: ^ImmTimesRegArg, ucpu: ^Cpu) -> u32 {
    return arg^.value * u32(get_reg32(&ucpu^.regs, arg^.reg)^)
}

ImmTimesRegArg_set_u8 :: proc(arg: ^ImmTimesRegArg, ucpu: ^Cpu, value: u8) {
    // Do nothing, because you can't set an immediate value.
}

ImmTimesRegArg_set_u16 :: proc(arg: ^ImmTimesRegArg, ucpu: ^Cpu, value: u16) {
    // Do nothing
}

ImmTimesRegArg_set_u32 :: proc(arg: ^ImmTimesRegArg, ucpu: ^Cpu, value: u32) {
    // Do nothing
}

ImmTimesRegPtrArg :: struct {
    value: u32,
    reg:   u8,
}

ImmTimesRegPtrArg_get_u8 :: proc(arg: ^ImmTimesRegPtrArg, ucpu: ^Cpu) -> u8 {
    ptr := arg^.value * u32(get_reg32(&ucpu^.regs, arg^.reg)^)
    val := read8(&ucpu^.mem, ucpu, ptr)
    return val
}

ImmTimesRegPtrArg_get_u16 :: proc(arg: ^ImmTimesRegPtrArg, ucpu: ^Cpu) -> u16 {
    ptr := arg^.value * u32(get_reg32(&ucpu^.regs, arg^.reg)^)
    val := read16(&ucpu^.mem, ucpu, ptr)
    return val
}

ImmTimesRegPtrArg_get_u32 :: proc(arg: ^ImmTimesRegPtrArg, ucpu: ^Cpu) -> u32 {
    ptr := arg^.value * u32(get_reg32(&ucpu^.regs, arg^.reg)^)
    val := read32(&ucpu^.mem, ucpu, ptr)
    return val
}

ImmTimesRegPtrArg_set_u8 :: proc(arg: ^ImmTimesRegPtrArg, ucpu: ^Cpu, value: u8) {
    ptr := arg^.value * u32(get_reg32(&ucpu^.regs, arg^.reg)^)
    write8(&ucpu^.mem, ucpu, ptr, value)
}

ImmTimesRegPtrArg_set_u16 :: proc(arg: ^ImmTimesRegPtrArg, ucpu: ^Cpu, value: u16) {
    ptr := arg^.value * u32(get_reg32(&ucpu^.regs, arg^.reg)^)
    write16(&ucpu^.mem, ucpu, ptr, value)
}

ImmTimesRegPtrArg_set_u32 :: proc(arg: ^ImmTimesRegPtrArg, ucpu: ^Cpu, value: u32) {
    ptr := arg^.value * u32(get_reg32(&ucpu^.regs, arg^.reg)^)
    write32(&ucpu^.mem, ucpu, ptr, value)
}

RegTimesRegArg :: struct {
    reg1: u8,
    reg2: u8,
}

RegTimesRegArg_get_u8 :: proc(arg: ^RegTimesRegArg, ucpu: ^Cpu) -> u8 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) * u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read8(&ucpu^.mem, ucpu, ptr)
    return val
}

RegTimesRegArg_get_u16 :: proc(arg: ^RegTimesRegArg, ucpu: ^Cpu) -> u16 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) * u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read16(&ucpu^.mem, ucpu, ptr)
    return val
}

RegTimesRegArg_get_u32 :: proc(arg: ^RegTimesRegArg, ucpu: ^Cpu) -> u32 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) * u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read32(&ucpu^.mem, ucpu, ptr)
    return val
}

RegTimesRegArg_set_u8 :: proc(arg: ^RegTimesRegArg, ucpu: ^Cpu, value: u8) {

}

RegTimesRegArg_set_u16 :: proc(arg: ^RegTimesRegArg, ucpu: ^Cpu, value: u16) {

}

RegTimesRegArg_set_u32 :: proc(arg: ^RegTimesRegArg, ucpu: ^Cpu, value: u32) {

}

RegTimesRegPtrArg :: struct {
    reg1: u8,
    reg2: u8,
}

RegTimesRegPtrArg_get_u8 :: proc(arg: ^RegTimesRegPtrArg, ucpu: ^Cpu) -> u8 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) * u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read8(&ucpu^.mem, ucpu, ptr)
    return val
}

RegTimesRegPtrArg_get_u16 :: proc(arg: ^RegTimesRegPtrArg, ucpu: ^Cpu) -> u16 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) * u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read16(&ucpu^.mem, ucpu, ptr)
    return val
}

RegTimesRegPtrArg_get_u32 :: proc(arg: ^RegTimesRegPtrArg, ucpu: ^Cpu) -> u32 {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) * u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    val := read32(&ucpu^.mem, ucpu, ptr)
    return val
}

RegTimesRegPtrArg_set_u8 :: proc(arg: ^RegTimesRegPtrArg, ucpu: ^Cpu, value: u8) {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) * u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    write8(&ucpu^.mem, ucpu, ptr, value)
}

RegTimesRegPtrArg_set_u16 :: proc(arg: ^RegTimesRegPtrArg, ucpu: ^Cpu, value: u16) {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) * u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    write16(&ucpu^.mem, ucpu, ptr, value)
}

RegTimesRegPtrArg_set_u32 :: proc(arg: ^RegTimesRegPtrArg, ucpu: ^Cpu, value: u32) {
    ptr := u32(get_reg32(&ucpu^.regs, arg^.reg1)^) * u32(get_reg32(&ucpu^.regs, arg^.reg2)^)
    write32(&ucpu^.mem, ucpu, ptr, value)
}
