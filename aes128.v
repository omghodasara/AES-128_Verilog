//Author : omghodasara
//Module : aes128
//Description : top-level AES-128 encryption module 

`timescale 1ns / 1ps

module aes128(
    input wire[127:0] plaintext,
    input wire[127:0] key,
    output wire[127:0] ciphertext
    );
    
    wire [1407:0] expanded_keys;
    wire [127:0] state0, state1, state2, state3, state4, state5, state6, state7, state8, state9;
    
    keyExpansion u_keyExpansion (
        .in_keyExpansion(key),
        .out_keyExpansion(expanded_keys)
    );
    
//    round-0
    assign state0 = plaintext ^ expanded_keys[1407:1280];
    
//    round-1
    aesRound r1 ( 
        .in_aesRound(state0), 
        .key_aesRound(expanded_keys[1279:1152]), 
        .out_aesRound(state1) 
    );
    
//    round-2
    aesRound r2 ( 
        .in_aesRound(state1), 
        .key_aesRound(expanded_keys[1151:1024]), 
        .out_aesRound(state2) 
    );
    
//    round-3
    aesRound r3 ( 
        .in_aesRound(state2), 
        .key_aesRound(expanded_keys[1023:896]), 
        .out_aesRound(state3) 
    );
    
//    round-4
    aesRound r4 ( 
        .in_aesRound(state3), 
        .key_aesRound(expanded_keys[895:768]), 
        .out_aesRound(state4) 
    );
    
//    round-5
    aesRound r5 ( 
        .in_aesRound(state4), 
        .key_aesRound(expanded_keys[767:640]), 
        .out_aesRound(state5) 
    );
    
//    round-6
    aesRound r6 ( 
        .in_aesRound(state5), 
        .key_aesRound(expanded_keys[639:512]), 
        .out_aesRound(state6) 
    );
    
//    round-7
    aesRound r7 ( 
        .in_aesRound(state6), 
        .key_aesRound(expanded_keys[511:384]), 
        .out_aesRound(state7) 
    );
    
//    round-8
    aesRound r8 ( 
        .in_aesRound(state7), 
        .key_aesRound(expanded_keys[383:256]), 
        .out_aesRound(state8) 
    );
    
//    round-9
    aesRound r9 ( 
        .in_aesRound(state8), 
        .key_aesRound(expanded_keys[255:128]), 
        .out_aesRound(state9) 
    );
    
//    round-10
    wire [127:0] r10_sb_out;
    wire [127:0] r10_sr_out;
    
    subBytes u_sb10 ( 
        .in_subBytes(state9), 
        .out_subBytes(r10_sb_out) 
    );
    shiftRows u_sr10 ( 
        .in_shiftRows(r10_sb_out), 
        .out_shiftRows(r10_sr_out) 
    );
    addRoundKey u_ark10 ( 
        .in_addRoundKey(r10_sr_out), 
        .key_addRoundKey(expanded_keys[127:0]), 
        .out_addRoundKey(ciphertext) 
    );

endmodule