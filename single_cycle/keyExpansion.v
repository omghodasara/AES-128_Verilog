//Author : omghodasara
//Module : keyExpansion
//Description : Unrolls the AES key schedule to generate all 11 round keys combinationally.

`timescale 1ns / 1ps

module keyExpansion(
    input wire[127:0] in_keyExpansion,
    output wire[1407:0] out_keyExpansion
);
//    key 0
    wire[31:0] w0 = in_keyExpansion[127:96];
    wire[31:0] w1 = in_keyExpansion[95:64];
    wire[31:0] w2 = in_keyExpansion[63:32];
    wire[31:0] w3 = in_keyExpansion[31:0];
    
//    key 1
    wire[31:0] w3_rot = {w3[23:0],w3[31:24]};
    
    wire[31:0] w3_sub;
    sbox sbox_k1_0 ( .in_sbox(w3_rot[31:24]), .out_sbox(w3_sub[31:24]) );
    sbox sbox_k1_1 ( .in_sbox(w3_rot[23:16]), .out_sbox(w3_sub[23:16]) );
    sbox sbox_k1_2 ( .in_sbox(w3_rot[15:8]), .out_sbox(w3_sub[15:8]) );
    sbox sbox_k1_3 ( .in_sbox(w3_rot[7:0]), .out_sbox(w3_sub[7:0]) );
    
    wire [31:0] w4 = w0 ^ w3_sub ^ 32'h01000000; 
    wire [31:0] w5 = w1 ^ w4;                    
    wire [31:0] w6 = w2 ^ w5;
    wire [31:0] w7 = w3 ^ w6;
    
//    key 2
    wire[31:0] w7_rot = {w7[23:0],w7[31:24]};
    
    wire[31:0] w7_sub;
    sbox sbox_k2_0 ( .in_sbox(w7_rot[31:24]), .out_sbox(w7_sub[31:24]) );
    sbox sbox_k2_1 ( .in_sbox(w7_rot[23:16]), .out_sbox(w7_sub[23:16]) );
    sbox sbox_k2_2 ( .in_sbox(w7_rot[15:8]), .out_sbox(w7_sub[15:8]) );
    sbox sbox_k2_3 ( .in_sbox(w7_rot[7:0]), .out_sbox(w7_sub[7:0]) );
    
    wire [31:0] w8 = w4 ^ w7_sub ^ 32'h02000000; 
    wire [31:0] w9 = w5 ^ w8;                    
    wire [31:0] w10 = w6 ^ w9;
    wire [31:0] w11 = w7 ^ w10;
    
//    key 3
    wire[31:0] w11_rot = {w11[23:0],w11[31:24]};
    
    wire[31:0] w11_sub;
    sbox sbox_k3_0 ( .in_sbox(w11_rot[31:24]), .out_sbox(w11_sub[31:24]) );
    sbox sbox_k3_1 ( .in_sbox(w11_rot[23:16]), .out_sbox(w11_sub[23:16]) );
    sbox sbox_k3_2 ( .in_sbox(w11_rot[15:8]), .out_sbox(w11_sub[15:8]) );
    sbox sbox_k3_3 ( .in_sbox(w11_rot[7:0]), .out_sbox(w11_sub[7:0]) );
    
    wire [31:0] w12 = w8 ^ w11_sub ^ 32'h04000000; 
    wire [31:0] w13 = w9 ^ w12;                    
    wire [31:0] w14 = w10 ^ w13;
    wire [31:0] w15 = w11 ^ w14;
    
//    key 4
    wire[31:0] w15_rot = {w15[23:0],w15[31:24]};
    
    wire[31:0] w15_sub;
    sbox sbox_k4_0 ( .in_sbox(w15_rot[31:24]), .out_sbox(w15_sub[31:24]) );
    sbox sbox_k4_1 ( .in_sbox(w15_rot[23:16]), .out_sbox(w15_sub[23:16]) );
    sbox sbox_k4_2 ( .in_sbox(w15_rot[15:8]), .out_sbox(w15_sub[15:8]) );
    sbox sbox_k4_3 ( .in_sbox(w15_rot[7:0]), .out_sbox(w15_sub[7:0]) );
    
    wire [31:0] w16 = w12 ^ w15_sub ^ 32'h08000000; 
    wire [31:0] w17 = w13 ^ w16;                    
    wire [31:0] w18 = w14 ^ w17;
    wire [31:0] w19 = w15 ^ w18;

//    key 5
    wire[31:0] w19_rot = {w19[23:0],w19[31:24]};
    
    wire[31:0] w19_sub;
    sbox sbox_k5_0 ( .in_sbox(w19_rot[31:24]), .out_sbox(w19_sub[31:24]) );
    sbox sbox_k5_1 ( .in_sbox(w19_rot[23:16]), .out_sbox(w19_sub[23:16]) );
    sbox sbox_k5_2 ( .in_sbox(w19_rot[15:8]), .out_sbox(w19_sub[15:8]) );
    sbox sbox_k5_3 ( .in_sbox(w19_rot[7:0]), .out_sbox(w19_sub[7:0]) );
    
    wire [31:0] w20 = w16 ^ w19_sub ^ 32'h10000000; 
    wire [31:0] w21 = w17 ^ w20;                    
    wire [31:0] w22 = w18 ^ w21;
    wire [31:0] w23 = w19 ^ w22;

//    key 6
    wire[31:0] w23_rot = {w23[23:0],w23[31:24]};
    
    wire[31:0] w23_sub;
    sbox sbox_k6_0 ( .in_sbox(w23_rot[31:24]), .out_sbox(w23_sub[31:24]) );
    sbox sbox_k6_1 ( .in_sbox(w23_rot[23:16]), .out_sbox(w23_sub[23:16]) );
    sbox sbox_k6_2 ( .in_sbox(w23_rot[15:8]), .out_sbox(w23_sub[15:8]) );
    sbox sbox_k6_3 ( .in_sbox(w23_rot[7:0]), .out_sbox(w23_sub[7:0]) );
    
    wire [31:0] w24 = w20 ^ w23_sub ^ 32'h20000000; 
    wire [31:0] w25 = w21 ^ w24;                    
    wire [31:0] w26 = w22 ^ w25;
    wire [31:0] w27 = w23 ^ w26;

//    key 7
    wire[31:0] w27_rot = {w27[23:0],w27[31:24]};
    
    wire[31:0] w27_sub;
    sbox sbox_k7_0 ( .in_sbox(w27_rot[31:24]), .out_sbox(w27_sub[31:24]) );
    sbox sbox_k7_1 ( .in_sbox(w27_rot[23:16]), .out_sbox(w27_sub[23:16]) );
    sbox sbox_k7_2 ( .in_sbox(w27_rot[15:8]), .out_sbox(w27_sub[15:8]) );
    sbox sbox_k7_3 ( .in_sbox(w27_rot[7:0]), .out_sbox(w27_sub[7:0]) );
    
    wire [31:0] w28 = w24 ^ w27_sub ^ 32'h40000000; 
    wire [31:0] w29 = w25 ^ w28;                    
    wire [31:0] w30 = w26 ^ w29;
    wire [31:0] w31 = w27 ^ w30;

//    key 8
    wire[31:0] w31_rot = {w31[23:0],w31[31:24]};
    
    wire[31:0] w31_sub;
    sbox sbox_k8_0 ( .in_sbox(w31_rot[31:24]), .out_sbox(w31_sub[31:24]) );
    sbox sbox_k8_1 ( .in_sbox(w31_rot[23:16]), .out_sbox(w31_sub[23:16]) );
    sbox sbox_k8_2 ( .in_sbox(w31_rot[15:8]), .out_sbox(w31_sub[15:8]) );
    sbox sbox_k8_3 ( .in_sbox(w31_rot[7:0]), .out_sbox(w31_sub[7:0]) );
    
    wire [31:0] w32 = w28 ^ w31_sub ^ 32'h80000000; 
    wire [31:0] w33 = w29 ^ w32;                    
    wire [31:0] w34 = w30 ^ w33;
    wire [31:0] w35 = w31 ^ w34;

//    key 9
    wire[31:0] w35_rot = {w35[23:0],w35[31:24]};
    
    wire[31:0] w35_sub;
    sbox sbox_k9_0 ( .in_sbox(w35_rot[31:24]), .out_sbox(w35_sub[31:24]) );
    sbox sbox_k9_1 ( .in_sbox(w35_rot[23:16]), .out_sbox(w35_sub[23:16]) );
    sbox sbox_k9_2 ( .in_sbox(w35_rot[15:8]), .out_sbox(w35_sub[15:8]) );
    sbox sbox_k9_3 ( .in_sbox(w35_rot[7:0]), .out_sbox(w35_sub[7:0]) );
    
    wire [31:0] w36 = w32 ^ w35_sub ^ 32'h1B000000; 
    wire [31:0] w37 = w33 ^ w36;                    
    wire [31:0] w38 = w34 ^ w37;
    wire [31:0] w39 = w35 ^ w38;

//    key 10
    wire[31:0] w39_rot = {w39[23:0],w39[31:24]};
    
    wire[31:0] w39_sub;
    sbox sbox_k10_0 ( .in_sbox(w39_rot[31:24]), .out_sbox(w39_sub[31:24]) );
    sbox sbox_k10_1 ( .in_sbox(w39_rot[23:16]), .out_sbox(w39_sub[23:16]) );
    sbox sbox_k10_2 ( .in_sbox(w39_rot[15:8]), .out_sbox(w39_sub[15:8]) );
    sbox sbox_k10_3 ( .in_sbox(w39_rot[7:0]), .out_sbox(w39_sub[7:0]) );
    
    wire [31:0] w40 = w36 ^ w39_sub ^ 32'h36000000; 
    wire [31:0] w41 = w37 ^ w40;                    
    wire [31:0] w42 = w38 ^ w41;
    wire [31:0] w43 = w39 ^ w42;

    assign out_keyExpansion = {w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17 , w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31, w32, w33, w34, w35, w36, w37, w38, w39, w40, w41, w42, w43};

endmodule 