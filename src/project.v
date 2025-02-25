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
    
module priority_encoder_16to8 (en, In, C);
    input en;             
    input [15:0] In;      // 16-bit input
    output reg [7:0] C;   // 8-bit output

    always @(en, In) 
      begin
        if (en == 1) 
          begin
            if (In[15] == 1) C = 8'b0000_1111;
            else if (In[14] == 1) C = 8'b0000_1110;
            else if (In[13] == 1) C = 8'b0000_1101;
            else if (In[12] == 1) C = 8'b0000_1100;
            else if (In[11] == 1) C = 8'b0000_1011;
            else if (In[10] == 1) C = 8'b0000_1010;
            else if (In[9]  == 1) C = 8'b0000_1001;
            else if (In[8]  == 1) C = 8'b0000_1000;
            else if (In[7]  == 1) C = 8'b0000_0111;
            else if (In[6]  == 1) C = 8'b0000_0110;
            else if (In[5]  == 1) C = 8'b0000_0101;
            else if (In[4]  == 1) C = 8'b0000_0100;
            else if (In[3]  == 1) C = 8'b0000_0011;
            else if (In[2]  == 1) C = 8'b0000_0010;
            else if (In[1]  == 1) C = 8'b0000_0001;
            else if (In[0]  == 1) C = 8'b0000_0000;
            else C = 8'b1111_0000; // Special case: all zeros
        end
  
        else C = 8'bzzzz_zzzz;
    end
endmodule

priority_encoder_16to8 encoder_inst (
    .en(1),
    .In({ui_in, uio_in}),
    .C(uo_out)
);
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
