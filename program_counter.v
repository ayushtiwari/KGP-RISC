module program_counter
(
 	//---------------------------
 	// Input Ports
 	//---------------------------
	input				clk,
	input				rst,
	input		[3:0]	pc_control,
	input		[25:0]	jump_address,
	input		[15:0]	branch_offset,
	input		[31:0] 	reg_address,
	
	//---------------------------
	//	Output Ports
	//---------------------------
	output 		[31:0]  wdata,
    output 	reg [31:0] 	pc

); 
    
 
	reg [31:0] branch_offset_extended;
	
    reg [27:0] jump_address_4x;
    
    assign wdata = pc;
	
    always @ (posedge clk or posedge rst)
	if (rst) begin
        pc = 0;
    end
    else begin
    	case (pc_control)
    		//---------------------------
    		//PC is updated to the next sequential instruction address.
    		//---------------------------
    		4'b0000: pc = pc + 4;
    		
    		//---------------------------
    		//PC is updated with the value contained in the register specified in the instruction. “reg_address” holds the value of the specified register.
    		//---------------------------
    		4'b0001: pc = reg_address;
    		
    		//---------------------------
    		//When the CPU executes an unconditional Jump instruction the new 32-bit PC is the concatenation of the upper 4-bits of PC and the 28-bit result of the jump address multiplied by 4. See definition of the Jump instruction (opcode 2)
    		//---------------------------
    		4'b0010: begin
                jump_address_4x = jump_address*4;
                pc = {pc[31:28] , jump_address_4x[27:0]};
            end
    		
    		4'b0011: begin
    		
    		end
    		//---------------------------
    		//control signals 4'b0100 - 4'b1111 have undefined behaviour, reset PC to 0
    		//---------------------------
    		default: pc = 32'hFFFFFFFF;
    	endcase	
	end
	
endmodule  



