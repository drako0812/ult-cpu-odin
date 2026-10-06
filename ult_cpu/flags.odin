package ult_cpu

Flag :: enum u32 {
    Z  = 0b00000000000000000000000000000001, // Zero
    GT = 0b00000000000000000000000000000010, // Greater Than
    LT = 0b00000000000000000000000000000100, // Lesser Than
    EQ = 0b00000000000000000000000000001000, // Equal
    NE = 0b00000000000000000000000000010000, // Not Equal
    CA = 0b00000000000000000000000000100000, // Carry/Borrow
    OF = 0b00000000000000000000000001000000, // Overflow
    UF = 0b00000000000000000000000010000000, // Underflow
    I  = 0b00000000000000000000000100000000, // Interrupts enabled
    I2 = 0b00000000000000000000001000000000, // Non-maskable Interrupt Triggered
}

FlagEncReverseBit :: 0b10000000000000000000000000000000

FlagEnc :: enum u32 {
    Z = u32(Flag.Z),
    NZ = FlagEncReverseBit | u32(Flag.Z),
    GT = u32(Flag.GT),
    NGT = FlagEncReverseBit | u32(Flag.GT),
    LT = u32(Flag.LT),
    NLT = FlagEncReverseBit | u32(Flag.LT),
    EQ = u32(Flag.EQ),
    NE = u32(Flag.NE),
    CA = u32(Flag.CA),
    NCA = FlagEncReverseBit | u32(Flag.CA),
    OF = u32(Flag.OF),
    NOF = FlagEncReverseBit | u32(Flag.OF),
    UF = u32(Flag.UF),
    NUF = FlagEncReverseBit | u32(Flag.UF),
    I = u32(Flag.I),
    NI = FlagEncReverseBit | u32(Flag.I),
    I2 = u32(Flag.I2),
    NI2 = FlagEncReverseBit | u32(Flag.I2),
}

test_flag :: proc(ucpu: ^Cpu, flag: FlagEnc) -> bool {
    rST := u32(ucpu^.regs.r32.ST)
    switch flag {
    case .Z:   return (rST & u32(Flag.Z))  != 0
    case .NZ:  return (rST & u32(Flag.Z))  == 0
    case .GT:  return (rST & u32(Flag.GT)) != 0
    case .NGT: return (rST & u32(Flag.GT)) == 0
    case .LT:  return (rST & u32(Flag.LT)) != 0
    case .NLT: return (rST & u32(Flag.LT)) == 0
    case .EQ:  return (rST & u32(Flag.EQ)) != 0
    case .NE:  return (rST & u32(Flag.NE)) != 0
    case .CA:  return (rST & u32(Flag.CA)) != 0
    case .NCA: return (rST & u32(Flag.CA)) == 0
    case .OF:  return (rST & u32(Flag.OF)) != 0
    case .NOF: return (rST & u32(Flag.OF)) == 0
    case .UF:  return (rST & u32(Flag.UF)) != 0
    case .NUF: return (rST & u32(Flag.UF)) == 0
    case .I:   return (rST & u32(Flag.I))  != 0
    case .NI:  return (rST & u32(Flag.I))  == 0
    case .I2:  return (rST & u32(Flag.I2)) != 0
    case .NI2: return (rST & u32(Flag.I2)) == 0
    }
    return false
}
set_flag :: proc(ucpu: ^Cpu, flag: Flag) {
    rST := u32(ucpu^.regs.r32.ST)
    rST |= u32(flag)
    ucpu^.regs.r32.ST = u32be(rST)
}
reset_flag :: proc(ucpu: ^Cpu, flag: Flag) {
    rST := u32(ucpu^.regs.r32.ST)
    rST &= ~u32(flag)
    ucpu^.regs.r32.ST = u32be(rST)
}
