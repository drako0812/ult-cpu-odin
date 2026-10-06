package ult_cpu

inst_inc8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    accum := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    accum += 1
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)accum)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_dec8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    accum := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    accum -= 1
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)accum)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_add8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    lhs += rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_sub8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    lhs -= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_mul8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs *= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_mls8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]i8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([4]i8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs *= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_div8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs /= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_dvs8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]i8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([4]i8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs /= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_mod8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs %= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_mds8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]i8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([4]i8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs %= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_dvm8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    rhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg3, ucpu)
    d := lhs / rhs
    m := lhs % rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)d)
    InstArg_set_u32(&arg_list^.Arg2, ucpu, transmute(u32)m)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_dms8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]i8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    rhs := transmute([4]i8)InstArg_get_u32(&arg_list^.Arg3, ucpu)
    d := lhs / rhs
    m := lhs % rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)d)
    InstArg_set_u32(&arg_list^.Arg2, ucpu, transmute(u32)m)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_rem8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs %%= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_rms8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]i8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([4]i8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs %%= rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_dvr8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    rhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg3, ucpu)
    d := lhs / rhs
    m := lhs %% rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)d)
    InstArg_set_u32(&arg_list^.Arg2, ucpu, transmute(u32)m)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_drs8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]i8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    rhs := transmute([4]i8)InstArg_get_u32(&arg_list^.Arg3, ucpu)
    d := lhs / rhs
    m := lhs %% rhs
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)d)
    InstArg_set_u32(&arg_list^.Arg2, ucpu, transmute(u32)m)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_bst8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    bidx := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    bidx[0] = clamp(bidx[0], 0, 7)
    bidx[1] = clamp(bidx[1], 0, 7)
    bidx[2] = clamp(bidx[2], 0, 7)
    bidx[3] = clamp(bidx[3], 0, 7)
    lhs[0] |= u8(1) << bidx[0]
    lhs[1] |= u8(1) << bidx[1]
    lhs[2] |= u8(1) << bidx[2]
    lhs[3] |= u8(1) << bidx[3]
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_brs8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    bidx := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    bidx[0] = clamp(bidx[0], 0, 7)
    bidx[1] = clamp(bidx[1], 0, 7)
    bidx[2] = clamp(bidx[2], 0, 7)
    bidx[3] = clamp(bidx[3], 0, 7)
    lhs[0] &= ~(u8(1) << bidx[0])
    lhs[1] &= ~(u8(1) << bidx[1])
    lhs[2] &= ~(u8(1) << bidx[2])
    lhs[3] &= ~(u8(1) << bidx[3])
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_shl8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs[0] <<= rhs[0]
    lhs[1] <<= rhs[1]
    lhs[2] <<= rhs[2]
    lhs[3] <<= rhs[3]
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_asr8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]i8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs[0] >>= rhs[0]
    lhs[1] >>= rhs[1]
    lhs[2] >>= rhs[2]
    lhs[3] >>= rhs[3]
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_lsr8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    lhs[0] >>= rhs[0]
    lhs[1] >>= rhs[1]
    lhs[2] >>= rhs[2]
    lhs[3] >>= rhs[3]
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_rtl8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    for i in 0 ..< 4 {
        for _ in 0 ..< rhs[i] {
            lhs[i] = _rotate_left(lhs[i])
        }
    }
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}

inst_rtr8x4 :: proc(ucpu: ^Cpu, arg_list: ^ArgList) -> InstError {
    lhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg1, ucpu)
    rhs := transmute([4]u8)InstArg_get_u32(&arg_list^.Arg2, ucpu)
    for i in 0 ..< 4 {
        for _ in 0 ..< rhs[i] {
            lhs[i] = _rotate_right(lhs[i])
        }
    }
    InstArg_set_u32(&arg_list^.Arg1, ucpu, transmute(u32)lhs)
    // TODO: Set Flags
    return InstErrorNone{}
}
