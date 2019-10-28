module alu 
(
    //--------------------------
    // Input Ports
    //--------------------------
    input		[31:0]	operand0, 
	input		[31:0]	operand1, 
	input		[3:0]	control,
    //--------------------------
    // Output Ports
    //--------------------------
    output		[31:0]	result,
	output				zflag,
	output				carryflag,
	output				signflag,
	output 				overflowflag
);
    

	assign result 	= alu_function(control, operand0, operand1);
	
	assign zero 	= (result == 0) ? 1'b1 : 1'b0;
	assign overflow = (operand0[31] == operand1[31]) && (result[31] != operand0[31]);
	assign signflag = result[31];
    
	function [31:0] alu_function;
		input [3:0] control;
        input [31:0] operand0;
        input [31:0] operand1;
		begin
			case (control)
				//ADD
				4'b0000: alu_function = operand0 + operand1;
				//MULT
				4'b0001: alu_function = operand0 * operand1;
				//MULTU
				4'b0010: alu_function = $signed(operand0) * $signed(operand1);
				//OR
				4'b0011: alu_function = operand0 | operand1;
				//XOR
				4'b0100: alu_function = operand0 ^ operand1;
				//NOR
				4'b0101: alu_function = operand0 ~| operand1;
				//SHIFT LEFT
				4'b0110: alu_function = operand0 << operand1;
				//SHIFT RIGHT
				4'b0111: alu_function = operand0 >> operand1;
				//SHIFT RIGHT ARITHMETIC
				4'b1000: alu_function = $signed(operand0) >>> operand1;
			endcase
		end
	endfunction
         
endmodule

