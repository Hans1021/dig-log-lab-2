# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    
    dut.ui_in.value = 235
    dut.uio_in.value = 50

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 185

    dut.ui_in.value = 5
    dut.uio_in.value = 5

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 0
    
    dut.ui_in.value = 100
    dut.uio_in.value = 115

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 15
    
    dut.ui_in.value = 55
    dut.uio_in.value = 13

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 42
    
    dut.ui_in.value = 45
    dut.uio_in.value = 211

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 166

    dut.ui_in.value = 0
    dut.uio_in.value = 0

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 0
