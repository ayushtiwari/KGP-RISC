`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:08:35 11/05/2019 
// Design Name: 
// Module Name:    instruction_fetch 
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
module instruction_fetch(
    	address,
        instruction
    );
    
	input	[31:0]	address;
	
    output 	[31:0] 	instruction;
		  
    reg	[31:0] instruction_memory [255:0];
	
	integer i;
    
	initial
    
	begin
		for (i=0; i<256; i=i+1)
			instruction_memory[i] = 32'hFFFFFFFF;
			
		$readmemh("program.mips",instruction_memory);
	end
	
	assign instruction = instruction_memory[address[9:2]];
	
	always @(instruction)
	begin
		if (instruction == 32'hFFFFFFFF)
			$stop();
	end
	
endmodule
