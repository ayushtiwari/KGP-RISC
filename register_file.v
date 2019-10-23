module register_file
(
    //----------------------
    // Inputs
    //----------------------
	input			clk,
    input	[4:0]	raddr0,
	input	[4:0]	raddr1,
	input	[4:0]	waddr,
	input	[31:0]	wdata,
	input 			wren,
	
	//----------------------
	// Outputs
	//----------------------
    output	[31:0] 	rdata0,
	output	[31:0]	rdata1
);
    
    //----------------------
	// Declaration
	//----------------------
	reg [31:0] register_file[0:31];
	
	//----------------------
	// Read Logic
	//----------------------
	assign rdata0 = register_file[raddr0];
	assign rdata1 = register_file[raddr1];
	
	//----------------------
	// Write to register on positive clock edge
	//----------------------
	always @ (posedge clk)
	if (wren) begin
        register_file[waddr]=wdata;
	end
	
	
 endmodule  



