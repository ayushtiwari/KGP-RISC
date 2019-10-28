/*
*	This module is responsible for fetching instructions from memory (BRAM).
*/

module instruction_memory
(
	//
	//	Input
	//
	clk,
	address,
	
	//
	//	Output
	//
	instruction
);
	
	input	[31:0]	address;
	
    output 	[31:0] 	instruction;
	
	// Call Intstruction Fetch module
	
	blk_mem_gen_v7_3 mem(.clka(clk), .wea(0), .addra(address), .dina(0), .douta(instruction));
		
    
 endmodule  



