`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:08:12 11/05/2019 
// Design Name: 
// Module Name:    program_counter 
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
module program_counter
(

   input			  clk,
   input		      rst,
   input	  [3:0]	  pc_control,
   input	  [25:0]  jump_address,
   input	  [31:0]  reg_address,
	
   output reg [31:0]  pc

); 
	
   reg [27:0] jump_address_4x;
	
   always @ (posedge clk or posedge rst) begin
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
                //PC is updated with the value contained in the register specified in the instruction. "reg_address" holds the value of the specified register.
                //---------------------------
                4'b0001: pc = reg_address;
                
                //---------------------------
                //When the CPU executes an unconditional Jump instruction the new 32-bit PC is the concatenation of the upper 4-bits of PC and the 28-bit result of the jump address multiplied by 4. See definition of the Jump instruction (opcode 2)
                //---------------------------
                4'b0010: begin
                   jump_address_4x = jump_address << 2;
                   pc = {pc[31:28] , jump_address_4x[27:0]};
                end
                
                //---------------------------
                //control signals 4'b0100 - 4'b1111 have undefined behaviour, reset PC to 0
                //---------------------------
                default: pc = 32'hFFFFFFFF;
            endcase	
        end
	end
endmodule  




