//Author : omghodasara
//Module : aesRound
//Description : executes one full AES round by chaining subBytes, shiftRows, mixColumns, and addRoundKey.

`timescale 1ns / 1ps

module aesRound(
    input wire [127:0] in_aesRound,
    input wire [127:0] key_aesRound,
    output wire [127:0] out_aesRound
    );
    
    wire[127:0] out_sb;
    wire[127:0] out_sr;
    wire[127:0] out_mc;
    
    subBytes u_subBytes (
        .in_subBytes(in_aesRound),   
        .out_subBytes(out_sb)   
    );
    
    shiftRows u_shiftRows (
        .in_shiftRows(out_sb),
        .out_shiftRows(out_sr)
    );
    
    mixColumns u_mixColumns (
        .in_mixColumns(out_sr),
        .out_mixColumns(out_mc)
    );
    
    addRoundKey u_addRoundKey (
        .in_addRoundKey(out_mc),
        .key_addRoundKey(key_aesRound),
        .out_addRoundKey(out_aesRound)
    );
endmodule
