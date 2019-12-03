`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:51:52 11/06/2019
// Design Name:   instruction_fetch
// Module Name:   C:/Users/student/Desktop/New Folder/RISC/instruction_mem_test.v
// Project Name:  RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: instruction_fetch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module instruction_mem_test;

	// Inputs
	reg [31:0] address;

	// Outputs
	wire [31:0] instruction;

	// Instantiate the Unit Under Test (UUT)
	instruction_fetch uut (
		.address(address), 
		.instruction(instruction)
	);

	initial begin
		// Initialize Inputs
		address = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
      address = 4;
        
		// Add stimulus here

	end
      
endmodule

