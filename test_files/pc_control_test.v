`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:34:30 11/06/2019
// Design Name:   program_counter
// Module Name:   C:/Users/student/Desktop/New Folder/RISC/pc_control_test.v
// Project Name:  RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: program_counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pc_control_test;

	// Inputs
	reg clk;
	reg rst;
	reg [3:0] pc_control;
	reg [25:0] jump_address;
	reg [31:0] reg_address;

	// Outputs
	wire [31:0] pc;

	// Instantiate the Unit Under Test (UUT)
	program_counter uut (
		.clk(clk), 
		.rst(rst), 
		.pc_control(pc_control), 
		.jump_address(jump_address), 
		.reg_address(reg_address), 
		.pc(pc)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		pc_control = 0;
		jump_address = 5;
		reg_address = 31;

		// Wait 100 ns for global reset to finish
		#50;
        rst = 1;
        clk = 1;
        #50;
        rst = 0;
        clk = 0;
        #50;
        clk = 1;
        pc_control = 0;
        #50;
        clk = 0;
        #50;
        clk = 1;
        pc_control = 1;
        #50;
        clk = 0;
        #50;
        clk = 1;
        pc_control = 2;
        #50;
        clk = 0;
        #50;
        clk = 1;
        pc_control = 3;
		// Add stimulus here

	end
      
endmodule

