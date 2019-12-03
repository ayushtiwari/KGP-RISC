`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:07:18 11/05/2019 
// Design Name: 
// Module Name:    control_unit 
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
/*
*	The control unit decodes the instructions and issues the proper control signals
*/
module control_unit
(
	rst,                        // reset
	instruction,                // fetched instruction
	data_mem_wren,              // data memory write enable
	reg_file_wren,              // register file write enable
	reg_file_dmux_select_0,     // Choses between alu_result, data_memory_read
   reg_file_dmux_select_1,     // choses between result of mux_0 and value of pc
   reg_file_rmux_select,       // choses between instruction[20:16] and 1 ($ra)
	alu_mux_select,             // mux that feeds the operand1 bus 
	alu_control,                // alu operation selector
	z_flag,                     // zero flag from alu 
	carry_flag,                 // carry flag from alu
	sign_flag,                  // sign flag from alu
	overflow_flag,              // overflow flag from alu
	alu_shamt,				    // shift amout fro shll etc.
	reg_file_radd0_select,
	pc_control                  // pc control signal
);

   input	           rst;
   input     [31:0] instruction;
   input	           z_flag;
   input            carry_flag;
   input            sign_flag;
   input            overflow_flag;
	
   output reg	     data_mem_wren;
   output reg		  reg_file_wren;
   output reg	     reg_file_dmux_select_0; 
   output reg		  reg_file_dmux_select_1; 
	output reg		  reg_file_rmux_select; 
	
	output reg		  alu_mux_select;
	output reg [3:0] alu_control;
	
	output reg [4:0] alu_shamt;
	output reg		  reg_file_radd0_select;
	
	output reg [3:0] pc_control;
	
	// Note that all branch type instructions have op[4]=1
	
	localparam //opcodes
		R 		= 6'b000000,
		ADDI 	= 6'b001000,
		COMPI = 6'b001100,
		LW 	= 6'b100011,
		SW 	= 6'b101011,
		B 		= 6'b010000,
		BZ 	= 6'b010011,
		BNZ 	= 6'b010011,
		BCY 	= 6'b010100,
		BNCY 	= 6'b010101,
		BS 	= 6'b010110,
		BNS 	= 6'b010111,
		BV 	= 6'b011000,
		BNV	= 6'b011001,
		CALL 	= 6'b011010,
		RET 	= 6'b011011;
		
		
	localparam //function codes
		ADD 	= 6'b100000,
		MULT 	= 6'b011000,
		MULTU = 6'b011001,
		AND 	= 6'b100100,
		XOR 	= 6'b100110,
		COMP  = 6'b100111,
		SHLL 	= 6'b000000,
		SHRL 	= 6'b000010,
		SHRA 	= 6'b000011,
		SHLLV = 6'b000100,
		SHRLV = 6'b000110,
		SHRAV = 6'b000111,
		BR 	= 6'b001000;
	

	localparam //ALU_control codes
		C_ADD 	= 4'b0000,
		C_MULT 	= 4'b0001,
		C_MULTU  = 4'b0010,
		C_AND 	= 4'b0011,
		C_COMP	= 4'b0100,
		C_XOR	   = 4'b0101,
		C_SHLL 	= 4'b0110,
		C_SHRL	= 4'b0111,
		C_SHRA	= 4'b1000,
      C_SHLLV  = 4'b1001,
      C_SHRLV  = 4'b1010,
      C_SHRAV  = 4'b1011;

	
	wire	[5:0]	op;
	wire	[5:0]	funct;
		
	assign op	= instruction[31:26]; //continuously set opcode to first 6 bits of instruction
	assign funct = instruction[5:0];
	
	always @(op or funct) begin
		
		// Checked
		//---------------------------
		// output [3:0]	data_mem_wren;
		//---------------------------
		if ((op == SW && !rst)) begin
			data_mem_wren = 1'b1;
		end else begin
			data_mem_wren = 1'b0;			
		end
		
        // Checked
		//---------------------------
		// output			reg_file_wren;
		// op[4] == 1 for branch instructions
		//---------------------------
		if (op == SW || (op[4] == 1 && op != CALL) || funct == BR) begin
			reg_file_wren = 0;
		end else begin
			reg_file_wren = 1;		
		end
		
        // Checked
		//---------------------------
		// output reg_file_dmux_select_0;
        // output reg_file_dmux_select_1; 
		// Refers to the mux that feeds the wdata bus of the register file
		//---------------------------
		if (op == CALL) begin
			reg_file_dmux_select_1 = 1;				// Select PC
			reg_file_dmux_select_0 = 0;
      end else begin
			reg_file_dmux_select_1 = 0;				// Select value from previous
			
			if (op == LW) begin
				reg_file_dmux_select_0 = 0;			// Select datamemory_rdata
			end else begin
				reg_file_dmux_select_0 = 1;			// Select the value from alu_result
			end
      end
        
        // Checked
       if (op == RET) begin
			reg_file_radd0_select = 1;					// Selects registor no. 30
		end else begin
			reg_file_radd0_select = 0;					// Selects instruction[25:21]
		end
		
        // Checked
		//---------------------------
		// output reg_file_rmux_select; 
		// Refers to the mux that feeds the waddr bus of the register file
		//---------------------------
		if (op == CALL) begin
			reg_file_rmux_select = 1;
		end else begin
			reg_file_rmux_select = 0;
		end
		
        // Checked
		//---------------------------
		// output alu_mux_select;       
		// Refers to the mux that feeds the operand1 bus of the alu
		//---------------------------
		if ((op == ADDI) || (op == COMPI) || (op == LW) || (op == SW)) begin
			alu_mux_select = 1;						// Feed instruction[15:0] as operand 1
		end else begin	
			alu_mux_select = 0;						// Feed instruction[25:21] as operand 1
		end
		
        // Checked
		//---------------------------
		// output [3:0]	alu_control;
		//---------------------------
		if ((op == R && funct == ADD) || op == SW || op == ADDI || op == LW) begin
			alu_control = C_ADD;
		end else if (op == R && funct == MULT) begin
			alu_control = C_MULT;
		end else if (op == R && funct == MULTU) begin
			alu_control = C_MULTU;
		end else if (op == R && funct == AND) begin
			alu_control = C_AND;
		end else if (op == R && funct == XOR) begin
			alu_control = C_XOR;
		end else if (op == R && funct == SHLL) begin
			alu_control = C_SHLL;
		end else if (op == R && funct == SHRL) begin
			alu_control = C_SHRL;
		end else if (op == R && funct == SHRA) begin
			alu_control = C_SHRA;
      end else if (op == R && funct == SHLLV) begin
			alu_control = C_SHLLV;
		end else if (op == R && funct == SHRLV) begin
			alu_control = C_SHRLV;
		end else if (op == R && funct == SHRAV) begin
			alu_control = C_SHRAV;
		end else if (op == R && funct == COMP || op == COMPI) begin
			alu_control = C_COMP;
		end else begin
			alu_control = 4'b1111;
		end	
		 
        // Looks good
		//---------------------------
		// output [4:0]	alu_shamt; 
		//---------------------------
		if (op == R && (funct == SHLL || funct == SHRL || funct == SHRA)) begin
			alu_shamt = instruction[10:6];
		end else begin
			alu_shamt = 5'b00000;
		end
		
        
        // Seems good
		//---------------------------
		// output [3:0]	pc_control;
		//---------------------------
		if (op == R && funct == BR) begin
			pc_control = 4'b0001;
		end else if (op == B
					|| op == CALL
					|| op == BZ && z_flag == 1 || op == BNZ && z_flag != 1 
					|| op == BCY && carry_flag == 1 || op == BNCY && carry_flag != 1
					|| op == BS && sign_flag == 1 || op == BNS && sign_flag != 1
					|| op == BV && overflow_flag == 1 || op == BNV && overflow_flag != 1) begin
			pc_control = 4'b0010;
		end else if (op == RET) begin
			pc_control = 4'b0001;
		end else begin
			// PC = PC+4
			pc_control = 4'b0000;
		end
		
	end

endmodule  


