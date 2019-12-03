`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:25:53 10/30/2019 
// Design Name: 
// Module Name:    HybridAdd 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:39:05 10/30/2019 
// Design Name: 
// Module Name:    hybridadder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module HybridAdd(
    input [31:0] A,
    input [31:0] B,
    input cin,
    output [31:0] S,
    output cout
    );

    wire[6:0] c_mid;
    
    Add A0(A[3:0], B[3:0], cin, S[3:0], c_mid[0]);
    Add A1(A[7:4], B[7:4], c_mid[0], S[7:4], c_mid[1]);
    Add A2(A[11:8], B[11:8], c_mid[1], S[11:8], c_mid[2]);
    Add A3(A[15:12], B[15:12], c_mid[2], S[15:12], c_mid[3]);
    Add A4(A[19:16], B[19:16], c_mid[3], S[19:16], c_mid[4]);
    Add A5(A[23:20], B[23:20], c_mid[4], S[23:20], c_mid[5]);
    Add A6(A[27:24], B[27:24], c_mid[5], S[27:24], c_mid[6]);
    Add A7(A[31:28], B[31:28], c_mid[6], S[31:28], cout);

endmodule

