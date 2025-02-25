/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_project (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    always @(*) begin
        if (ui_in[7] == 1) uo_out = 8'b0000_1111;
        else if (ui_in[6] == 1) uo_out = 8'b0000_1110;
        else if (ui_in[5] == 1) uo_out = 8'b0000_1101;
        else if (ui_in[4] == 1) uo_out = 8'b0000_1100;
        else if (ui_in[3] == 1) uo_out = 8'b0000_1011;
        else if (ui_in[2] == 1) uo_out = 8'b0000_1010;
        else if (ui_in[1]  == 1) uo_out = 8'b0000_1001;
        else if (ui_in[0]  == 1) uo_out = 8'b0000_1000;
        else if (uio_in[7]  == 1) uo_out = 8'b0000_0111;
        else if (uio_in[6]  == 1) uo_out = 8'b0000_0110;
        else if (uio_in[5]  == 1) uo_out = 8'b0000_0101;
        else if (uio_in[4]  == 1) uo_out = 8'b0000_0100;
        else if (uio_in[3]  == 1) uo_out = 8'b0000_0011;
        else if (uio_in[2]  == 1) uo_out = 8'b0000_0010;
        else if (uio_in[1]  == 1) uo_out = 8'b0000_0001;
        else if (uio_in[0]  == 1) uo_out = 8'b0000_0000;
        else uo_out = 8'b1111_0000; // Special case: all zeros
    end
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
