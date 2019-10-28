/*
*	The control unit decodes the instructions and issues the proper control signals
*/
module control_unit
(
	rst,
	instruction,
	data_mem_wren,
	reg_file_wren,
	reg_file_dmux_select,
	reg_file_rmux_select,
	alu_mux_select,
	alu_control,
	zflag,
	carryflag,
	signflag,
	overflowflag,
	alu_shamt,
	pc_control
);

	input				rst;
	input 		[31:0]	instruction;
	input				alu_zero; 
	
	output reg	[3:0]	data_mem_wren;
	output reg			reg_file_wren;
	output reg			reg_file_dmux_select; // Refers to the mux that feeds the wdata bus of the register file
	output reg			reg_file_rmux_select; // Refers to the mux that feeds the waddr bus of the register file
	output reg			alu_mux_select;       // Refers to the mux that feeds the operand1 bus of the alu
	output reg	[3:0]	alu_control;
	output reg	[4:0]	alu_shamt;
	output reg	[3:0]	pc_control;
	
	// Note that all branch type instructions have op[4]=1
	
	localparam //opcodes
		R 		= 6'b000000,
		ADDI 	= 6'b001000,
		COMPI 	= 6'b001100,
		LW 		= 6'b100011,
		SW 		= 6'b101011,
		B 		= 6'b010000,
		BZ 		= 6'b010011,
		BNZ 	= 6'b010011,
		BCY 	= 6'b010100,
		BNCY 	= 6'b010101,
		BS 		= 6'b010110,
		BNS 	= 6'b010111,
		BV 		= 6'b011000,
		BNV		= 6'b011001,
		CALL 	= 6'b011010,
		RET 	= 6'b011011;
		
		
	localparam //function codes
		ADD 	= 6'b100000,
		MULT 	= 6'b011000,
		MULTU 	= 6'b011001,
		AND 	= 6'b100100,
		XOR 	= 6'b100110,
		SHLL 	= 6'b000000,
		SHRL 	= 6'b000010,
		SHRA 	= 6'b000011,
		SHLLV 	= 6'b000100,
		SHRLV 	= 6'b000110,
		SHRAV 	= 6'b000111,
		BR 		= 6'b001000;
	

	localparam //ALU_control codes
		C_ADD 	= 4'b0000;
		C_MULT 	= 4'b0001;
		C_MULTU = 4'b0010;
		C_AND 	= 4'b0011;
		C_COMP	= 4'b0100
		C_XOR	= 4'b0101;
		C_SHLL 	= 4'b0110;
		C_SHRL	= 4'b0111;
		C_SHRA	= 4'b1000;

	
	wire	[5:0]	op;
	wire	[5:0]	funct;
		
	assign op	= instruction[31:26]; //continuously set opcode to first 6 bits of instruction
	assign funct = instruction[5:0];
	
	always @(instruction) begin
		
		
		//---------------------------
		// output [3:0]	data_mem_wren;
		//---------------------------
		if (op == SW && !rst) begin
			data_mem_wren = 4'b1111;
		end else begin
			data_mem_wren = 4'b0000;			
		end
		
		//---------------------------
		// output			reg_file_wren;
		// op[4] == 0 for branch instructions
		//---------------------------
		if (rst || op == SW || op == B || op[4]==1 || funct == BR) begin
			reg_file_wren = 0;
		end else begin
			reg_file_wren = 1;		
		end
		
		//---------------------------
		// output reg_file_dmux_select; 
		// Refers to the mux that feeds the wdata bus of the register file
		//---------------------------
		if (op == LW) begin
			reg_file_dmux_select = 0;
		end else begin
			reg_file_dmux_select = 1;
		end
		
		//---------------------------
		// output reg_file_rmux_select; 
		// Refers to the mux that feeds the waddr bus of the register file
		//---------------------------
		if (op == R) begin
			reg_file_rmux_select = 1;
		end else begin
			reg_file_rmux_select = 0;
		end
		
		//---------------------------
		// output alu_mux_select;       
		// Refers to the mux that feeds the operand1 bus of the alu
		//---------------------------
		if ((op == R || op[4] == 1) && (((op == R) && (funct != SHLL && funct!=SHRL && funct!=SHRA))) begin
			alu_mux_select = 0;
		end else begin // I-type
			alu_mux_select = 1;
		end
		
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
		end else if (op == R && (funct == SHLL || funct == SHLLV)) begin
			alu_control = C_SHLL;
		end else if (op == R && (funct == SHRL || funct == SHRLV)) begin
			alu_control = C_SHRL;
		end else if (op == R && (funct == SHRA || funct == SHRAV)) begin
			alu_control = C_SHRA;
		end else begin
			alu_control = 4'b1111;
		end	
		
		//---------------------------
		// output [4:0]	alu_shamt; 
		//---------------------------
		if (op == R && (funct == SHLL || funct == SHRL || funct == SHRA)) begin
			alu_shamt = instruction[10:6];
		end else begin
			alu_shamt = 5'b00000;
		end
		
		//---------------------------
		// output [3:0]	pc_control;
		//---------------------------
		 
		if (op == R && funct == BR) begin
			pc_control = 4'b0001;
		end else if (op == B
					|| op == CALL
					|| op == BZ && zflag == 0 || op == BNZ && zflag == 1 
					|| op == BCY && carryflag == 0 || op == BNCY && carryflag != 1
					|| op == BS && signflag == 0 || op == BNS && signflag != 1
					|| op == BV && overflowflag == 0 || op == BNV && overflowflag != 1) begin
			pc_control = 4'b0010;
		end else if (op == RET) begin
			pc_control = 4'b0011;
		end else begin
			// PC = PC+4
			pc_control = 4'b0000;
		end
		
	end

endmodule  


