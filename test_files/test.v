`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:27:26 10/28/2019
// Design Name:   alu
// Module Name:   C:/Users/student/Documents/coafiles2/ALU/test.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////



module test;

	// Inputs
	reg [31:0] operand0;
	reg [31:0] operand1;
	reg [3:0] control;

	// Outputs
	wire [31:0] result;
    wire [31:0] result1;
	wire zFlag;
	wire carryFlag;
	wire signFlag;
	wire overflowFlag;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.operand0(operand0), 
		.operand1(operand1), 
		.control(control), 
		.result(result), 
        .result1(result1),
		.zFlag(zFlag), 
		.carryFlag(carryFlag), 
		.signFlag(signFlag), 
		.overflowFlag(overflowFlag)
	);

	initial begin
		// Initialize Inputs
		operand0 = 32'b00000000000001000000011000000000;
		operand1 = 32'b11111111111111111111111111101001;
		control = 4'b0000;

		// Wait 100 ns for global reset to finish
		#50;
		control = 4'b0001;

		// Wait 100 ns for global reset to finish
		#50;
        
		  control = 4'b0010;

		// Wait 100 ns for global reset to finish
		#50;
        
		  control = 4'b0011;

		// Wait 100 ns for global reset to finish
		#50;
        
		  control = 4'b0100;

		// Wait 100 ns for global reset to finish
		#50;
        
		  control = 4'b0101;

		// Wait 100 ns for global reset to finish
		#50;
        control = 4'b0110;

		// Wait 100 ns for global reset to finish
		#50;
        
		  control = 4'b0111;

		// Wait 100 ns for global reset to finish
		#50;
        control = 4'b1000;

		// Wait 100 ns for global reset to finish
		#50;
        
        
		// Add stimulus here

	end
      
endmodule

