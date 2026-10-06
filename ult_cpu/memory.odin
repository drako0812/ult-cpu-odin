package ult_cpu

import "core:mem"

Read8Proc :: proc(self: ^Mem, ucpu: ^Cpu, addr: u32) -> u8
Write8Proc :: proc(self: ^Mem, ucpu: ^Cpu, addr: u32, val: u8)

IMem :: struct {
    read8:      Read8Proc,
    read8_raw:  Read8Proc,
    write8:     Write8Proc,
    write8_raw: Write8Proc,
}

/*
To add a new Mem type you need to define the following:

- `I<MemTypeName>` struct with `using mem: IMem`
- Add `I<MemTypeName>` to Mem union
- `<MemTypeName>` proc that returns `I<MemTypeName>`
- Add to type switch in `get_imem` proc.
*/

IDefaultMem :: struct {
    data:      [dynamic]u8,
    using mem: IMem,
}

Mem :: union {
    IDefaultMem,
}

make_data :: proc(size: u64) -> [dynamic]u8 {
    ret := make([dynamic]u8, size)
    mem.zero_slice(ret[:])
    return ret
}

DefaultMem :: proc(size: u64) -> IDefaultMem {
    return IDefaultMem {
        data = make_data(size),
        read8 = proc(self: ^Mem, ucpu: ^Cpu, addr: u32) -> u8 {
            dmem := self.(IDefaultMem)
            raddr := int(addr) % len(dmem.data)
            ucpu^.ticks += 1
            return dmem.data[raddr]
        },
        read8_raw = proc(self: ^Mem, ucpu: ^Cpu, addr: u32) -> u8 {
            dmem := self.(IDefaultMem)
            raddr := int(addr) % len(dmem.data)
            return dmem.data[raddr]
        },
        write8 = proc(self: ^Mem, ucpu: ^Cpu, addr: u32, val: u8) {
            dmem := self.(IDefaultMem)
            raddr := int(addr) % len(dmem.data)
            ucpu^.ticks += 2
            dmem.data[raddr] = val
        },
        write8_raw = proc(self: ^Mem, ucpu: ^Cpu, addr: u32, val: u8) {
            dmem := self.(IDefaultMem)
            raddr := int(addr) % len(dmem.data)
            dmem.data[raddr] = val
        },
    }
}

get_imem :: proc(mem: ^Mem) -> ^IMem {
    switch &m in mem {
    case IDefaultMem: return &m.mem
    }
    return nil
}

default_mem_release :: proc(dmem: ^IDefaultMem) {
    delete(dmem^.data)
}

read8 :: proc(mem: ^Mem, ucpu: ^Cpu, addr: u32) -> u8 {
    return get_imem(mem)^.read8(mem, ucpu, addr)
}
read8_raw :: proc(mem: ^Mem, ucpu: ^Cpu, addr: u32) -> u8 {
    return get_imem(mem)^.read8_raw(mem, ucpu, addr)
}
read16 :: proc(mem: ^Mem, ucpu: ^Cpu, addr: u32) -> u16 {
    h := u16(read8(mem, ucpu, addr))
    l := u16(read8(mem, ucpu, addr + 1))
    ret := (h << 8) | l
    return ret
}
read16_raw :: proc(mem: ^Mem, ucpu: ^Cpu, addr: u32) -> u16 {
    h := u16(read8_raw(mem, ucpu, addr))
    l := u16(read8_raw(mem, ucpu, addr + 1))
    ret := (h << 8) | l
    return ret
}
read32 :: proc(mem: ^Mem, ucpu: ^Cpu, addr: u32) -> u32 {
    h := u32(read16(mem, ucpu, addr))
    l := u32(read16(mem, ucpu, addr + 2))
    ret := (h << 16) | l
    return ret
}
read32_raw :: proc(mem: ^Mem, ucpu: ^Cpu, addr: u32) -> u32 {
    h := u32(read16_raw(mem, ucpu, addr))
    l := u32(read16_raw(mem, ucpu, addr + 2))
    ret := (h << 16) | l
    return ret
}

write8 :: proc(mem: ^Mem, ucpu: ^Cpu, addr: u32, val: u8) {
    get_imem(mem)^.write8(mem, ucpu, addr, val)
}
write8_raw :: proc(mem: ^Mem, ucpu: ^Cpu, addr: u32, val: u8) {
    get_imem(mem)^.write8_raw(mem, ucpu, addr, val)
}
write16 :: proc(mem: ^Mem, ucpu: ^Cpu, addr: u32, val: u16) {
    write8(mem, ucpu, addr, u8((val >> 8) & 0x00FF))
    write8(mem, ucpu, addr + 1, u8(val & 0x00FF))
}
write16_raw :: proc(mem: ^Mem, ucpu: ^Cpu, addr: u32, val: u16) {
    write8_raw(mem, ucpu, addr, u8((val >> 8) & 0x00FF))
    write8_raw(mem, ucpu, addr + 1, u8(val & 0x00FF))
}
write32 :: proc(mem: ^Mem, ucpu: ^Cpu, addr: u32, val: u32) {
    write16(mem, ucpu, addr, u16((val >> 16) & 0x0000FFFF))
    write16(mem, ucpu, addr + 2, u16(val & 0x0000FFFF))
}
write32_raw :: proc(mem: ^Mem, ucpu: ^Cpu, addr: u32, val: u32) {
    write16_raw(mem, ucpu, addr, u16((val >> 16) & 0x0000FFFF))
    write16_raw(mem, ucpu, addr + 2, u16(val & 0x0000FFFF))
}
