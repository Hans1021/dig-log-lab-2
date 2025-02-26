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
                if (ui_in > uio_in)
                    uo_out_reg = ui_in - uio_in; // If ui_in is greater, subtract uio_in from ui_in
                else
                    uo_out_reg = uio_in - ui_in; // Otherwise, subtract ui_in from uio_in
            end
        else uo_out_reg = 8'bzzzzzzzz;
    end

  assign uo_out = uo_out_reg;
    
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{clk, rst_n, 1'b0};

endmodule
