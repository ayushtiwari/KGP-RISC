`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:11:08 11/05/2019 
// Design Name: 
// Module Name:    mux_2to1 
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
/*
*	2 to 1 MUX
*/
module mux_2to1
(	
    in0,	
	in1,		
	sel,
	
	out	
);

	parameter DWIDTH = 32;

    input [DWIDTH-1:0] in0;
	input [DWIDTH-1:0] in1;
	input sel;
	
    output [DWIDTH-1:0] out; 
		
	assign out = (sel == 0) ? in0 : in1;
endmodule  



