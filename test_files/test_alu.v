`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:13:12 11/06/2019
// Design Name:   alu
// Module Name:   C:/Users/student/Desktop/New Folder/RISC/test_alu.v
// Project Name:  RISC
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

module test_alu;

	// Inputs
	reg [31:0] operand0;
	reg [31:0] operand1;
	reg [3:0] control;
	reg [4:0] shamt;

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
		.shamt(shamt), 
		.result(result), 
		.result1(result1), 
		.zFlag(zFlag), 
		.carryFlag(carryFlag), 
		.signFlag(signFlag), 
		.overflowFlag(overflowFlag)
	);

	initial begin
		// Initialize Inputs
		operand0 = -3;
		operand1 = 1;
		control = 4'b0000;
		shamt = 0;

		// Wait 100 ns for global reset to finish
		#50;
        operand0 = -3;
		operand1 = -1;
		control = 4'b0001;
		shamt = 0;
        #50;
        operand0 = 3;
		operand1 = 1;
		control = 4'b0010;
		shamt = 0;
        #50;
		control = 4'b0011;
		shamt = 0;
          #50;
		control = 4'b0100;
          #50;
		control = 4'b0101;
         #50;
        operand0 = -11;
		operand1 = 2;
		control = 4'b0110;
        shamt = 2;
        #50;
        control = 4'b0111;
        #50;
        control = 4'b1000;
        #50;
        control = 4'b1001;
         #50;
        control = 4'b1010;
         #50;
        control = 4'b1011;
        
		// Add stimulus here

	end
      
endmodule

