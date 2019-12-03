`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:07:01 11/05/2019 
// Design Name: 
// Module Name:    cpu 
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
module cpu(
    clk,
	 rst
    );
	 
	 input clk;
	 input rst;
	 
	 wire [31:0]   pc;
	 wire [31:0]   next_pc;
	 
	 wire [31:0] 	instruction;
	 wire [31:0] 	instruction_sign_extended;
	 
	 wire 			data_mem_wren;
	 wire 			reg_file_wren;
	 wire 			reg_file_dmux_select_0;
	 wire [31:0]	dmux_0_output;
	 wire 			reg_file_dmux_select_1;
	 
	 wire			reg_file_radd0_select;
	 
	 wire 			alu_mux_select;
	 wire [3:0]		alu_control;
	 wire [3:0] 	pc_control;
	 
	 wire [4:0]		waddr;
	 
	 wire [31:0]	rdata0;
	 wire [31:0]	rdata1;
	 wire [31:0]	wdata0;
	 
	 wire [31:0]   alu_result_high;			// Used only during mult instruction
	 
	 wire [31:0]	alu_operand1;
	 wire [31:0]	alu_result;
	 wire [4:0]		shamt;
	 
	 reg		alu_flag_overflow;
	 reg		alu_flag_zero;
	 reg		alu_flag_signed;
	 reg		alu_flag_carry;
	 
	 wire [31:0] 	datamemeory_rdata;
	 
	 wire [4:0]		radd0;
	 wire [4:0]		radd1;
	 
	 // Instantiations
	 
     // Tested
	 program_counter prog_cnt(.clk(clk),
							  .rst(rst),
							  .pc_control(pc_control),
							  .jump_address(instruction[25:0]),
							  .reg_address(rdata0),
							  .pc(pc)
							 );
									  
     // Tested                                   
	 instruction_fetch inst_mem(.address(pc),
								.instruction(instruction)
								);
										 
	 
	 control_unit cntrl_unit(.instruction(instruction),
									 .rst(rst),
									 .data_mem_wren(data_mem_wren),
									 .reg_file_wren(reg_file_wren),
									 .reg_file_dmux_select_0(reg_file_dmux_select_0),
									 .reg_file_dmux_select_1(reg_file_dmux_select_1),
									 .reg_file_rmux_select(reg_file_rmux_select),
									 .reg_file_radd0_select(reg_file_radd0_select),
									 .alu_mux_select(alu_mux_select),
									 .alu_control(alu_control),
									 .z_flag(alu_flag_zero),
									 .carry_flag(alu_flag_carry),
									 .sign_flag(alu_flag_sign),
									 .overflow_flag(alu_flag_overflow),
									 .alu_shamt(alu_shamt),
									 .pc_control(pc_control)
									 );
					
	 
     // Tested
	 sign_extension instr_sign_extend(.in(instruction[15:0]),
												 .out(instruction_sign_extended)
												 );
	 
     // Checked
	 mux_2to1 #(.DWIDTH(5)) reg_file_to_write_select_mux(.in0(radd1),
														 .in1(5'b11110),
														 .out(waddr),
														 .sel(reg_file_rmux_select)
														 );
	 // Tested																	  
	 register_file reg_file(.clk(clk),
									.raddr0(radd0),
									.rdata0(rdata0),
									.raddr1(radd1),
									.rdata1(rdata1),
									.waddr(waddr),
									.wdata0(wdata0),
									.wdata1(alu_result_high),
									.wren(reg_file_wren),
									.alu_control(alu_control)
									);
									
	 
     // Checked     
	 mux_2to1 alu_operand1_select_mux(.in0(rdata0),
									  .in1(instruction_sign_extended),
									  .out(alu_operand1),
									  .sel(alu_mux_select)
									  );
	 
     // Tested
	 alu alu_(.control(alu_control),
				 .operand0(rdata0),
				 .operand1(alu_operand1),
				 .result(alu_result),
				 .result1(result_high),
				 .overflowFlag(alu_overflow_flag),
				 .zFlag(alu_zero_flag),
				 .carryFlag(alu_carry_flag),
				 .signFlag(alu_sign_flag),
				 .shamt(shamt)
				 );
				 
	 // Looks good 
	 data_memory data_mem(.clk(clk),
								 .addr(alu_result),
								 .rdata(data_memory_rdata),
								 .wdata(rdata1),
								 .wren(data_mem_wren)
								 );
     // Looks good                          
     mux_2to1 data_memory_alu_result_select1(.in0(datamemory_rdata),
											  .in1(alu_result),
											  .out(dmux_0_output),
											  .sel(reg_file_dmux_select_0)
											  );
     // Looks good 
	 mux_2to1 pc_data_memory_alu_result_select2(.in0(dmux_0_output),
											    .in1(next_pc),
												.out(wdata0),
												.sel(reg_file_dmux_select_1)
												);
														 
	
														 
	 // Looks good
	 mux_2to1 radd0_select(.in0(instruction[25:21]),
								  .in1(5'b11110),
								  .out(radd0),
								  .sel(reg_file_radd0_select)
								  );
								  
	 assign radd1 = instruction[20:16]; 
	 assign next_pc = pc+4;							  
								    

endmodule
