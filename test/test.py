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


    dut.ui_in.value = 234
    dut.uio_in.value = 53

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 181

    dut.ui_in.value = 142
    dut.uio_in.value = 52

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 90

    dut.ui_in.value = 0
    dut.uio_in.value = 0

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 0

    dut.ui_in.value = 90
    dut.uio_in.value = 142

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 52

    dut.ui_in.value = 18
    dut.uio_in.value = 19

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 1
