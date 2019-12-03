`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:29:37 11/06/2019
// Design Name:   control_unit
// Module Name:   C:/Users/abhib/Documents/RISC/control_unit_test.v
// Project Name:  RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: control_unit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module control_unit_test;

	// Inputs
	reg rst;
	reg [31:0] instruction;
	reg z_flag;
	reg carry_flag;
	reg sign_flag;
	reg overflow_flag;

	// Outputs
	wire data_mem_wren;
	wire reg_file_wren;
	wire reg_file_dmux_select_0;
	wire reg_file_dmux_select_1;
	wire reg_file_rmux_select;
	wire alu_mux_select;
	wire [3:0] alu_control;
	wire [4:0] alu_shamt;
	wire reg_file_radd0_select;
	wire [3:0] pc_control;

	// Instantiate the Unit Under Test (UUT)
	control_unit uut (
		.rst(rst), 
		.instruction(instruction), 
		.data_mem_wren(data_mem_wren), 
		.reg_file_wren(reg_file_wren), 
		.reg_file_dmux_select_0(reg_file_dmux_select_0), 
		.reg_file_dmux_select_1(reg_file_dmux_select_1), 
		.reg_file_rmux_select(reg_file_rmux_select), 
		.alu_mux_select(alu_mux_select), 
		.alu_control(alu_control), 
		.z_flag(z_flag), 
		.carry_flag(carry_flag), 
		.sign_flag(sign_flag), 
		.overflow_flag(overflow_flag), 
		.alu_shamt(alu_shamt), 
		.reg_file_radd0_select(reg_file_radd0_select), 
		.pc_control(pc_control)
	);

	initial begin
		// Initialize Inputs
		rst = 0;
		instruction = 0;
		z_flag = 0;
		carry_flag = 0;
		sign_flag = 0;
		overflow_flag = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		instruction = 32'b00100001010010100000000000000001;
		
		#100;
		
		#100;
		
		instruction = 32'b00000001011010100000000000100000;
		
		#100;
		
		instruction = 32'b00000001011010100000000000011000;
		
		#100;
		
		instruction = 32'b10101101011010100000000000000010;
		
		#100;
		
		instruction = 32'b00000001011010100000000010000000;
		
		#100;
		
		instruction = 32'b10001101011010100000000000000010;
		
		#100;
		
		instruction = 32'b01000000000000000000000000000000;
		
		#100;
		
		instruction = 32'b01010000000000000000000000000000;
		
		#100;
		
		instruction = 32'b01101000000000000000000000000000;
		
		#100;
		
		instruction = 0;
        
		// Add stimulus here

	end
      
endmodule

