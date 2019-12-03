`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:07:31 11/05/2019 
// Design Name: 
// Module Name:    alu 
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
module alu 
(
    //--------------------------
    // Input Ports
    //--------------------------
    input		[31:0]	operand0, 
	input		[31:0]	operand1, 
	input		[3:0]	control,
    input       [4:0]   shamt,
    //--------------------------
    // Output Ports
    //--------------------------
    output reg    [31:0]	result,
    output reg    [31:0]	result1,
	output reg				zFlag,
	output reg				carryFlag,
	output reg				signFlag,
	output reg				overflowFlag
);

    wire signed [31:0] signed_op0;
    assign signed_op0 = operand0;
    
    wire [31:0] sum,sum1,shiftr,shiftl,shiftr_shamt,shiftl_shamt;
    wire [63:0] product1,P1,P2,P3,P4;
    wire [30:0] c1,c2;
    wire cout,cout1;
    HybridAdd A8(operand0,operand1,1'b0,sum,cout);
    HybridAdd A9({operand0[30:0],1'b0},{operand1[30:0],1'b0},1'b0,sum1,cout1);
    assign P1=(operand0[31]&operand1[31])<<(62);
    assign c1={31{operand0[31]}};
    assign c2={31{operand1[31]}};
    assign P2=(operand1[30:0]&c1)<<31;
    assign P3=(operand0[30:0]&c2)<<31;
    arr_mult M10({1'b0,operand0[30:0]},{1'b0,operand1[30:0]},P4);
	arr_mult M12(operand0,operand1,product1);
    BARREL   M19(operand0,1'b0,operand1[4:0],shiftr);
    BARREL   M20(operand0,1'b1,operand1[4:0],shiftl);
    BARREL   M18(operand0,1'b0,shamt,shiftr_shamt);
    BARREL   M17(operand0,1'b1,shamt,shiftl_shamt);
    reg cout3;
	reg [63:0] temp;

    always @(*)

		begin
			case (control)
				//ADD
				4'b0000: 
				       begin
				       				result=sum;
				       				carryFlag=cout;
				       				signFlag=result[31];
				       				zFlag=(result==0)?1'b1:1'b0;
				       				overflowFlag=cout^cout1;
				       end
				//MULT
				4'b0001:
				        begin
						  
				       				temp=P1[62:0]-P2[62:0]-P3[62:0]+P4[62:0];
									result=temp[31:0];
									result1=temp[62:32];
				       				carryFlag=1'b0;
				       				signFlag=result1[30];
				       				zFlag=(result==0)?1'b1:1'b0;
				       				overflowFlag=1'b0;
				       			
				       end
				//MULTU
				4'b0010: 
				       begin
						 	        result=product1[31:0];
                                    result1=product1[62:32];
				       				carryFlag=1'b0;
				       				signFlag=result1[30];
				       				zFlag=(result==0)?1'b1:1'b0;
				       				overflowFlag=1'b0;
				       end
                 //AND
				4'b0011: 
				       begin
								result = operand0 & operand1;
                                overflowFlag=1'b0;
								carryFlag=1'b0;
								zFlag=(result==0)?1'b1:1'b0;
								signFlag=result[31];
						end
                //COMP                       
				4'b0100: 
				       begin
								result = ~operand0;
                                result[0]=result[0]+1;
                                overflowFlag=1'b0;
								carryFlag=1'b0;
								zFlag=(result==0)?1'b1:1'b0;
								signFlag=~operand0[31];
						end	
                        
				//XOR
				4'b0101: 
				       begin
								result = operand0 ^ operand1;
                                overflowFlag=1'b0;
								carryFlag=1'b0;
								zFlag=(result==0)?1'b1:1'b0;
								signFlag=result[31];
						end
                //SHLL                        
                4'b0110:
                        begin
                                result= shiftl_shamt;
                                overflowFlag=1'b0;
								carryFlag=1'b0;
								zFlag=(result==0)?1'b1:1'b0;
								signFlag=result[31];
                        
                        end
                //SHRL                        
                4'b0111:
                        begin
                                result= shiftr_shamt;
                                overflowFlag=1'b0;
								carryFlag=1'b0;
								zFlag=(result==0)?1'b1:1'b0;
								signFlag=result[31];
                        
                        end   

                //SHRA                        
                4'b1000:
                        begin
								result = signed_op0 >>> shamt;
                                overflowFlag=1'b0;
								carryFlag=1'b0;
								zFlag=(result==0)?1'b1:1'b0;
								signFlag=result[31];
                        
                        end                          
				
				//SHIFT LEFT    
				4'b1001:        
				        begin   
								result= shiftl;
                                overflowFlag=1'b0;
								carryFlag=1'b0;
								zFlag=(result==0)?1'b1:1'b0;
								signFlag=result[31];
						end	
				//SHIFT RIGHT
				4'b1010: 
				        begin   
								result= shiftr;
                                overflowFlag=1'b0;
								carryFlag=1'b0;
								zFlag=(result==0)?1'b1:1'b0;
								signFlag=result[31];
						end	
				//SHIFT RIGHT ARITHMETIC
				4'b1011: 
				        begin   
								result = signed_op0 >>> operand1;
                                overflowFlag=1'b0;
								carryFlag=1'b0;
								zFlag=(result==0)?1'b1:1'b0;
								signFlag=result[31];
						  end	
                          
                          
				default:		result=0;
			
			endcase
		end
	
         
endmodule
