

//This is an external file which contains the period of the clock (CYCLE) 
//and the delay for driving outputs into the clocking block (Tdrive).

`include "CYCLE.sv"

interface ALU_if_a;


logic        srcCy, srcAc, bit_in, clk, rst;
logic  [3:0] op_code;
logic  [7:0] src1, src2, src3;
logic       desCy, desAc, desOv;
logic [7:0] des1, des2, des_acc, sub_result;


	clocking cb_a @(posedge clk); 
		default input #1step output `Tdrive; 
				input  desCy, desAc, desOv,des1, des2, des_acc, sub_result;
				inout srcCy, srcAc, bit_in, rst,op_code,src1, src2, src3;
	endclocking

endinterface: ALU_if_a



