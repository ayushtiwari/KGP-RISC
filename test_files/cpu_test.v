`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:30:33 11/06/2019
// Design Name:   cpu
// Module Name:   C:/Users/abhib/Documents/RISC/cpu_test.v
// Project Name:  RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cpu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cpu_test;

	// Inputs
	reg clk;
	reg rst;

	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.clk(clk), 
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#50;
		
		rst = 1;
		
		#50;
		rst = 0;
		
		#50;
		
		clk = 1;
		
		#50;
		
		clk = 0;
		
		#50;
		
		clk = 1;
        
		// Add stimulus here

	end
      
endmodule

