//Author : omghodasara
//Module : addRoundKey
//Description : performs bitwise XOR between the 128-bit state matrix and the 128-bit round key.

`timescale 1ns / 1ps

module addRoundKey(
    input wire[127:0] in_addRoundKey ,
    input wire[127:0] key_addRoundKey ,
    output wire[127:0] out_addRoundKey
    );
    
    assign out_addRoundKey = in_addRoundKey ^ key_addRoundKey;
    
endmodule
