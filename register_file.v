`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:10:40 11/05/2019 
// Design Name: 
// Module Name:    register_file 
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
module register_file
(
	input			 	 clk,
    input		[4:0]	 raddr0,              // instruction[25:21]
	input		[4:0]	 raddr1,              // instruction[20:16]
	input		[4:0]	 waddr,               // instruction[20:16]
	input		[31:0]   wdata0,              // low 32 bits to be written
	input		[31:0]   wdata1,              // high 32 bits to be written
	input 		         wren,                // write enable
	input		[3:0]	 alu_control,         // mult_signal 
	
    output	    [31:0]   rdata0,              // data read from raddr0
	output	    [31:0]   rdata1               // data read from raddr1
);
    
	reg [31:0] register_file[0:31];
	
	integer i;
    
	initial
	begin
		for (i=0; i<32; i=i+1)
			register_file[i] = 32'h00000000;
	end

	assign rdata0 = register_file[raddr0];
	assign rdata1 = register_file[raddr1];

	always @ (negedge clk) begin
		if (wren) begin
			if(alu_control == 4'b0001 || alu_control == 4'b0010) begin
				register_file[19] = wdata0;
				register_file[20] = wdata1;
			end else begin
				register_file[waddr]=wdata0;
			end
		end
	end
	
endmodule  



