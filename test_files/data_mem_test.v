`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:44:07 11/06/2019
// Design Name:   data_memory
// Module Name:   C:/Users/student/Desktop/New Folder/RISC/data_mem_test.v
// Project Name:  RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: data_memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module data_mem_test;

	// Inputs
	reg clk;
	reg [31:0] addr;
	reg [31:0] wdata;
	reg [3:0] wren;

	// Outputs
	wire [31:0] rdata;

	// Instantiate the Unit Under Test (UUT)
	data_memory uut (
		.clk(clk), 
		.addr(addr), 
		.rdata(rdata), 
		.wdata(wdata), 
		.wren(wren)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		addr = 0;
		wdata = 0;
		wren = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
        addr = 65532*4;
        wdata=125;
        wren=1;
        
        clk = 1;
        
        
        #100;
        clk = 0;
        
        #100;
        addr = 65530*4;
        wdata=55;
        
        clk = 1;
        
        
        #100;
        clk = 0;
        
        
        
        #100;
        wren = 0;
        clk = 1;
        addr=65532*4;
        
		// Add stimulus here

	end
      
endmodule

