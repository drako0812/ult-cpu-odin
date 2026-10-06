package ult_cpu

inst_mov8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    InstArg_set_u8(&arg_list^.Arg1, ucpu, InstArg_get_u8(&arg_list^.Arg2, ucpu))
    return InstErrorNone{}
}

inst_lod8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    src := InstArg_get_u32(&arg_list^.Arg2, ucpu)
    val := read8(&ucpu^.mem, ucpu, src)
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_sto8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    src := InstArg_get_u8(&arg_list^.Arg2, ucpu)
    daddr := InstArg_get_u32(&arg_list^.Arg1, ucpu)
    write8(&ucpu^.mem, ucpu, daddr, src)
    return InstErrorNone{}
}

inst_inc8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    InstArg_set_u8(&arg_list^.Arg1, ucpu, InstArg_get_u8(&arg_list^.Arg1, ucpu) + 1)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_icc8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    val += 1
    if test_flag(ucpu, .CA) {
        val += 1
    }
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_dec8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    InstArg_set_u8(&arg_list^.Arg1, ucpu, InstArg_get_u8(&arg_list^.Arg1, ucpu) - 1)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_dcb8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    val -= 1
    if test_flag(ucpu, .CA) {
        val -= 1
    }
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_add8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    InstArg_set_u8(&arg_list^.Arg1, ucpu, InstArg_get_u8(&arg_list^.Arg1, ucpu) + InstArg_get_u8(&arg_list^.Arg2, ucpu))
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_adc8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    val += InstArg_get_u8(&arg_list^.Arg2, ucpu)
    if test_flag(ucpu, .CA) {
        val += 1
    }
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_sub8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    InstArg_set_u8(&arg_list^.Arg1, ucpu, InstArg_get_u8(&arg_list^.Arg1, ucpu) - InstArg_get_u8(&arg_list^.Arg2, ucpu))
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_sbb8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    val -= InstArg_get_u8(&arg_list^.Arg2, ucpu)
    if test_flag(ucpu, .CA) {
        val -= 1
    }
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_mul8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := u16(InstArg_get_u8(&arg_list^.Arg1, ucpu))
    val *= u16(InstArg_get_u8(&arg_list^.Arg3, ucpu))
    a1 := u8((val & 0xFF00) >> 8)
    a2 := u8(val & 0x00FF)
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, a1)
    InstArg_set_u8(&arg_list^.Arg2, ucpu, a2)
    return InstErrorNone{}
}

inst_mls8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i16)u16(InstArg_get_u8(&arg_list^.Arg1, ucpu))
    val *= transmute(i16)u16(InstArg_get_u8(&arg_list^.Arg3, ucpu))
    a1 := u8((transmute(u16)val & 0xFF00) >> 8)
    a2 := u8(transmute(u16)val & 0x00FF)
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, a1)
    InstArg_set_u8(&arg_list^.Arg2, ucpu, a2)
    return InstErrorNone{}
}

inst_div8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    val /= InstArg_get_u8(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_dvs8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i8)InstArg_get_u8(&arg_list^.Arg1, ucpu)
    val /= transmute(i8)InstArg_get_u8(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, transmute(u8)val)
    return InstErrorNone{}
}

inst_mod8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    val %= InstArg_get_u8(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_mds8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i8)InstArg_get_u8(&arg_list^.Arg1, ucpu)
    val %= transmute(i8)InstArg_get_u8(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, transmute(u8)val)
    return InstErrorNone{}
}

inst_dvm8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    a1 := val / InstArg_get_u8(&arg_list^.Arg3, ucpu)
    a2 := val % InstArg_get_u8(&arg_list^.Arg3, ucpu)
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, a1)
    InstArg_set_u8(&arg_list^.Arg2, ucpu, a2)
    return InstErrorNone{}
}

inst_dms8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i8)InstArg_get_u8(&arg_list^.Arg1, ucpu)
    a1 := val / transmute(i8)InstArg_get_u8(&arg_list^.Arg3, ucpu)
    a2 := val % transmute(i8)InstArg_get_u8(&arg_list^.Arg3, ucpu)
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, transmute(u8)a1)
    InstArg_set_u8(&arg_list^.Arg2, ucpu, transmute(u8)a2)
    return InstErrorNone{}
}

inst_rem8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    val %%= InstArg_get_u8(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_rms8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i8)InstArg_get_u8(&arg_list^.Arg1, ucpu)
    val %%= transmute(i8)InstArg_get_u8(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, transmute(u8)val)
    return InstErrorNone{}
}

inst_dvr8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    a1 := val / InstArg_get_u8(&arg_list^.Arg3, ucpu)
    a2 := val %% InstArg_get_u8(&arg_list^.Arg3, ucpu)
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, a1)
    InstArg_set_u8(&arg_list^.Arg2, ucpu, a2)
    return InstErrorNone{}
}

inst_drs8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := transmute(i8)InstArg_get_u8(&arg_list^.Arg1, ucpu)
    a1 := val / transmute(i8)InstArg_get_u8(&arg_list^.Arg3, ucpu)
    a2 := val %% transmute(i8)InstArg_get_u8(&arg_list^.Arg3, ucpu)
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, transmute(u8)a1)
    InstArg_set_u8(&arg_list^.Arg2, ucpu, transmute(u8)a2)
    return InstErrorNone{}
}

inst_cpl8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    val = ~val
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_and8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    val &= InstArg_get_u8(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_ior8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    val |= InstArg_get_u8(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_xor8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    val ~= InstArg_get_u8(&arg_list^.Arg2, ucpu)
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_bst8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    bidx := clamp(InstArg_get_u8(&arg_list^.Arg2, ucpu), 0, 7)
    val |= u8(1) << bidx
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_brs8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    bidx := clamp(InstArg_get_u8(&arg_list^.Arg2, ucpu), 0, 7)
    val &= ~(u8(1) << bidx)
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_bts8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    bidx := clamp(InstArg_get_u8(&arg_list^.Arg2, ucpu), 0, 7)
    res := val & (u8(1) << bidx)
    if res == 0 {
        set_flag(ucpu, .Z)
    } else {
        reset_flag(ucpu, .Z)
    }
    return InstErrorNone{}
}

inst_shl8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u8(&arg_list^.Arg2, ucpu)
    res := val << amt
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, res)
    return InstErrorNone{}
}

inst_asr8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u8(&arg_list^.Arg2, ucpu)
    res := transmute(i8)val >> amt
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, transmute(u8)res)
    return InstErrorNone{}
}

inst_lsr8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u8(&arg_list^.Arg2, ucpu)
    res := val >> amt
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, res)
    return InstErrorNone{}
}

inst_rtl8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u8(&arg_list^.Arg2, ucpu)
    for _ in 0 ..< amt {
        val = _rotate_left(val)
    }
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_rtr8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u8(&arg_list^.Arg2, ucpu)
    for _ in 0 ..< amt {
        val = _rotate_right(val)
    }
    // TODO: Set Flags
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_rlc8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u8(&arg_list^.Arg2, ucpu)
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
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_rrc8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    amt := InstArg_get_u8(&arg_list^.Arg2, ucpu)
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
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_cmp8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    rhs := InstArg_get_u8(&arg_list^.Arg2, ucpu)

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

inst_psh8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := InstArg_get_u8(&arg_list^.Arg1, ucpu)
    Cpu_push(ucpu, val)
    return InstErrorNone{}
}

inst_pop8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    Cpu_pop_u8(ucpu)
    return InstErrorNone{}
}

inst_pek8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := Cpu_top_u8(ucpu)
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}

inst_pko8 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    val := Cpu_top_u8_with_offset(ucpu, InstArg_get_u32(&arg_list^.Arg2, ucpu))
    InstArg_set_u8(&arg_list^.Arg1, ucpu, val)
    return InstErrorNone{}
}
