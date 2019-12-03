`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:11:27 11/05/2019 
// Design Name: 
// Module Name:    sign_extension 
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
*	Sign Extension - 16 bits to  32 bits
*/

module sign_extension
(	
	in,
    
	out
);
	
	parameter INPUT_DWIDTH = 16;
	parameter OUTPUT_DWIDTH = 32;

   input	[INPUT_DWIDTH-1:0]	in;
	
   output [OUTPUT_DWIDTH-1:0] out; 
		
	localparam SIGN_BIT_LOCATION = INPUT_DWIDTH-1;
	localparam SIGN_BIT_REPLICATION_COUNT = OUTPUT_DWIDTH - INPUT_DWIDTH;
	
	assign out = {{SIGN_BIT_REPLICATION_COUNT{in[SIGN_BIT_LOCATION]}},in[INPUT_DWIDTH-1:0]};
    
endmodule  



