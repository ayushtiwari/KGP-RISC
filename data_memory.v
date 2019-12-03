`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:10:12 11/05/2019 
// Design Name: 
// Module Name:    data_memory 
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
module data_memory

(
	clk,		//clock
	addr,
	rdata,
	wdata,
	wren
);


	input				clk;
    input 		[31:0]	addr;
	input		[31:0]	wdata;
	input 		[3:0]	wren;
    
    output 		[31:0] 	rdata;

    reg	   [31:0] data_memory	[65535:0];

	wire   [15:0] data_addr;
	assign data_addr = addr[17:2];
	assign rdata = data_memory[data_addr];
							
    always @(posedge clk)
	begin
		if (wren)
			data_memory[data_addr] <= wdata[31:0];
	end
	
 endmodule  
