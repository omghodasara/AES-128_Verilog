//Author : omghodasara
//Module : keyRound_pipe
//Description : calculates the next 128-bit round key and saves it into a flip-flop register on the clock edge.

`timescale 1ns / 1ps

module keyRound_pipe (
    input wire clk,
    input wire [127:0] in_keyRound,
    input wire [7:0] rcon,        
    output reg [127:0] out_keyRound    
);
    
//    1. Splitting the key into 4 words
    wire [31:0] w0 = in_keyRound[127:96];
    wire [31:0] w1 = in_keyRound[95:64];
    wire [31:0] w2 = in_keyRound[63:32];
    wire [31:0] w3 = in_keyRound[31:0];
    
//    2. RotWord ( rotate w3 )
    wire [31:0] w3_rot = {w3[23:0], w3[31:24]};
    
//    3. SubWord 
    wire [31:0] w3_sub;
    sbox sbox_k0 ( .in_sbox(w3_rot[31:24]), .out_sbox(w3_sub[31:24]) );
    sbox sbox_k1 ( .in_sbox(w3_rot[23:16]), .out_sbox(w3_sub[23:16]) );
    sbox sbox_k2 ( .in_sbox(w3_rot[15:8]), .out_sbox(w3_sub[15:8]) );
    sbox sbox_k3 ( .in_sbox(w3_rot[7:0]), .out_sbox(w3_sub[7:0]) );
    
//    4. New Word
    wire [31:0] w4 = w0 ^ w3_sub ^ {rcon, 24'h000000};  
    wire [31:0] w5 = w1 ^ w4;
    wire [31:0] w6 = w2 ^ w5;
    wire [31:0] w7 = w3 ^ w6;  
    
//    5. Pipeline Register
    always @(posedge clk) begin
        out_keyRound <= {w4, w5, w6, w7};
    end
    
endmodule