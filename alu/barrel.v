`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:22:28 10/30/2019 
// Design Name: 
// Module Name:    BARREL 
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
module BARREL(
    input [31:0] I,
    input DIR,
    input [4:0] SHAMT,
    output [31:0] O
    );
    
    wire [31:0] W_1, W_2, W_3;
    
    assign W_1 = I >>16;
    assign W_2 = I << 16;
    
    mux_2to1 M0(.in0(W_1), .in1(W_2), .sel(DIR), .out(W_3));
    
    wire [31:0] W_4;
    
    mux_2to1 M1(.in0(I), .in1(W_3), .sel(SHAMT[4]), .out(W_4));
    
    wire [31:0] W_5, W_6, W_7;
    
    assign W_5 = W_4 >> 8;
    assign W_6 = W_4 << 8;
    
    mux_2to1 M2(.in0(W_5), .in1(W_6), .sel(DIR), .out(W_7));
    
    wire [31:0] W_8;
    
    mux_2to1 M3(.in0(W_4), .in1(W_7), .sel(SHAMT[3]), .out(W_8));
    
    wire [31:0] W_9, W_10, W_11,W_12;
    
    assign W_9 = W_8 >> 4;
    assign W_10 = W_8 << 4;
    
    mux_2to1 M14(.in0(W_9), .in1(W_10), .sel(DIR), .out(W_11));
    
    mux_2to1 M15(.in0(W_8), .in1(W_11), .sel(SHAMT[2]), .out(W_12));
    
    wire [31:0] W_13, W_15, W_14,W_16;
    
    assign W_13 = W_12 >> 2;
    assign W_14 = W_12 << 2;
    
    mux_2to1 M24(.in0(W_13), .in1(W_14), .sel(DIR), .out(W_15));
    
    mux_2to1 M25(.in0(W_12), .in1(W_15), .sel(SHAMT[1]), .out(W_16));
    
    wire [31:0] W_17, W_18, W_19;
    
    assign W_17 = W_16 >> 1;
    assign W_18 = W_16 << 1;
    
    mux_2to1 M34(.in0(W_17), .in1(W_18), .sel(DIR), .out(W_19));
    
    mux_2to1 M35(.in0(W_16), .in1(W_19), .sel(SHAMT[0]), .out(O));
    
endmodule
