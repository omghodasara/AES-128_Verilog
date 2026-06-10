//Author : omghodasara
//Module : shiftRows
//Description : shifts rows of the 4x4 state matrix to the left by different offsets.

`timescale 1ns / 1ps

module shiftRows(
    input wire[127:0] in_shiftRows,
    output wire[127:0] out_shiftRows
    );
    
//  | [127:120] |  [95:88]  |  [63:56]  |  [31:24] | ---- Row-0
//  | [119:112] |  [87:80]  |  [55:48]  |  [23:16] | ---- Row-1
//  | [111:104] |  [79:72]  |  [47:40]  |  [15:8]  | ---- Row-2
//  | [103:96]  |  [71:64]  |  [39:32]  |  [7:0]   | ---- Row-3 
    
//    Row-0 
    assign out_shiftRows[127:120] = in_shiftRows[127:120];
    assign out_shiftRows[95:88]   = in_shiftRows[95:88];
    assign out_shiftRows[63:56]   = in_shiftRows[63:56];
    assign out_shiftRows[31:24]   = in_shiftRows[31:24];
    
//    Row-1 
    assign out_shiftRows[119:112] = in_shiftRows[87:80];
    assign out_shiftRows[87:80]   = in_shiftRows[55:48];
    assign out_shiftRows[55:48]   = in_shiftRows[23:16];
    assign out_shiftRows[23:16]   = in_shiftRows[119:112];
    
//    Row-2 
    assign out_shiftRows[111:104] = in_shiftRows[47:40];
    assign out_shiftRows[79:72]   = in_shiftRows[15:8];
    assign out_shiftRows[47:40]   = in_shiftRows[111:104];
    assign out_shiftRows[15:8]    = in_shiftRows[79:72];
    
//    Row-3 
    assign out_shiftRows[103:96]  = in_shiftRows[7:0];
    assign out_shiftRows[71:64]   = in_shiftRows[103:96];
    assign out_shiftRows[39:32]   = in_shiftRows[71:64];
    assign out_shiftRows[7:0]     = in_shiftRows[39:32];
        
endmodule