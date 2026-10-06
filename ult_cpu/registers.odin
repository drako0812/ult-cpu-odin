package ult_cpu

Regs :: struct #raw_union {
    __data: [0x16 * 4]u8,
    r32: struct #packed {
        AB, CD, EF, GH: u32be,
        IJ, XY, PC, SP: u32be,
        SF, ST, KL, MN: u32be,
        OP, QR, UV, r01: u32be,
        r02, r03, r04, r05: u32be,
        r06, r07: u32be,
    },
    r16: struct #packed {
        A, B, C, D, E, F, G, H: u16be,
        I, J, Y, X, __PCh, __PCl, __SPh, __SPl: u16be,
        __SFh, __SFl, __STh, __STl, L, K, N, M: u16be,
        P, O, R, Q, V, __U, __r01h, r01l: u16be,
    },
    r8: struct #packed {
        Ah, Al, Bh, Bl: u8,
        Ch, Cl, Dh, Dl: u8,
        Eh, El, Fh, Fl: u8,
        Gh, Gl, Hh, Hl: u8,
        __Ih, Il, Jh, Jl: u8,
        __Xh, Xl, Yh, Yl: u8,
    }
}

get_reg32 :: proc(regs: ^Regs, idx: u8) -> ^u32be {
    assert(idx < 22)
    switch idx {
    case  0: return &(regs^.r32.AB)
    case  1: return &(regs^.r32.CD)
    case  2: return &(regs^.r32.EF)
    case  3: return &(regs^.r32.GH)
    case  4: return &(regs^.r32.IJ)
    case  5: return &(regs^.r32.XY)
    case  6: return &(regs^.r32.PC)
    case  7: return &(regs^.r32.SP)
    case  8: return &(regs^.r32.SF)
    case  9: return &(regs^.r32.ST)
    case 10: return &(regs^.r32.KL)
    case 11: return &(regs^.r32.MN)
    case 12: return &(regs^.r32.OP)
    case 13: return &(regs^.r32.QR)
    case 14: return &(regs^.r32.UV)
    case 15: return &(regs^.r32.r01)
    case 16: return &(regs^.r32.r02)
    case 17: return &(regs^.r32.r03)
    case 18: return &(regs^.r32.r04)
    case 19: return &(regs^.r32.r05)
    case 20: return &(regs^.r32.r06)
    case 21: return &(regs^.r32.r07)
    case: assert(false)
        return nil
    }
}

get_reg16 :: proc(regs: ^Regs, idx: u8) -> ^u16be {
    assert(idx < 22)
    switch idx {
    case  0: return &(regs^.r16.A)
    case  1: return &(regs^.r16.C)
    case  2: return &(regs^.r16.E)
    case  3: return &(regs^.r16.G)
    case  4: return &(regs^.r16.I)
    case  5: return &(regs^.r16.X)
    case  6: return &(regs^.r16.K)
    case  7: return &(regs^.r16.M)
    case  8: return &(regs^.r16.O)
    case  9: return &(regs^.r16.Q)
    case 10: return &(regs^.r16.B)
    case 11: return &(regs^.r16.D)
    case 12: return &(regs^.r16.F)
    case 13: return &(regs^.r16.H)
    case 14: return &(regs^.r16.J)
    case 15: return &(regs^.r16.Y)
    case 16: return &(regs^.r16.L)
    case 17: return &(regs^.r16.N)
    case 18: return &(regs^.r16.P)
    case 19: return &(regs^.r16.R)
    case 20: return &(regs^.r16.V)
    case 21: return &(regs^.r16.r01l)
    case: assert(false)
        return nil
    }
}

get_reg8 :: proc(regs: ^Regs, idx: u8) -> ^u8 {
    assert(idx < 22)
    switch idx {
    case  0: return &(regs^.r8.Al)
    case  1: return &(regs^.r8.Cl)
    case  2: return &(regs^.r8.El)
    case  3: return &(regs^.r8.Gl)
    case  4: return &(regs^.r8.Il)
    case  5: return &(regs^.r8.Xl)
    case  6: return &(regs^.r8.Ah)
    case  7: return &(regs^.r8.Ch)
    case  8: return &(regs^.r8.Eh)
    case  9: return &(regs^.r8.Gh)
    case 10: return &(regs^.r8.Bl)
    case 11: return &(regs^.r8.Dl)
    case 12: return &(regs^.r8.Fl)
    case 13: return &(regs^.r8.Hl)
    case 14: return &(regs^.r8.Jl)
    case 15: return &(regs^.r8.Yl)
    case 16: return &(regs^.r8.Bh)
    case 17: return &(regs^.r8.Dh)
    case 18: return &(regs^.r8.Fh)
    case 19: return &(regs^.r8.Hh)
    case 20: return &(regs^.r8.Jh)
    case 21: return &(regs^.r8.Yh)
    case: assert(false)
        return nil
    }
}
