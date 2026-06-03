//Author : omghodasara
//Module : subBytes
//Description : splits the 128-bit data into 16 bytes and runs each through the Sbox table.

`timescale 1ns / 1ps

module subBytes(
    input wire[127:0] in_subBytes,
    output wire[127:0] out_subBytes
    );
    
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : sbox_loop
            sbox Sbox (
                .in_sbox  (in_subBytes[(i*8) +: 8]), 
                .out_sbox (out_subBytes[(i*8) +: 8]) 
            );
        end
    endgenerate
endmodule

