package ult_cpu

inst_mov16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    InstArg_set_u16(&arg_list^.Arg1, ucpu, InstArg_get_u16(&arg_list^.Arg2, ucpu))
    return InstErrorNone{}
}

inst_lod16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    src := InstArg_get_u32(&arg_list^.Arg2, ucpu)
    val := read16(&ucpu^.mem, ucpu, src)
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_sto16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    src := InstArg_get_u16(&arg_list^.Arg2, ucpu)
    daddr := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    write16(&ucpu^.mem, ucpu, daddr, src)
    return InstErrorNone{}
}

inst_inc16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    InstArg_set_u16(&arg_list^.Arg1, ucpu, InstArg_get_u16(&arg_list^.Arg1, ucpu) + 1)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_icc16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    val += 1
    if test_flag(ucpu, .CA) {
        val += 1
    }
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_dec16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    InstArg_set_u16(&arg_list^.Arg1, ucpu, InstArg_get_u16(&arg_list^.Arg1, ucpu) - 1)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_dcb16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    val -= 1
    if test_flag(ucpu, .CA) {
        val -= 1
    }
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_add16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    InstArg_set_u16(&arg_list^.Arg1, ucpu, InstArg_get_u16(&arg_list^.Arg1, ucpu) + InstArg_get_u16(&arg_list^.Arg2, ucpu))
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_adc16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    val += InstArg_get_u16(&arg_list^.Arg2, ucpu)
    if test_flag(ucpu, .CA) {
        val += 1
    }
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_sub16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    InstArg_set_u16(&arg_list^.Arg1, ucpu, InstArg_get_u16(&arg_list^.Arg1, ucpu) - InstArg_get_u16(&arg_list^.Arg2, ucpu))
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_sbb16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    val -= InstArg_get_u16(&arg_list^.Arg2, ucpu)
    if test_flag(ucpu, .CA) {
        val -= 1
    }
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_mul16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := u32(InstArg_get_u16(&arg_list^.Arg1, ucpu))
    val *= u32(InstArg_get_u16(&arg_list^.Arg3, ucpu))
    a1 := u16((val & 0xFFFF0000) >> 8)
    a2 := u16(val & 0x0000FFFF)
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, a1)
    InstArg_set_u16(&arg_list^.Arg2, ucpu, a2)
    return InstErrorNone{}
}

inst_mls16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i32)u32(InstArg_get_u16(&arg_list^.Arg1, ucpu))
    val *= transmute(i32)u32(InstArg_get_u16(&arg_list^.Arg3, ucpu))
    a1 := u16((transmute(u32)val & 0xFFFF0000) >> 8)
    a2 := u16(transmute(u32)val & 0x0000FFFF)
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, a1)
    InstArg_set_u16(&arg_list^.Arg2, ucpu, a2)
    return InstErrorNone{}
}

inst_div16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    val /= InstArg_get_u16(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_dvs16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i16)InstArg_get_u16(&arg_list^.Arg1, ucpu)
    val /= transmute(i16)InstArg_get_u16(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, transmute(u16)val)
    return InstErrorNone{}
}

inst_mod16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    val %= InstArg_get_u16(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_mds16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i16)InstArg_get_u16(&arg_list^.Arg1, ucpu)
    val %= transmute(i16)InstArg_get_u16(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, transmute(u16)val)
    return InstErrorNone{}
}

inst_dvm16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    a1 := val / InstArg_get_u16(&arg_list^.Arg3, ucpu)
    a2 := val % InstArg_get_u16(&arg_list^.Arg3, ucpu)
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, a1)
    InstArg_set_u16(&arg_list^.Arg2, ucpu, a2)
    return InstErrorNone{}
}

inst_dms16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i16)InstArg_get_u16(&arg_list^.Arg1, ucpu)
    a1 := val / transmute(i16)InstArg_get_u16(&arg_list^.Arg3, ucpu)
    a2 := val % transmute(i16)InstArg_get_u16(&arg_list^.Arg3, ucpu)
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, transmute(u16)a1)
    InstArg_set_u16(&arg_list^.Arg2, ucpu, transmute(u16)a2)
    return InstErrorNone{}
}

inst_rem16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    val %%= InstArg_get_u16(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_rms16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i16)InstArg_get_u16(&arg_list^.Arg1, ucpu)
    val %%= transmute(i16)InstArg_get_u16(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, transmute(u16)val)
    return InstErrorNone{}
}

inst_dvr16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    a1 := val / InstArg_get_u16(&arg_list^.Arg3, ucpu)
    a2 := val %% InstArg_get_u16(&arg_list^.Arg3, ucpu)
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, a1)
    InstArg_set_u16(&arg_list^.Arg2, ucpu, a2)
    return InstErrorNone{}
}

inst_drs16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i16)InstArg_get_u16(&arg_list^.Arg1, ucpu)
    a1 := val / transmute(i16)InstArg_get_u16(&arg_list^.Arg3, ucpu)
    a2 := val %% transmute(i16)InstArg_get_u16(&arg_list^.Arg3, ucpu)
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, transmute(u16)a1)
    InstArg_set_u16(&arg_list^.Arg2, ucpu, transmute(u16)a2)
    return InstErrorNone{}
}

inst_cpl16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    val = ~val
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_and16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    val &= InstArg_get_u16(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_ior16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    val |= InstArg_get_u16(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_xor16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    val ~= InstArg_get_u16(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_bst16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    bidx := clamp(InstArg_get_u16(&arg_list^.Arg2, ucpu), 0, 15)
    val |= u16(1) << bidx
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_brs16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    bidx := clamp(InstArg_get_u16(&arg_list^.Arg2, ucpu), 0, 15)
    val &= ~(u16(1) << bidx)
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_bts16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    bidx := clamp(InstArg_get_u16(&arg_list^.Arg2, ucpu), 0, 15)
    res := val & (u16(1) << bidx)
    if res == 0 {
        set_flag(ucpu, .Z)
    } else {
        reset_flag(ucpu, .Z)
    }
    return InstErrorNone{}
}

inst_shl16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u16(&arg_list^.Arg2, ucpu)
    res := val << amt
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, res)
    return InstErrorNone{}
}

inst_asr16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u16(&arg_list^.Arg2, ucpu)
    res := transmute(i16)val >> amt
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, transmute(u16)res)
    return InstErrorNone{}
}

inst_lsr16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u16(&arg_list^.Arg2, ucpu)
    res := val >> amt
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, res)
    return InstErrorNone{}
}

inst_rtl16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u16(&arg_list^.Arg2, ucpu)
    for _ in 0 ..< amt {
        val = _rotate_left(val)
    }
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_rtr16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u16(&arg_list^.Arg2, ucpu)
    for _ in 0 ..< amt {
        val = _rotate_right(val)
    }
    // TODO: Set Flags
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_rlc16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u16(&arg_list^.Arg2, ucpu)
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
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_rrc16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u16(&arg_list^.Arg2, ucpu)
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
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_cmp16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    rhs := InstArg_get_u16(&arg_list^.Arg2, ucpu)

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

    return InstErrorNone{}
}

inst_psh16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u16(&arg_list^.Arg1, ucpu)
    Cpu_push(ucpu, val)
    return InstErrorNone{}
}

inst_pop16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    Cpu_pop_u16(ucpu)
    return InstErrorNone{}
}

inst_pek16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := Cpu_top_u16(ucpu)
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_pko16 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := Cpu_top_u16_with_offset(ucpu, InstArg_get_u32(&arg_list^.Arg2, ucpu))
    InstArg_set_u16(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}
