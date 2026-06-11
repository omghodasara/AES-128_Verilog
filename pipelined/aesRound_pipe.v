//Author : omghodasara
//Module : aesRound_pipe
//Description : executes one standard AES data round (subBytes, shiftRows, mixColumns, addRoundKey) and saves the result in a pipeline register on the clock edge.

`timescale 1ns / 1ps

module aesRound_pipe (
    input wire clk,
    input wire [127:0] in_aesRound,
    input wire [127:0] key_aesRound,
    output reg [127:0] out_aesRound
);

    wire [127:0] w_sub;
    wire [127:0] w_shift;
    wire [127:0] w_mix;
    wire [127:0] w_add;

    // 1. Substitute Bytes
    subBytes u_subBytes (
        .in_subBytes(in_aesRound),
        .out_subBytes(w_sub)
    );

    // 2. Shift Rows
    shiftRows u_shiftRows (
        .in_shiftRows(w_sub),
        .out_shiftRows(w_shift)
    );

    // 3. Mix Columns
    mixColumns u_mixColumns (
        .in_mixColumns(w_shift),
        .out_mixColumns(w_mix)
    );

    // 4. Add Round Key
    addRoundKey u_addRoundKey (
        .in_addRoundKey(w_mix),
        .key_addRoundKey(key_aesRound),
        .out_addRoundKey(w_add)
    );

    // 5. Pipeline Register - this stops the data from flowing continuously and holds it for the next clock tick
    always @(posedge clk) begin
        out_aesRound <= w_add;
    end

endmodule