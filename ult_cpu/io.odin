package ult_cpu

IOData :: struct {
    wait_active:     bool,
    wait_accum_temp: u32,
    wait_accum:      u32,
}

IO_WAIT_PORT :: 0x100
IO_WAIT_TIME0 :: 0x101
IO_WAIT_TIME1 :: 0x102
IO_WAIT_TIME2 :: 0x103
IO_WAIT_TIME3 :: 0x104

io_write_port :: proc(ucpu: ^Cpu, port: u16, val: u8) {
    wait_accum_temp_arr := transmute([4]u8)ucpu^.io.wait_accum_temp
    switch port {
    case IO_WAIT_PORT:
        ucpu^.io.wait_accum = ucpu^.io.wait_accum_temp
        ucpu^.io.wait_active = true
    case IO_WAIT_TIME0: wait_accum_temp_arr[3] = val
    case IO_WAIT_TIME1: wait_accum_temp_arr[2] = val
    case IO_WAIT_TIME2: wait_accum_temp_arr[1] = val
    case IO_WAIT_TIME3: wait_accum_temp_arr[0] = val
    }
    ucpu^.io.wait_accum_temp = transmute(u32)wait_accum_temp_arr
}

io_read_port :: proc(ucpu: ^Cpu, port: u16) -> u8 {
    switch port {
    case IO_WAIT_PORT: return 1 if ucpu^.io.wait_active else 0
    }

    return 0
}

io_update :: proc(ucpu: ^Cpu, ticks: u64) {
    accum := i64(ucpu^.io.wait_accum)
    accum -= i64(ticks)
    if accum <= 0 {
        ucpu^.io.wait_active = false
        accum = 0
    }
    ucpu^.io.wait_accum = u32(accum)
}
