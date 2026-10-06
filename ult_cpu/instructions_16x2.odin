package ult_cpu

inst_inc16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    accum := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    accum += 1
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)accum)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_dec16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    accum := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    accum -= 1
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)accum)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_add16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    lhs += rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_sub16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    lhs -= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_mul16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs *= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_mls16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]i16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([2]i16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs *= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_div16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs /= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_dvs16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]i16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([2]i16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs /= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_mod16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs %= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_mds16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]i16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([2]i16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs %= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_dvm16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    rhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg3, ucpu)
    d := lhs / rhs
    m := lhs % rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)d)
    InstArg_set_u32(&arg_list^.Arg2, ucpu, transmute(u32)m)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_dms16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]i16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    rhs := transmute([2]i16)InstArg_get_u32(&arg_list^.Arg3, ucpu)
    d := lhs / rhs
    m := lhs % rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)d)
    InstArg_set_u32(&arg_list^.Arg2, ucpu, transmute(u32)m)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_rem16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs %%= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_rms16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]i16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([2]i16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs %%= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_dvr16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    rhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg3, ucpu)
    d := lhs / rhs
    m := lhs %% rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)d)
    InstArg_set_u32(&arg_list^.Arg2, ucpu, transmute(u32)m)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_drs16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]i16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    rhs := transmute([2]i16)InstArg_get_u32(&arg_list^.Arg3, ucpu)
    d := lhs / rhs
    m := lhs %% rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)d)
    InstArg_set_u32(&arg_list^.Arg2, ucpu, transmute(u32)m)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_bst16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    bidx := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    bidx[0] = clamp(bidx[0], 0, 15)
    bidx[1] = clamp(bidx[1], 0, 15)
    lhs[0] |= u16(1) << bidx[0]
    lhs[1] |= u16(1) << bidx[1]
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_brs16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    bidx := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    bidx[0] = clamp(bidx[0], 0, 15)
    bidx[1] = clamp(bidx[1], 0, 15)
    lhs[0] &= ~(u16(1) << bidx[0])
    lhs[1] &= ~(u16(1) << bidx[1])
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_shl16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs[0] <<= rhs[0]
    lhs[1] <<= rhs[1]
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_asr16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]i16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs[0] >>= rhs[0]
    lhs[1] >>= rhs[1]
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_lsr16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs[0] >>= rhs[0]
    lhs[1] >>= rhs[1]
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_rtl16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    for i in 0 ..< 2 {
        for _ in 0 ..< rhs[i] {
            lhs[i] = _rotate_left(lhs[i])
        }
    }
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_rtr16x2 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([2]u16)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    for i in 0 ..< 2 {
        for _ in 0 ..< rhs[i] {
            lhs[i] = _rotate_right(lhs[i])
        }
    }
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}
