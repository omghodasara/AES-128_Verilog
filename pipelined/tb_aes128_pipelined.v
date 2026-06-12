//Author : omghodasara
//Module : tb_aes128_pipelined
//Description : testbench to verify the 11-cycle pipelined AES-128 core using standard NIST test vectors.

`timescale 1ns / 1ps

module tb_aes128_pipelined;

    reg clk;
    reg [127:0] plaintext;
    reg [127:0] key;

    wire [127:0] ciphertext;

    aes128_pipelined uut (
        .clk(clk),
        .plaintext(plaintext),
        .key(key),
        .ciphertext(ciphertext)
    );

//    clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
//        clock initialization
        clk = 0;
        
//        NIST Standard Test Vector
        plaintext = 128'h3243f6a8885a308d313198a2e0370734;
        key       = 128'h2b7e151628aed2a6abf7158809cf4f3c;

//        waiting exactly 11 clock cycles for the pipeline to fill
        repeat(11) @(posedge clk);
        
//        waiting 1ns extra so the flip-flops have time to update their outputs
        #1; 

        $display("--- AES-128 Pipelined Simulation ---");
        $display("Expected: 3925841d02dc09fbdc118597196a0b32");
        $display("Actual  : %h", ciphertext);

        if (ciphertext == 128'h3925841d02dc09fbdc118597196a0b32) begin
            $display("Result  : PASS");
        end else begin
            $display("Result  : FAIL");
        end

        #50;
        $finish;
    end

endmodule