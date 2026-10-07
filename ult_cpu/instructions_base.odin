package ult_cpu

import "core:fmt"
InstError :: union {
    InstErrorNone,
    InstErrorHalt,
    InstErrorDebugBreak,
    InstErrorWithMessage,
}

InstErrorNone :: struct {}

InstErrorHalt :: struct {}

InstErrorDebugBreak :: struct {}

InstErrorWithMessage :: struct {
    Message: string,
}

// inst_<mnemonic> :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError

InstProc :: #type proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError

inst_mov :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    InstArg_set_u32(&arg_list^.Arg1, ucpu, InstArg_get_u32(&arg_list^.Arg2, ucpu))
    return InstErrorNone{}
}

inst_lod :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    src := InstArg_get_u32(&arg_list^.Arg2, ucpu)
    val := read32(&ucpu^.mem, ucpu, src)
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_sto :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    src := InstArg_get_u32(&arg_list^.Arg2, ucpu)
    daddr := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    write32(&ucpu^.mem, ucpu, daddr, src)
    return InstErrorNone{}
}

inst_inc :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    InstArg_set_u32(&arg_list^.Arg1, ucpu, InstArg_get_u32(&arg_list^.Arg1, ucpu) + 1)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_icc :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    val += 1
    if test_flag(ucpu, .CA) {
        val += 1
    }
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_dec :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    InstArg_set_u32(&arg_list^.Arg1, ucpu, InstArg_get_u32(&arg_list^.Arg1, ucpu) - 1)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_dcb :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    val -= 1
    if test_flag(ucpu, .CA) {
        val -= 1
    }
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_add :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    InstArg_set_u32(&arg_list^.Arg1, ucpu, InstArg_get_u32(&arg_list^.Arg1, ucpu) + InstArg_get_u32(&arg_list^.Arg2, ucpu))
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_adc :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    val += InstArg_get_u32(&arg_list^.Arg2, ucpu)
    if test_flag(ucpu, .CA) {
        val += 1
    }
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_sub :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    InstArg_set_u32(&arg_list^.Arg1, ucpu, InstArg_get_u32(&arg_list^.Arg1, ucpu) - InstArg_get_u32(&arg_list^.Arg2, ucpu))
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_sbb :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    val -= InstArg_get_u32(&arg_list^.Arg2, ucpu)
    if test_flag(ucpu, .CA) {
        val -= 1
    }
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_mul :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := u64(InstArg_get_u32(&arg_list^.Arg1, ucpu))
    val *= u64(InstArg_get_u32(&arg_list^.Arg3, ucpu))
    a1 := u32((val & 0xFFFFFFFF00000000) >> 32)
    a2 := u32(val & 0x00000000FFFFFFFF)
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, a1)
    InstArg_set_u32(&arg_list^.Arg2, ucpu, a2)
    return InstErrorNone{}
}

inst_mls :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i64)u64(InstArg_get_u32(&arg_list^.Arg1, ucpu))
    val *= transmute(i64)u64(InstArg_get_u32(&arg_list^.Arg3, ucpu))
    a1 := u32((transmute(u64)val & 0xFFFFFFFF00000000) >> 32)
    a2 := u32(transmute(u64)val & 0x00000000FFFFFFFF)
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, a1)
    InstArg_set_u32(&arg_list^.Arg2, ucpu, a2)
    return InstErrorNone{}
}

inst_div :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    val /= InstArg_get_u32(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_dvs :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i32)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    val /= transmute(i32)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)val)
    return InstErrorNone{}
}

inst_mod :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    val %= InstArg_get_u32(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_mds :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i32)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    val %= transmute(i32)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)val)
    return InstErrorNone{}
}

inst_dvm :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    a1 := val / InstArg_get_u32(&arg_list^.Arg3, ucpu)
    a2 := val % InstArg_get_u32(&arg_list^.Arg3, ucpu)
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, a1)
    InstArg_set_u32(&arg_list^.Arg2, ucpu, a2)
    return InstErrorNone{}
}

inst_dms :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i32)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    a1 := val / transmute(i32)InstArg_get_u32(&arg_list^.Arg3, ucpu)
    a2 := val % transmute(i32)InstArg_get_u32(&arg_list^.Arg3, ucpu)
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)a1)
    InstArg_set_u32(&arg_list^.Arg2, ucpu, transmute(u32)a2)
    return InstErrorNone{}
}

inst_rem :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    val %%= InstArg_get_u32(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_rms :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i32)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    val %%= transmute(i32)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)val)
    return InstErrorNone{}
}

inst_dvr :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    a1 := val / InstArg_get_u32(&arg_list^.Arg3, ucpu)
    a2 := val %% InstArg_get_u32(&arg_list^.Arg3, ucpu)
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, a1)
    InstArg_set_u32(&arg_list^.Arg2, ucpu, a2)
    return InstErrorNone{}
}

inst_drs :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i32)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    a1 := val / transmute(i32)InstArg_get_u32(&arg_list^.Arg3, ucpu)
    a2 := val %% transmute(i32)InstArg_get_u32(&arg_list^.Arg3, ucpu)
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)a1)
    InstArg_set_u32(&arg_list^.Arg2, ucpu, transmute(u32)a2)
    return InstErrorNone{}
}

inst_cpl :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    val = ~val
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_and :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    val &= InstArg_get_u32(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_ior :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    val |= InstArg_get_u32(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_xor :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    val ~= InstArg_get_u32(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_bst :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    bidx := clamp(InstArg_get_u8(&arg_list^.Arg2, ucpu), 0, 31)
    val |= u32(1) << bidx
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_brs :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    bidx := clamp(InstArg_get_u8(&arg_list^.Arg2, ucpu), 0, 31)
    val &= ~(u32(1) << bidx)
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_bts :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    bidx := clamp(InstArg_get_u8(&arg_list^.Arg2, ucpu), 0, 31)
    res := val & (u32(1) << bidx)
    if res == 0 {
        set_flag(ucpu, .Z)
    } else {
        reset_flag(ucpu, .Z)
    }
    return InstErrorNone{}
}

inst_shl :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u32(&arg_list^.Arg2, ucpu)
    res := val << amt
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, res)
    return InstErrorNone{}
}

inst_asr :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u32(&arg_list^.Arg2, ucpu)
    res := transmute(i32)val >> amt
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)res)
    return InstErrorNone{}
}

inst_lsr :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u32(&arg_list^.Arg2, ucpu)
    res := val >> amt
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, res)
    return InstErrorNone{}
}

_rotate_left_u32 :: proc(val: u32) -> u32 {
    accum1 := val << 1
    accum2 := val >> 31
    accum1 |= accum2
    return accum1
}

_rotate_left_u16 :: proc(val: u16) -> u16 {
    accum1 := val << 1
    accum2 := val >> 15
    accum1 |= accum2
    return accum1
}

_rotate_left_u8 :: proc(val: u8) -> u8 {
    accum1 := val << 1
    accum2 := val >> 7
    accum1 |= accum2
    return accum1
}

_rotate_left_u32_with_carry :: proc(val: u32, carry: bool) -> (u32, bool) {
    valr := u64(val) | ((u64(1) << 32) if carry else 0)
    accum1 := valr << 1
    accum2 := valr >> 32
    accum1 |= accum2

    ret := u32(accum1 & 0xFFFFFFFF)
    carry_out := (accum1 & 0x100000000) != 0

    return ret, carry_out
}

_rotate_left_u16_with_carry :: proc(val: u16, carry: bool) -> (u16, bool) {
    valr := u32(val) | ((u32(1) << 16) if carry else 0)
    accum1 := valr << 1
    accum2 := valr >> 16
    accum1 |= accum2

    ret := u16(accum1 & 0xFFFF)
    carry_out := (accum1 & 0x10000) != 0

    return ret, carry_out
}

_rotate_left_u8_with_carry :: proc(val: u8, carry: bool) -> (u8, bool) {
    valr := u16(val) | ((u16(1) << 8) if carry else 0)
    accum1 := valr << 1
    accum2 := valr >> 8
    accum1 |= accum2

    ret := u8(accum1 & 0xFF)
    carry_out := (accum1 & 0x100) != 0

    return ret, carry_out
}

_rotate_left :: proc {
    _rotate_left_u32,
    _rotate_left_u16,
    _rotate_left_u8,
    _rotate_left_u32_with_carry,
    _rotate_left_u16_with_carry,
    _rotate_left_u8_with_carry,
}

_rotate_right_u32 :: proc(val: u32) -> u32 {
    accum1 := val >> 1
    accum2 := val << 31
    accum1 |= accum2
    return accum1
}

_rotate_right_u16 :: proc(val: u16) -> u16 {
    accum1 := val >> 1
    accum2 := val << 15
    accum1 |= accum2
    return accum1
}

_rotate_right_u8 :: proc(val: u8) -> u8 {
    accum1 := val >> 1
    accum2 := val << 7
    accum1 |= accum2
    return accum1
}

_rotate_right_u32_with_carry :: proc(val: u32, carry: bool) -> (u32, bool) {
    valr := u64(val) | ((u64(1) << 32) if carry else 0)
    accum1 := valr >> 1
    accum2 := valr << 32
    accum1 |= accum2

    ret := u32(accum1 & 0xFFFFFFFF)
    carry_out := (accum1 & 0x100000000) != 0

    return ret, carry_out
}

_rotate_right_u16_with_carry :: proc(val: u16, carry: bool) -> (u16, bool) {
    valr := u32(val) | ((u32(1) << 16) if carry else 0)
    accum1 := valr >> 1
    accum2 := valr << 16
    accum1 |= accum2

    ret := u16(accum1 & 0xFFFF)
    carry_out := (accum1 & 0x10000) != 0

    return ret, carry_out
}

_rotate_right_u8_with_carry :: proc(val: u8, carry: bool) -> (u8, bool) {
    valr := u16(val) | ((u16(1) << 8) if carry else 0)
    accum1 := valr >> 1
    accum2 := valr << 8
    accum1 |= accum2

    ret := u8(accum1 & 0xFF)
    carry_out := (accum1 & 0x100) != 0

    return ret, carry_out
}

_rotate_right :: proc {
    _rotate_right_u32,
    _rotate_right_u16,
    _rotate_right_u8,
    _rotate_right_u32_with_carry,
    _rotate_right_u16_with_carry,
    _rotate_right_u8_with_carry,
}

inst_rtl :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u32(&arg_list^.Arg2, ucpu)
    for _ in 0 ..< amt {
        val = _rotate_left(val)
    }
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_rtr :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u32(&arg_list^.Arg2, ucpu)
    for _ in 0 ..< amt {
        val = _rotate_right(val)
    }
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_rlc :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u32(&arg_list^.Arg2, ucpu)
    carry := test_flag(ucpu, .CA)
    for _ in 0 ..< amt {
        val, carry = _rotate_left(val, carry)
    }
    if carry {
        set_flag(ucpu, .CA)
    } else {
        reset_flag(ucpu, .CA)
    }
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_rrc :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u32(&arg_list^.Arg2, ucpu)
    carry := test_flag(ucpu, .CA)
    for _ in 0 ..< amt {
        val, carry = _rotate_right(val, carry)
    }
    if carry {
        set_flag(ucpu, .CA)
    } else {
        reset_flag(ucpu, .CA)
    }
    // TODO: Set Flags
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_cmp :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := InstArg_get_u32(&arg_list^.Arg2, ucpu)

    if lhs > rhs {
        set_flag(ucpu, .GT)
    } else {
        reset_flag(ucpu, .GT)
    }

    if lhs < rhs {
        set_flag(ucpu, .LT)
    } else {
        reset_flag(ucpu, .LT)
    }

    if lhs == rhs {
        set_flag(ucpu, .EQ)
        reset_flag(ucpu, .NE)
    } else {
        reset_flag(ucpu, .EQ)
        set_flag(ucpu, .NE)
    }

    //fmt.printfln("ST: %032b", u32(ucpu^.regs.r32.ST))

    return InstErrorNone{}
}

inst_jmp :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    ucpu^.regs.r32.PC = u32be(val)
    return InstErrorNone{}
}

inst_cjp :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    cnd := FlagEnc(InstArg_get_u32(&arg_list^.Arg1, ucpu))
    val := InstArg_get_u32(&arg_list^.Arg2, ucpu)
    if test_flag(ucpu, cnd) {
        ucpu^.regs.r32.PC = u32be(val)
    } else {
        ucpu^.regs.r32.PC = u32be(Cpu_next_pc(ucpu))
    }
    return InstErrorNone{}
}

inst_cal :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    //Cpu_push_u32(ucpu, u32(ucpu^.regs.r32.PC))
    npc := Cpu_next_pc(ucpu)
    Cpu_push_u32(ucpu, npc)
    ucpu^.regs.r32.PC = u32be(val)
    dump_stack(ucpu)
    return InstErrorNone{}
}

inst_ccl :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    cnd := FlagEnc(InstArg_get_u32(&arg_list^.Arg1, ucpu))
    val := InstArg_get_u32(&arg_list^.Arg2, ucpu)
    if test_flag(ucpu, cnd) {
        //Cpu_push_u32(ucpu, u32(ucpu^.regs.r32.PC))
        npc := Cpu_next_pc(ucpu)
        Cpu_push_u32(ucpu, npc)
        ucpu^.regs.r32.PC = u32be(val)
        dump_stack(ucpu)
    } else {
        ucpu^.regs.r32.PC = u32be(Cpu_next_pc(ucpu))
    }
    return InstErrorNone{}
}

inst_ret :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    npc := Cpu_pop_u32(ucpu)
    ucpu^.regs.r32.PC = u32be(npc)
    dump_stack(ucpu)
    return InstErrorNone{}
}

inst_irt :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    // TODO: Investigate whether `irt` requires more to be done.
    npc := Cpu_pop_u32(ucpu)
    ucpu^.regs.r32.PC = u32be(npc)

    // Turn off I2 flag if on
    reset_flag(ucpu, .I2)

    dump_stack(ucpu)
    return InstErrorNone{}
}

inst_crt :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    cnd := FlagEnc(InstArg_get_u32(&arg_list^.Arg1, ucpu))
    if test_flag(ucpu, cnd) {
        npc := Cpu_pop_u32(ucpu)
        ucpu^.regs.r32.PC = u32be(npc)
        dump_stack(ucpu)
    } else {
        ucpu^.regs.r32.PC = u32be(Cpu_next_pc(ucpu))
    }
    return InstErrorNone{}
}

inst_cir :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    // TODO: Investigate whether `cir` requires more to be done.
    cnd := FlagEnc(InstArg_get_u32(&arg_list^.Arg1, ucpu))
    if test_flag(ucpu, cnd) {
        npc := Cpu_pop_u32(ucpu)
        ucpu^.regs.r32.PC = u32be(npc)

        // Turn off I2 flag if on
        reset_flag(ucpu, .I2)

        dump_stack(ucpu)
    } else {
        ucpu^.regs.r32.PC = u32be(Cpu_next_pc(ucpu))
    }
    return InstErrorNone{}
}

inst_ien :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    set_flag(ucpu, .I)
    return InstErrorNone{}
}

inst_idi :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    reset_flag(ucpu, .I)
    return InstErrorNone{}
}

inst_iti :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    ucpu^.int_table_enabled = true
    ucpu^.int_table_loc = val
    return InstErrorNone{}
}

inst_imi :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    ucpu^.int_mask_enabled = true
    ucpu^.int_mask_loc = val
    return InstErrorNone{}
}

inst_int :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    did_trigger := Cpu_trigger_interrupt(ucpu, val)
    if !did_trigger {
        ucpu^.regs.r32.PC = u32be(Cpu_next_pc(ucpu))
    }
    return InstErrorNone{}
}

inst_psh :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    Cpu_push(ucpu, val)
    dump_stack(ucpu)
    return InstErrorNone{}
}

inst_psr :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    set := transmute(bit_set[0 ..= 0x15;u32])val
    for i in 0 ..= 0x15 {
        if i in set {
            Cpu_push_u32(ucpu, u32(get_reg32(&ucpu^.regs, u8(i))^))
        }
    }
    dump_stack(ucpu)
    return InstErrorNone{}
}

inst_pzm :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    for i in 0 ..< val {
        Cpu_push_u8(ucpu, 0)
    }
    dump_stack(ucpu)
    return InstErrorNone{}
}

inst_pop :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    Cpu_pop_u32(ucpu)
    dump_stack(ucpu)
    return InstErrorNone{}
}

inst_ppb :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    for i in 0 ..< val {
        Cpu_pop_u8(ucpu)
    }
    dump_stack(ucpu)
    return InstErrorNone{}
}

inst_pek :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := Cpu_top_u32(ucpu)
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_pko :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := Cpu_top_u32_with_offset(ucpu, InstArg_get_u32(&arg_list^.Arg2, ucpu))
    InstArg_set_u32(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_ppr :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    set := transmute(bit_set[0 ..= 0x15;u32])val
    for i := 0x15; i >= 0; i -= 1 {
        if i in set {
            get_reg32(&ucpu^.regs, u8(i))^ = u32be(Cpu_pop_u32(ucpu))
        }
    }
    dump_stack(ucpu)
    return InstErrorNone{}
}

inst_out :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    port := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    val := InstArg_get_u8(&arg_list^.Arg2, ucpu)
    Cpu_output(ucpu, port, val)
    return InstErrorNone{}
}

inst_inp :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    port := InstArg_get_u16(&arg_list^.Arg2, ucpu)
    InstArg_set_u8(&arg_list^.Arg1, ucpu, Cpu_input(ucpu, port))
    return InstErrorNone{}
}

inst_hlt :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    return InstErrorHalt{}
}

inst_brk :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    return InstErrorDebugBreak{}
}

inst_nop :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    return InstErrorNone{}
}
