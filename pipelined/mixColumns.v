//Author : omghodasara
//Module : mixColumns
//Description : multiplies columns of the state matrix by a fixed polynomial matrix

`timescale 1ns / 1ps

module mixColumns(
    input wire[127:0] in_mixColumns,
    output wire[127:0] out_mixColumns
    );
    
    function automatic [7:0] mul2;
        input [7:0] b;
        begin
            mul2 = (b[7] == 1'b1) ? ((b << 1) ^ 8'h1B) : (b << 1);
        end
    endfunction
    
    function automatic [7:0] mul3;
        input [7:0] x;
        begin
            mul3 = mul2(x) ^ x;
        end
    endfunction
    
//  | [127:120] |  [95:88]  |  [63:56]  |  [31:24] | ---- Row-0
//  | [119:112] |  [87:80]  |  [55:48]  |  [23:16] | ---- Row-1
//  | [111:104] |  [79:72]  |  [47:40]  |  [15:8]  | ---- Row-2
//  | [103:96]  |  [71:64]  |  [39:32]  |  [7:0]   | ---- Row-3
    
//    column-0
    assign out_mixColumns[127:120] = mul2(in_mixColumns[127:120]) ^ mul3(in_mixColumns[119:112]) ^ in_mixColumns[111:104] ^ in_mixColumns[103:96];
    assign out_mixColumns[119:112] = in_mixColumns[127:120] ^ mul2(in_mixColumns[119:112]) ^ mul3(in_mixColumns[111:104]) ^ in_mixColumns[103:96];
    assign out_mixColumns[111:104] = in_mixColumns[127:120] ^ in_mixColumns[119:112] ^ mul2(in_mixColumns[111:104]) ^ mul3(in_mixColumns[103:96]);
    assign out_mixColumns[103:96] = mul3(in_mixColumns[127:120]) ^ in_mixColumns[119:112] ^ in_mixColumns[111:104] ^ mul2(in_mixColumns[103:96]);
    
//    column-1
    assign out_mixColumns[95:88] = mul2(in_mixColumns[95:88]) ^ mul3(in_mixColumns[87:80]) ^ in_mixColumns[79:72] ^ in_mixColumns[71:64];
    assign out_mixColumns[87:80] = in_mixColumns[95:88] ^ mul2(in_mixColumns[87:80]) ^ mul3(in_mixColumns[79:72]) ^ in_mixColumns[71:64];
    assign out_mixColumns[79:72] = in_mixColumns[95:88] ^ in_mixColumns[87:80] ^ mul2(in_mixColumns[79:72]) ^ mul3(in_mixColumns[71:64]);
    assign out_mixColumns[71:64] = mul3(in_mixColumns[95:88]) ^ in_mixColumns[87:80] ^ in_mixColumns[79:72] ^ mul2(in_mixColumns[71:64]);
    
//    column-2
    assign out_mixColumns[63:56] = mul2(in_mixColumns[63:56]) ^ mul3(in_mixColumns[55:48]) ^ in_mixColumns[47:40] ^ in_mixColumns[39:32];
    assign out_mixColumns[55:48] = in_mixColumns[63:56] ^ mul2(in_mixColumns[55:48]) ^ mul3(in_mixColumns[47:40]) ^ in_mixColumns[39:32];
    assign out_mixColumns[47:40] = in_mixColumns[63:56] ^ in_mixColumns[55:48] ^ mul2(in_mixColumns[47:40]) ^ mul3(in_mixColumns[39:32]);
    assign out_mixColumns[39:32] = mul3(in_mixColumns[63:56]) ^ in_mixColumns[55:48] ^ in_mixColumns[47:40] ^ mul2(in_mixColumns[39:32]);
    
//    column-3
    assign out_mixColumns[31:24] = mul2(in_mixColumns[31:24]) ^ mul3(in_mixColumns[23:16]) ^ in_mixColumns[15:8] ^ in_mixColumns[7:0];
    assign out_mixColumns[23:16] = in_mixColumns[31:24] ^ mul2(in_mixColumns[23:16]) ^ mul3(in_mixColumns[15:8]) ^ in_mixColumns[7:0];
    assign out_mixColumns[15:8] = in_mixColumns[31:24] ^ in_mixColumns[23:16] ^ mul2(in_mixColumns[15:8]) ^ mul3(in_mixColumns[7:0]);
    assign out_mixColumns[7:0] = mul3(in_mixColumns[31:24]) ^ in_mixColumns[23:16] ^ in_mixColumns[15:8] ^ mul2(in_mixColumns[7:0]);
    
endmodule