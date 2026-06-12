//Author : omghodasara
//Module : aes128_pipelined
//Description : top module for the pipelined AES-128 encryption. Wires the initial step, 9 standard rounds, 1 final round, and 10 key generation rounds into an 11-cycle pipeline.

`timescale 1ns / 1ps

module aes128_pipelined (
    input wire clk,
    input wire [127:0] plaintext,
    input wire [127:0] key,
    output wire [127:0] ciphertext
);

//    Data Pipeline Wires & Registers
    reg  [127:0] d0; // Register to hold the initial Round 0 calculation
    wire [127:0] d1, d2, d3, d4, d5, d6, d7, d8, d9, d10;

//    Key Pipeline Wires 
    wire [127:0] k1, k2, k3, k4, k5, k6, k7, k8, k9, k10;

//    Round 0 
    always @(posedge clk) begin
        d0 <= plaintext ^ key;
    end

//    Key Expansion Pipeline 
    keyRound_pipe kr1  ( .clk(clk), .in_keyRound(key), .rcon(8'h01), .out_keyRound(k1)  );
    keyRound_pipe kr2  ( .clk(clk), .in_keyRound(k1),  .rcon(8'h02), .out_keyRound(k2)  );
    keyRound_pipe kr3  ( .clk(clk), .in_keyRound(k2),  .rcon(8'h04), .out_keyRound(k3)  );
    keyRound_pipe kr4  ( .clk(clk), .in_keyRound(k3),  .rcon(8'h08), .out_keyRound(k4)  );
    keyRound_pipe kr5  ( .clk(clk), .in_keyRound(k4),  .rcon(8'h10), .out_keyRound(k5)  );
    keyRound_pipe kr6  ( .clk(clk), .in_keyRound(k5),  .rcon(8'h20), .out_keyRound(k6)  );
    keyRound_pipe kr7  ( .clk(clk), .in_keyRound(k6),  .rcon(8'h40), .out_keyRound(k7)  );
    keyRound_pipe kr8  ( .clk(clk), .in_keyRound(k7),  .rcon(8'h80), .out_keyRound(k8)  );
    keyRound_pipe kr9  ( .clk(clk), .in_keyRound(k8),  .rcon(8'h1B), .out_keyRound(k9)  );
    keyRound_pipe kr10 ( .clk(clk), .in_keyRound(k9),  .rcon(8'h36), .out_keyRound(k10) );

//    Rounds 1 to 9
    aesRound_pipe r1 ( .clk(clk), .in_aesRound(d0), .key_aesRound(k1), .out_aesRound(d1) );
    aesRound_pipe r2 ( .clk(clk), .in_aesRound(d1), .key_aesRound(k2), .out_aesRound(d2) );
    aesRound_pipe r3 ( .clk(clk), .in_aesRound(d2), .key_aesRound(k3), .out_aesRound(d3) );
    aesRound_pipe r4 ( .clk(clk), .in_aesRound(d3), .key_aesRound(k4), .out_aesRound(d4) );
    aesRound_pipe r5 ( .clk(clk), .in_aesRound(d4), .key_aesRound(k5), .out_aesRound(d5) );
    aesRound_pipe r6 ( .clk(clk), .in_aesRound(d5), .key_aesRound(k6), .out_aesRound(d6) );
    aesRound_pipe r7 ( .clk(clk), .in_aesRound(d6), .key_aesRound(k7), .out_aesRound(d7) );
    aesRound_pipe r8 ( .clk(clk), .in_aesRound(d7), .key_aesRound(k8), .out_aesRound(d8) );
    aesRound_pipe r9 ( .clk(clk), .in_aesRound(d8), .key_aesRound(k9), .out_aesRound(d9) );

//    Round 10 
    aesRoundLast_pipe r10 ( .clk(clk), .in_aesRoundLast(d9), .key_aesRoundLast(k10), .out_aesRoundLast(d10) );

//    Output
    assign ciphertext = d10;

endmodule