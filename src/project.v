/*
 * Copyright (c) 2025 Hans Yang
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

    reg [7:0] uo_out_reg;

    always @(ena, ui_in, uio_in) 
        begin
        if (ena == 1) 
            begin
                if (ui_in[7] == 1) uo_out_reg = 8'b00001111;
                else if (ui_in[6] == 1) uo_out_reg = 8'b00001110;
                else if (ui_in[5] == 1) uo_out_reg = 8'b00001101;
                else if (ui_in[4] == 1) uo_out_reg = 8'b00001100;
                else if (ui_in[3] == 1) uo_out_reg = 8'b00001011;
                else if (ui_in[2] == 1) uo_out_reg = 8'b00001010;
                else if (ui_in[1]  == 1) uo_out_reg = 8'b00001001;
                else if (ui_in[0]  == 1) uo_out_reg = 8'b00001000;
                else if (uio_in[7]  == 1) uo_out_reg = 8'b00000111;
                else if (uio_in[6]  == 1) uo_out_reg = 8'b00000110;
                else if (uio_in[5]  == 1) uo_out_reg = 8'b00000101;
                else if (uio_in[4]  == 1) uo_out_reg = 8'b00000100;
                else if (uio_in[3]  == 1) uo_out_reg = 8'b00000011;
                else if (uio_in[2]  == 1) uo_out_reg = 8'b00000010;
                else if (uio_in[1]  == 1) uo_out_reg = 8'b00000001;
                else if (uio_in[0]  == 1) uo_out_reg = 8'b00000000;
                else uo_out_reg = 8'b11110000;
            end
        else uo_out_reg = 8'bzzzzzzzz;
    end

  assign uo_out = uo_out_reg;

  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{clk, rst_n, 1'b0};

endmodule
