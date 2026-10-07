package ult_cpu

import "base:intrinsics"
import "core:fmt"
import "core:os"

OnPortWriteProc :: #type proc(ucpu: ^Cpu, port: u16, value: u8)
OnPortReadProc :: #type proc(ucpu: ^Cpu, port: u16) -> u8

Cpu :: struct {
    regs:              Regs,
    mem:               Mem,
    io:                IOData,
    int_table_enabled: bool,
    int_table_loc:     u32,
    int_mask_enabled:  bool,
    int_mask_loc:      u32,
    instruction_sz:    u32,
    ticks:             u64,
    on_port_write:     OnPortWriteProc,
    on_port_read:      OnPortReadProc,
}

InstData :: struct {
    OpCode:  OpCode,
    ArgList: ArgList,
    Data:    ^InstTableEntry,
}

get_arg_type :: proc(value: u8) -> AddrMode {
    return AddrMode(value)
}

// build_arg :: proc(ite: ^InstTableEntry, ucpu: ^Cpu, atype: AddrMode, anum: int, pc: u32) -> (arg: InstArg, new_pc_offset: u32) {
//     npc := pc
//     switch ite^.ArgBits[anum - 1] {
//     case .B0: return nil, npc
//     case .B8: switch atype {
//             case .Imm: return ImmArg{value = cast(u32)read8(&ucpu^.mem, ucpu, npc)}, npc + 1
//             case .ImmPtr: return ImmPtrArg{value = read32(&ucpu^.mem, ucpu, npc)}, npc + 4
//             case .Reg: return RegArg{idx = read8(&ucpu^.mem, ucpu, npc)}, npc + 1
//             case .RegPtr: return RegPtrArg{idx = read8(&ucpu^.mem, ucpu, npc)}, npc + 1
//             case .ImmPlusReg: return ImmPlusRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .ImmPlusRegPtr: return ImmPlusRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .RegPlusReg: return RegPlusRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             case .RegPlusRegPtr: return RegPlusRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             case .ImmMinusReg: return ImmMinusRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .ImmMinusRegPtr: return ImmMinusRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .RegMinusReg: return RegMinusRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             case .RegMinusRegPtr: return RegMinusRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             case .ImmTimesReg: return ImmTimesRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .ImmTimesRegPtr: return ImmTimesRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .RegTimesReg: return RegTimesRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             case .RegTimesRegPtr: return RegTimesRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             }
//     case .B16: switch atype {
//             case .Imm: return ImmArg{value = cast(u32)read16(&ucpu^.mem, ucpu, npc)}, npc + 2
//             case .ImmPtr: return ImmPtrArg{value = read32(&ucpu^.mem, ucpu, npc)}, npc + 4
//             case .Reg: return RegArg{idx = read8(&ucpu^.mem, ucpu, npc)}, npc + 1
//             case .RegPtr: return RegPtrArg{idx = read8(&ucpu^.mem, ucpu, npc)}, npc + 1
//             case .ImmPlusReg: return ImmPlusRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .ImmPlusRegPtr: return ImmPlusRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .RegPlusReg: return RegPlusRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             case .RegPlusRegPtr: return RegPlusRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             case .ImmMinusReg: return ImmMinusRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .ImmMinusRegPtr: return ImmMinusRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .RegMinusReg: return RegMinusRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             case .RegMinusRegPtr: return RegMinusRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             case .ImmTimesReg: return ImmTimesRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .ImmTimesRegPtr: return ImmTimesRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .RegTimesReg: return RegTimesRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             case .RegTimesRegPtr: return RegTimesRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             }
//     case .B32: switch atype {
//             case .Imm: return ImmArg{value = read32(&ucpu^.mem, ucpu, npc)}, npc + 4
//             case .ImmPtr: return ImmPtrArg{value = read32(&ucpu^.mem, ucpu, npc)}, npc + 4
//             case .Reg: return RegArg{idx = read8(&ucpu^.mem, ucpu, npc)}, npc + 1
//             case .RegPtr: return RegPtrArg{idx = read8(&ucpu^.mem, ucpu, npc)}, npc + 1
//             case .ImmPlusReg: return ImmPlusRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .ImmPlusRegPtr: return ImmPlusRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .RegPlusReg: return RegPlusRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             case .RegPlusRegPtr: return RegPlusRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             case .ImmMinusReg: return ImmMinusRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .ImmMinusRegPtr: return ImmMinusRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .RegMinusReg: return RegMinusRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             case .RegMinusRegPtr: return RegMinusRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             case .ImmTimesReg: return ImmTimesRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .ImmTimesRegPtr: return ImmTimesRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, npc + 5
//             case .RegTimesReg: return RegTimesRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             case .RegTimesRegPtr: return RegTimesRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, npc + 2
//             }
//     }
//     assert(false, "Unreachable")
//     return nil, npc
// }

build_arg :: proc(ite: ^InstTableEntry, ucpu: ^Cpu, atype: AddrMode, anum: int, pc: u32) -> (arg: InstArg, new_pc_offset: u32) {
    npc := pc
    switch ite^.ArgBits[anum - 1] {
    case .B0: return nil, 0
    case .B8: switch atype {
            case .Imm: return ImmArg{value = cast(u32)read8(&ucpu^.mem, ucpu, npc)}, 1
            case .ImmPtr: return ImmPtrArg{value = read32(&ucpu^.mem, ucpu, npc)}, 4
            case .Reg: return RegArg{idx = read8(&ucpu^.mem, ucpu, npc)}, 1
            case .RegPtr: return RegPtrArg{idx = read8(&ucpu^.mem, ucpu, npc)}, 1
            case .ImmPlusReg: return ImmPlusRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .ImmPlusRegPtr: return ImmPlusRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .RegPlusReg: return RegPlusRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            case .RegPlusRegPtr: return RegPlusRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            case .ImmMinusReg: return ImmMinusRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .ImmMinusRegPtr: return ImmMinusRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .RegMinusReg: return RegMinusRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            case .RegMinusRegPtr: return RegMinusRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            case .ImmTimesReg: return ImmTimesRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .ImmTimesRegPtr: return ImmTimesRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .RegTimesReg: return RegTimesRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            case .RegTimesRegPtr: return RegTimesRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            }
    case .B16: switch atype {
            case .Imm: return ImmArg{value = cast(u32)read16(&ucpu^.mem, ucpu, npc)}, 2
            case .ImmPtr: return ImmPtrArg{value = read32(&ucpu^.mem, ucpu, npc)}, 4
            case .Reg: return RegArg{idx = read8(&ucpu^.mem, ucpu, npc)}, 1
            case .RegPtr: return RegPtrArg{idx = read8(&ucpu^.mem, ucpu, npc)}, 1
            case .ImmPlusReg: return ImmPlusRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .ImmPlusRegPtr: return ImmPlusRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .RegPlusReg: return RegPlusRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            case .RegPlusRegPtr: return RegPlusRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            case .ImmMinusReg: return ImmMinusRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .ImmMinusRegPtr: return ImmMinusRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .RegMinusReg: return RegMinusRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            case .RegMinusRegPtr: return RegMinusRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            case .ImmTimesReg: return ImmTimesRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .ImmTimesRegPtr: return ImmTimesRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .RegTimesReg: return RegTimesRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            case .RegTimesRegPtr: return RegTimesRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            }
    case .B32: switch atype {
            case .Imm:
                ret := ImmArg {
                    value = read32(&ucpu^.mem, ucpu, npc),
                }
                return ret, 4
            case .ImmPtr:
                ret := ImmPtrArg {
                    value = read32(&ucpu^.mem, ucpu, npc),
                }
                return ret, 4
            case .Reg: return RegArg{idx = read8(&ucpu^.mem, ucpu, npc)}, 1
            case .RegPtr: return RegPtrArg{idx = read8(&ucpu^.mem, ucpu, npc)}, 1
            case .ImmPlusReg: return ImmPlusRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .ImmPlusRegPtr: return ImmPlusRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .RegPlusReg: return RegPlusRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            case .RegPlusRegPtr: return RegPlusRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            case .ImmMinusReg: return ImmMinusRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .ImmMinusRegPtr: return ImmMinusRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .RegMinusReg: return RegMinusRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            case .RegMinusRegPtr: return RegMinusRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            case .ImmTimesReg: return ImmTimesRegArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .ImmTimesRegPtr: return ImmTimesRegPtrArg{value = read32(&ucpu^.mem, ucpu, npc), reg = read8(&ucpu^.mem, ucpu, npc + 4)}, 5
            case .RegTimesReg: return RegTimesRegArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            case .RegTimesRegPtr: return RegTimesRegPtrArg{reg1 = read8(&ucpu^.mem, ucpu, npc), reg2 = read8(&ucpu^.mem, ucpu, npc + 1)}, 2
            }
    }
    assert(false, "Unreachable")
    return nil, npc
}

Cpu_quick_fetch :: proc(ucpu: ^Cpu) -> ^InstTableEntry {
    pc := u32(ucpu^.regs.r32.PC)
    inst_int := read16_raw(&ucpu^.mem, ucpu, pc)
    inst := OpCode(inst_int)
    if _, it_ok := InstTable[inst]; it_ok {
        return &InstTable[inst]
    }
    return nil
}

Cpu_fetch_instruction :: proc(ucpu: ^Cpu) -> (idata: InstData, pc: u32, ok: bool) {
    pc = u32(ucpu^.regs.r32.PC)
    /*if (pc >= 0x0A) && (pc < 0x45) {
        fmt.printfln("STRCPY: %08X", pc)
    }*/
    inst_int := read16(&ucpu^.mem, ucpu, pc)
    inst := OpCode(inst_int)
    if ite, it_ok := InstTable[inst]; it_ok {
        // Move PC foreword 2 bytes
        pc += 2

        idata = InstData{}
        idata.OpCode = inst
        idata.ArgList = ArgList{}

        // Now check for argument types and their data
        argc := ite.ArgCount
        arg_byte1 := read8(&ucpu^.mem, ucpu, pc)
        arg_byte2 := read8(&ucpu^.mem, ucpu, pc + 1)
        pc_offset: u32 = 0 if argc == 0 else (1 if argc < 3 else 2)
        for arg_idx in 0 ..< argc {
            switch arg_idx {
            case 0:
                arg1type := get_arg_type(arg_byte1 >> 4)
                if arg1type in ite.Args.Arg1 {
                    new_pc_offset: u32 = 0
                    idata.ArgList.Arg1, new_pc_offset = build_arg(&ite, ucpu, arg1type, 1, pc + pc_offset)
                    pc_offset += new_pc_offset
                } else {
                    return InstData{}, pc, false
                }
            case 1:
                arg2type := get_arg_type(arg_byte1 & 0x0F)
                if arg2type in ite.Args.Arg2 {
                    new_pc_offset: u32 = 0
                    idata.ArgList.Arg2, new_pc_offset = build_arg(&ite, ucpu, arg2type, 2, pc + pc_offset)
                    pc_offset += new_pc_offset
                } else {
                    return InstData{}, pc, false
                }
            case 2:
                arg3type := get_arg_type(arg_byte2 >> 4)
                if arg3type in ite.Args.Arg3 {
                    new_pc_offset: u32 = 0
                    idata.ArgList.Arg3, new_pc_offset = build_arg(&ite, ucpu, arg3type, 3, pc + pc_offset)
                    pc_offset += new_pc_offset
                } else {
                    return InstData{}, pc, false
                }
            case 3:
                arg4type := get_arg_type(arg_byte2 & 0x0F)
                if arg4type in ite.Args.Arg4 {
                    new_pc_offset: u32 = 0
                    idata.ArgList.Arg4, new_pc_offset = build_arg(&ite, ucpu, arg4type, 4, pc + pc_offset)
                    pc_offset += new_pc_offset
                } else {
                    return InstData{}, pc, false
                }
            }
        }

        idata.Data = &InstTable[inst]
        real_pc := u32(ucpu^.regs.r32.PC)
        ucpu^.instruction_sz = (pc + pc_offset) - real_pc
        //stk_top := read32_raw(&ucpu^.mem, ucpu, u32(ucpu^.regs.r32.SP))
        //fmt.printfln("OPC: %08X, NPC: %08X, STOP: %08X, SZ: %v", real_pc, pc + pc_offset, stk_top, ucpu^.instruction_sz)
        return idata, pc + pc_offset, true
    } else {
        return InstData{}, pc, false
    }
}

Cpu_tick :: proc(ucpu: ^Cpu) {
    idata, new_pc, ok := Cpu_fetch_instruction(ucpu)
    assert(ok, "Unable to fetch instruction")

    err := idata.Data^.Proc(ucpu, &idata.ArgList)

    if !idata.Data^.HandlesPC {
        ucpu^.regs.r32.PC = u32be(new_pc)
    }

    // TODO: Don't assume any instructions have 0 for BaseTicks. We disabled this because BaseTicks was coming back as an insane number.
    //ucpu^.ticks += idata.Data^.BaseTicks
    // if ucpu^.ticks >= 1000 {
    //     fmt.printfln("Excessive Ticks: Cpu_tick: %v", ucpu^.ticks)
    // }

    switch _ in err {
    case InstErrorNone: break
    case InstErrorHalt, InstErrorDebugBreak, InstErrorWithMessage: assert(false, "Halting Execution")
    }
}

// Returns the number of ticks executed in the frame
Cpu_frame :: proc(ucpu: ^Cpu, ticks_per_frame: u64) -> u64 {
    for ucpu^.ticks < ticks_per_frame {
        //fmt.printf("%08X ", u32(ucpu^.regs.r32.PC))
        prev_ticks := ucpu^.ticks
        Cpu_tick(ucpu)
        io_update(ucpu, ucpu^.ticks - prev_ticks)
    }
    ret := ucpu^.ticks
    ucpu^.ticks = ucpu^.ticks - ticks_per_frame
    return ret
}

Cpu_next_pc :: proc(ucpu: ^Cpu) -> u32 {
    return u32(ucpu^.regs.r32.PC) + ucpu^.instruction_sz
}

Cpu_push :: proc {
    Cpu_push_u8,
    Cpu_push_u16,
    Cpu_push_u32,
}

Cpu_push_u8 :: proc(ucpu: ^Cpu, val: u8) {
    sp := i64(u32(ucpu^.regs.r32.SP))
    sp -= 1
    if sp == -1 {
        sp = 0x800000 - 1 // TODO: Remove hard-coded value
    }
    write8(&ucpu^.mem, ucpu, u32(sp), val)
    ucpu^.regs.r32.SP = u32be(u32(sp))
}

Cpu_push_u16 :: proc(ucpu: ^Cpu, val: u16) {
    high := u8((val & 0xFF00) >> 8)
    low := u8(val & 0x00FF)
    Cpu_push(ucpu, low)
    Cpu_push(ucpu, high)
}

Cpu_push_u32 :: proc(ucpu: ^Cpu, val: u32) {
    high := u16((val & 0xFFFF0000) >> 16)
    low := u16(val & 0x0000FFFF)
    Cpu_push(ucpu, low)
    Cpu_push(ucpu, high)
}

Cpu_pop_u8 :: proc(ucpu: ^Cpu) -> u8 {
    ret := Cpu_top_u8(ucpu)
    sp := i64(u32(ucpu^.regs.r32.SP))
    sp += 1
    if sp == 0x800000 {     // TODO: Remove hard-coded value
        sp = 0
    }
    ucpu^.regs.r32.SP = u32be(u32(sp))

    return ret
}

Cpu_pop_u16 :: proc(ucpu: ^Cpu) -> u16 {
    high := u16(Cpu_pop_u8(ucpu))
    low := u16(Cpu_pop_u8(ucpu))
    return (high << 8) | low
}

Cpu_pop_u32 :: proc(ucpu: ^Cpu) -> u32 {
    high := u32(Cpu_pop_u16(ucpu))
    low := u32(Cpu_pop_u16(ucpu))
    return (high << 16) | low
}

Cpu_top_u8 :: proc(ucpu: ^Cpu) -> u8 {
    sp := u32(ucpu^.regs.r32.SP)
    return read8(&ucpu^.mem, ucpu, sp)
}

Cpu_top_u16 :: proc(ucpu: ^Cpu) -> u16 {
    high := u16(Cpu_top_u8(ucpu))
    low := u16(Cpu_top_u8_with_offset(ucpu, 1))
    return (high << 8) | low
}

Cpu_top_u32 :: proc(ucpu: ^Cpu) -> u32 {
    high := u32(Cpu_top_u16(ucpu))
    low := u32(Cpu_top_u16_with_offset(ucpu, 2))
    return (high << 16) | low
}

Cpu_top_u8_with_offset :: proc(ucpu: ^Cpu, offset: u32) -> u8 {
    sp := u32(ucpu^.regs.r32.SP) + offset
    return read8(&ucpu^.mem, ucpu, sp)
}

Cpu_top_u16_with_offset :: proc(ucpu: ^Cpu, offset: u32) -> u16 {
    high := u16(Cpu_top_u8_with_offset(ucpu, offset))
    low := u16(Cpu_top_u8_with_offset(ucpu, offset + 1))
    return (high << 8) | low
}

Cpu_top_u32_with_offset :: proc(ucpu: ^Cpu, offset: u32) -> u32 {
    high := u32(Cpu_top_u16_with_offset(ucpu, offset))
    low := u32(Cpu_top_u16_with_offset(ucpu, offset + 2))
    return (high << 16) | low
}

Cpu_check_interrupt_mask :: proc(ucpu: ^Cpu, interrupt: u16) -> bool {
    // Get byte index
    byte_idx := u32(interrupt / 8)

    // Get bit index
    bit_idx := u32(interrupt % 8)

    // Get byte
    byte_ := read8(&ucpu^.mem, ucpu, ucpu^.int_mask_loc + byte_idx)

    // Get bit
    return (byte_ & (u8(1) << bit_idx)) != 0
}

// Returns `false` if the interrupt couldn't be triggered, `true` otherwise.
Cpu_trigger_interrupt :: proc(ucpu: ^Cpu, interrupt: u16) -> bool {
    // Check if interrupts are enabled.
    int_en := test_flag(ucpu, .I)
    if !int_en { return false }

    // Check if Interrupt Table is setup
    if !ucpu^.int_table_enabled { return false }
    int_vec := read32(&ucpu^.mem, ucpu, ucpu^.int_table_loc)

    // Check if Interrupt Mask is setup
    if !ucpu^.int_mask_enabled {
        // Always execute
        Cpu_push(ucpu, Cpu_next_pc(ucpu))
        dump_stack(ucpu)
        return true
    }

    // Check if Interrupt is enabled in Mask
    if Cpu_check_interrupt_mask(ucpu, interrupt) {
        Cpu_push(ucpu, Cpu_next_pc(ucpu))
        dump_stack(ucpu)
        return true
    }

    return false
}

// Memory-map
//
// Offset     | Size | Description
// -----------|------|------------
// 0x00000000 | 4    | Program Start Address
// 0x00000004 | 2    | NMI Code
// 0x00000006 | 4    | NMI Handler Address
// 0x0000000A | ...  | Program Memory (probably interrupt table followed by interrupt mask)

// Triggers Non-Maskable Interrupt
//
// **NOTE:** Jumps to address stored in address 0x00000006
Cpu_trigger_nmi :: proc(ucpu: ^Cpu, code: u16) -> bool {
    if test_flag(ucpu, .I2) {
        return false
    }
    set_flag(ucpu, .I2)

    // Store code to address 0x00000004
    write16(&ucpu^.mem, ucpu, 0x00000004, code)

    // Store PC
    Cpu_push(ucpu, Cpu_next_pc(ucpu))

    // Jump to address stored in 0x00000006
    addr := read32(&ucpu^.mem, ucpu, 0x00000006)
    ucpu^.regs.r32.PC = u32be(addr)

    dump_stack(ucpu)

    return true
}

Cpu_output :: proc(ucpu: ^Cpu, port: u16, value: u8) {
    if ucpu^.on_port_write != nil {
        ucpu^.on_port_write(ucpu, port, value)
    }
}

Cpu_input :: proc(ucpu: ^Cpu, port: u16) -> u8 {
    if ucpu^.on_port_read != nil {
        return ucpu^.on_port_read(ucpu, port)
    }
    return 0
}

Cpu_load_program :: proc(ucpu: ^Cpu, name: string) -> os.Error {
    data, err := os.read_entire_file_from_path(name, context.allocator)

    if err != nil {
        return err
    }

    defer delete(data)

    for i in 0 ..< len(data) {
        write8_raw(&ucpu^.mem, ucpu, u32(i), data[i])
    }

    return nil
}
