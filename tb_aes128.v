//Author : omghodasara
//Module : tb_aes128
//Description : basic testbench to verify the top-level AES-128 using standard test vectors.

`timescale 1ns / 1ps

module tb_aes128();

    reg [127:0] plaintext;
    reg [127:0] key;
    wire [127:0] ciphertext;

    aes128 uut (
        .plaintext(plaintext),
        .key(key),
        .ciphertext(ciphertext)
    );

    initial begin
        key       = 128'h2b7e151628aed2a6abf7158809cf4f3c;
        plaintext = 128'h3243f6a8885a308d313198a2e0370734;
        #20; 
//        expected ciphertext: 3925841d02dc09fbdce118aa0912222c

        key       = 128'h00000000000000000000000000000000;
        plaintext = 128'h00000000000000000000000000000000;
        #20; 
//        expected ciphertext: 66e94bd4ef8a2c3b884cfa59ca342b2e

        key       = 128'h000102030405060708090a0b0c0d0e0f;
        plaintext = 128'h00112233445566778899aabbccddeeff;
        #20; 
//        expected ciphertext: 69c4e0d86a7b0430d8cdb78070b4c55a

        $finish;
    end
endmodule