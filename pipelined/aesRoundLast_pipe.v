//Author : omghodasara
//Module : aesRoundLast_pipe
//Description : executes the special 10th AES data round (subBytes, shiftRows, addRoundKey) and saves the result in a pipeline register. It intentionally skips the mixColumns step.

`timescale 1ns / 1ps

module aesRoundLast_pipe (
    input wire clk,
    input wire [127:0] in_aesRoundLast,
    input wire [127:0] key_aesRoundLast,
    output reg [127:0] out_aesRoundLast
);

    wire [127:0] w_sub;
    wire [127:0] w_shift;
    wire [127:0] w_add; 

    // 1. Substitute Bytes
    subBytes u_subBytes (
        .in_subBytes(in_aesRoundLast),
        .out_subBytes(w_sub)
    );

    // 2. Shift Rows
    shiftRows u_shiftRows (
        .in_shiftRows(w_sub),
        .out_shiftRows(w_shift)
    );

    // 3. Add Round Key 
    addRoundKey u_addRoundKey (
        .in_addRoundKey(w_shift),
        .key_addRoundKey(key_aesRoundLast),
        .out_addRoundKey(w_add)
    );

    // 4. Pipeline Register
    always @(posedge clk) begin
        out_aesRoundLast <= w_add;
    end

endmodule