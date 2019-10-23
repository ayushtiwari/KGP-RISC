/*
*	Module for reading data from the memory
*/
module data_memory
(
	clk,		//clock
	addr,
	rdata,
	wdata,
	wren
);

    //--------------------------
	// Input Ports
	//--------------------------
	input			clk;
    input	[31:0]	addr;
	input	[31:0]	wdata;
	input 	[3:0]	wren;
	
    //--------------------------
    // Output Ports
    //--------------------------
    output 		[31:0] 	rdata;
		
   	//
  	//	Data Read From Memory 
  	//
	
 endmodule  



