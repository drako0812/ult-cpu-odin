package main

import "./ult_cpu"
import "core:fmt"
import "vendor:raylib"

//ULT_CPU_HZ :: 10000000 // 10 MHz
ULT_CPU_HZ :: 1000000 // Defaulting to 1 MHz for now
//ULT_CPU_HZ :: 6000 // 6 KHz
//ULT_CPU_HZ :: 60 // 1 Tick per frame
FPS_HZ :: 60
ULT_CPU_TICKS_PER_FRAME :: (ULT_CPU_HZ / FPS_HZ) + 1

ULT_DBG_OUT_ADDR :: 0x600000
ULT_DBG_OUT_BYTES :: 256
ULT_DBG_OUT_LINE_LEN :: 64
ULT_DBG_OUT_LINES :: ULT_DBG_OUT_BYTES / ULT_DBG_OUT_LINE_LEN

draw_dbg_out :: proc(ucpu: ^ult_cpu.Cpu, font: raylib.Font, y: int) {
    addr := u32(ULT_DBG_OUT_ADDR)
    col := 0
    lin := 0
    for addr < (ULT_DBG_OUT_ADDR + ULT_DBG_OUT_BYTES) {
        val := ult_cpu.read8_raw(&ucpu^.mem, ucpu, addr)
        raylib.DrawTextCodepoint(font, ult_cpu.CP437_TO_RUNE_TABLE[val], raylib.Vector2{f32(col * 8), f32(y + (lin * 8))}, 8, raylib.RAYWHITE)
        //fmt.printf("%02X", val)

        addr += 1
        col += 1
        if col >= ULT_DBG_OUT_LINE_LEN {
            col = 0
            lin += 1
            //fmt.println()
            //fmt.println()
        }
    }
}

main :: proc() {
    screenWidth :: 800
    screenHeight :: 600

    fmt.println("Starting up ULT:cpu")

    ucpu := new(ult_cpu.Cpu)
    defer free(ucpu)

    ucpu^.int_mask_enabled = false
    ucpu^.int_table_enabled = false
    ucpu^.on_port_read = ult_cpu.io_read_port
    ucpu^.on_port_write = ult_cpu.io_write_port
    ucpu^.io = ult_cpu.IOData {
        wait_active     = false,
        wait_accum_temp = 0,
        wait_accum      = 0,
    }
    ucpu^.ticks = 0

    mem := ult_cpu.DefaultMem(0x800000)
    ucpu^.mem = mem
    defer ult_cpu.default_mem_release(&mem)

    err := ult_cpu.Cpu_load_program(ucpu, "examples/ex-dbg-out.bin")
    assert(err == nil)

    // Get starting address from 0x00000000
    start_addr := ult_cpu.read32_raw(&ucpu^.mem, ucpu, 0x00000000)
    ucpu^.regs.r32.PC = u32be(start_addr)

    raylib.InitWindow(screenWidth, screenHeight, "ULT:cpu")
    defer raylib.CloseWindow()

    font := raylib.LoadFont("res/unscii-8.ttf")
    assert(raylib.IsFontValid(font))

    raylib.SetTargetFPS(FPS_HZ)

    for !raylib.WindowShouldClose() {
        raylib.BeginDrawing()
        raylib.ClearBackground(raylib.BLACK)
        ticks := ult_cpu.Cpu_frame(ucpu, ULT_CPU_TICKS_PER_FRAME)
        raylib.DrawTextEx(
            font,
            fmt.ctprintf("AB:%08X,CD:%08X,EF:%08X,GH:%08X", cast(u32)ucpu^.regs.r32.AB, cast(u32)ucpu^.regs.r32.CD, cast(u32)ucpu^.regs.r32.EF, cast(u32)ucpu^.regs.r32.GH),
            raylib.Vector2{0, 0},
            8,
            1,
            raylib.RAYWHITE,
        )
        raylib.DrawTextEx(
            font,
            fmt.ctprintf("IJ:%08X,XY:%08X,PC:%08X,SP:%08X", cast(u32)ucpu^.regs.r32.IJ, cast(u32)ucpu^.regs.r32.XY, cast(u32)ucpu^.regs.r32.PC, cast(u32)ucpu^.regs.r32.SP),
            raylib.Vector2{0, 8},
            8,
            1,
            raylib.RAYWHITE,
        )
        raylib.DrawTextEx(
            font,
            fmt.ctprintf("SF:%08X,ST:%08X,KL:%08X,MN:%08X", cast(u32)ucpu^.regs.r32.SF, cast(u32)ucpu^.regs.r32.ST, cast(u32)ucpu^.regs.r32.KL, cast(u32)ucpu^.regs.r32.MN),
            raylib.Vector2{0, 16},
            8,
            1,
            raylib.RAYWHITE,
        )
        raylib.DrawTextEx(
            font,
            fmt.ctprintf("OP:%08X,QR:%08X,UV:%08X,r01:%08X", cast(u32)ucpu^.regs.r32.OP, cast(u32)ucpu^.regs.r32.QR, cast(u32)ucpu^.regs.r32.UV, cast(u32)ucpu^.regs.r32.r01),
            raylib.Vector2{0, 24},
            8,
            1,
            raylib.RAYWHITE,
        )
        raylib.DrawTextEx(
            font,
            fmt.ctprintf("r02:%08X,r03:%08X,r04:%08X,r05:%08X", cast(u32)ucpu^.regs.r32.r02, cast(u32)ucpu^.regs.r32.r03, cast(u32)ucpu^.regs.r32.r04, cast(u32)ucpu^.regs.r32.r05),
            raylib.Vector2{0, 32},
            8,
            1,
            raylib.RAYWHITE,
        )

        ite := ult_cpu.Cpu_quick_fetch(ucpu)
        raylib.DrawTextEx(
            font,
            fmt.ctprintf(
                "r06:%08X,r07:%08X,STOP:%08X,WT:%08X,op:%s, ticks:%v",
                cast(u32)ucpu^.regs.r32.r06,
                cast(u32)ucpu^.regs.r32.r07,
                ult_cpu.read32_raw(&ucpu^.mem, ucpu, u32(ucpu^.regs.r32.SP)),
                ucpu^.io.wait_accum,
                ite^.Mnemonic,
                ticks,
            ),
            raylib.Vector2{0, 40},
            8,
            1,
            raylib.RAYWHITE,
        )

        draw_dbg_out(ucpu, font, 48)

        raylib.DrawFPS(0, screenHeight - 20)

        raylib.EndDrawing()

        free_all(context.temp_allocator)
    }

    fmt.println("Exiting ULT:cpu")
}
