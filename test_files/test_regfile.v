`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:00:21 11/06/2019
// Design Name:   register_file
// Module Name:   C:/Users/student/Desktop/New Folder/RISC/test_regfile.v
// Project Name:  RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: register_file
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_regfile;

	// Inputs
	reg clk;
	reg [4:0] raddr0;
	reg [4:0] raddr1;
	reg [4:0] waddr;
	reg [31:0] wdata0;
	reg [31:0] wdata1;
	reg wren;
	reg [3:0] alu_control;

	// Outputs
	wire [31:0] rdata0;
	wire [31:0] rdata1;

	// Instantiate the Unit Under Test (UUT)
	register_file uut (
		.clk(clk), 
		.raddr0(raddr0), 
		.raddr1(raddr1), 
		.waddr(waddr), 
		.wdata0(wdata0), 
		.wdata1(wdata1), 
		.wren(wren), 
		.alu_control(alu_control), 
		.rdata0(rdata0), 
		.rdata1(rdata1)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		raddr0 = 19;
		raddr1 = 20;
		waddr = 0;
		wdata0 = 0;
		wdata1 = 0;
		wren = 0;
		alu_control = 0;

		// Wait 100 ns for global reset to finish
		#50;
        wren=1;
        alu_control = 1;
        wdata0 = 5;
		wdata1 = 6;
        clk=1;
        
        #50;
        clk=0;
        
        #50;
        alu_control = 2;
        wdata0 = 7;
		wdata1 = 8;
        clk=1;
        
        #50;
        clk=0;
        
        #50;
        alu_control = 3;
        wdata0 = 5;
        waddr = 30;
        clk=1;
        
         #50;
        clk=0;
        
        #50;
        wdata0 = 15;
        waddr = 29;
        clk=1;
        
         #50;
        clk=0;
        
         #50;
        wren=0;
        raddr0=30;
        raddr1=29;        
        clk=1;
		// Add stimulus here

	end
      
endmodule

