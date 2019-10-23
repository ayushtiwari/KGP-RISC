/*
*	This module is responsible for fetching instructions from memory (BRAM).
*/

module instruction_memory
(
	//
	//	Input
	//
	address,
	
	//
	//	Output
	//
	instruction
);
	
	input	[31:0]	address;
	
    output 	[31:0] 	instruction;
	
	// Call Intstruction Fetch module
		
    
 endmodule  



