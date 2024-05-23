

`include "oc8051_defines.v"

class ALU_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(ALU_scoreboard)




    //output reference sequence item from the reference model.
    ALU_sequence_item reference_item_h;   
    
    // incoming sequence item from the monitor
    ALU_sequence_item sequence_item_h;

     int num_correct, num_false;


    uvm_analysis_imp # (ALU_sequence_item, ALU_scoreboard) ALU_analysis_imp;

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "ALU_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("ALU_scoreboard", "constructor", UVM_HIGH)
    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Build Phase =========================================
    // ----------------------------------------------------------------------------------------------- */

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("ALU_scoreboard", "build phase", UVM_HIGH)
        sequence_item_h = ALU_sequence_item::type_id::create("sequence_item_h");
        
        reference_item_h = ALU_sequence_item::type_id::create("reference_item_h");

        ALU_analysis_imp = new("ALU_analysis_imp", this);
    endfunction: build_phase



    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Other Methods ========================================
    // ----------------------------------------------------------------------------------------------- */

    function void write(ALU_sequence_item t);
  
       sequence_item_h = t;
       
       // copy the inputs from the sequence item into an empty reference item.
                set_ref_item();
                
//use the reference item inputs to calculate the expected outputs and copy them into the reference item.
                reference_function(reference_item_h);
                sequence_item_h.display_out("DUT OUTPUT");
                reference_item_h.display_out("REFERENCE OUTPUT");

                //check for discrepencies between the DUT output and the reference output. 
                checkerrors();

    endfunction: write



//take inputs from the incoming combined sequence item and set the outputs to zero.
 function  void set_ref_item();

            reference_item_h.rst = sequence_item_h.rst;
            reference_item_h.srcCy = sequence_item_h.srcCy;
            reference_item_h.srcAc = sequence_item_h.srcAc;
            reference_item_h.bit_in = sequence_item_h.bit_in;
            reference_item_h.op_code = sequence_item_h.op_code;
            reference_item_h.src1 = sequence_item_h.src1;
            reference_item_h.src2 = sequence_item_h.src2;
            reference_item_h.src3 = sequence_item_h.src3;

        

            reference_item_h.desCy = 0;
            reference_item_h.desAc = 0;
            reference_item_h.desOv = 0;
            reference_item_h.des1 = 0;
            reference_item_h.des2 = 0;
            reference_item_h.des_acc = 0;
            reference_item_h.sub_result = 0;

endfunction














//two error files to store different types of messages.
        int info_file,error_file;

     function void start_of_simulation_phase(uvm_phase phase);
      	
		info_file = $fopen("info_file_ALU.txt","w");
		error_file = $fopen("Error_file_ALU.txt","w");

		set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
		set_report_severity_action_hier(UVM_ERROR,UVM_DISPLAY | UVM_COUNT | UVM_LOG);
		set_report_severity_file_hier(UVM_ERROR,error_file);
		set_report_severity_file_hier(UVM_INFO,info_file);
    endfunction: start_of_simulation_phase






//Error flags to see if any error occured in this clock cycle
bit desCy_errors_flag;
bit desAc_errors_flag;
bit desOv_errors_flag;
bit des1_errors_flag;
bit des2_errors_flag;
bit des_acc_errors_flag;
bit sub_result_errors_flag;



function void checkerrors();


    desCy_errors_flag  = 0;
    desAc_errors_flag  = 0;
    desOv_errors_flag  = 0;
    des1_errors_flag  = 0;
    des2_errors_flag  = 0;
    des_acc_errors_flag  = 0;
    sub_result_errors_flag  = 0;



        if(reference_item_h.desCy!=sequence_item_h.desCy)begin
        desCy_errors_flag =1;
        end

        if(reference_item_h.desAc!=sequence_item_h.desAc)begin
        desAc_errors_flag =1;
        end


        if(reference_item_h.desOv!=sequence_item_h.desOv)begin
        desOv_errors_flag =1;
        end

        if(reference_item_h.des1!=sequence_item_h.des1)begin
        des1_errors_flag =1;
        end


        if(reference_item_h.des2!=sequence_item_h.des2)begin
        des2_errors_flag =1;
        end

        if(reference_item_h.des_acc!=sequence_item_h.des_acc)begin
        des_acc_errors_flag =1;
        end


        if(reference_item_h.desCy!=sequence_item_h.desCy)begin
        desCy_errors_flag =1;
        end

        if(reference_item_h.sub_result!=sequence_item_h.sub_result)begin
        sub_result_errors_flag =1;
        end



// If any errors were found, prepare to file an error massage.
    if( desCy_errors_flag ||
        desAc_errors_flag ||
        desOv_errors_flag ||
        des1_errors_flag ||
        des2_errors_flag ||
        des_acc_errors_flag ||
        sub_result_errors_flag
            ) begin


        `uvm_error("ALU_scoreboard"," The following errors occured:")

//only print the specific error that occured

        if(desCy_errors_flag)begin
        $display("expected desCy = %b , but recieved = %b",reference_item_h.desCy,sequence_item_h.desCy);
        $fwrite(error_file,"expected desCy = %b , but recieved = %b \n",reference_item_h.desCy,sequence_item_h.desCy);
        end


        if(desAc_errors_flag)begin
        $display("expected desAc = %h , but recieved = %h",reference_item_h.desAc,sequence_item_h.desAc);
        $fwrite(error_file,"expected desAc = %h , but recieved = %h \n",reference_item_h.desAc,sequence_item_h.desAc);
        end


        if(desOv_errors_flag)begin
        $display("expected desOv = %h , but recieved = %h",reference_item_h.desOv,sequence_item_h.desOv);
        $fwrite(error_file,"expected desOv = %h , but recieved = %h \n",reference_item_h.desOv,sequence_item_h.desOv);
        end


        if(des1_errors_flag)begin
        $display("expected des1 = %h , but recieved = %h",reference_item_h.des1,sequence_item_h.des1);
        $fwrite(error_file,"expected des1 = %h , but recieved = %h \n",reference_item_h.des1,sequence_item_h.des1);
        end


        if(des2_errors_flag)begin
        $display("expected des2 = %h , but recieved = %h",reference_item_h.des2,sequence_item_h.des2);
        $fwrite(error_file,"expected des2 = %h , but recieved = %h \n",reference_item_h.des2,sequence_item_h.des2);
        end


        if(des_acc_errors_flag)begin
        $display("expected des_acc = %h , but recieved = %h",reference_item_h.des_acc,sequence_item_h.des_acc);
        $fwrite(error_file,"expected des_acc = %h , but recieved = %h \n",reference_item_h.des_acc,sequence_item_h.des_acc);
        end


        if(sub_result_errors_flag)begin
        $display("expected sub_result = %h , but recieved = %h",reference_item_h.sub_result,sequence_item_h.sub_result);
        $fwrite(error_file,"expected sub_result = %h , but recieved = %h \n",reference_item_h.sub_result,sequence_item_h.sub_result);
        end


        $fwrite(error_file,"\n \n");
        
            end

endfunction














// reference function to compare with the DUT outputs. Since there was no specification file provided for the ALU,
// we unfortunatly had to copy the ALU RTL into the reference function, even though this defeats the porpuse of error checking.

        function automatic void reference_function( ref ALU_sequence_item reference_item_h);

                
        //
        //add
        //
        static logic [4:0] add1, add2, add3, add4;
        static logic [3:0] add5, add6, add7, add8;
        static logic [1:0] add9, adda, addb, addc;
        
        //
        //sub
        //
        static logic [4:0] sub1, sub2, sub3, sub4;
        static logic [3:0] sub5, sub6, sub7, sub8;
        static logic [1:0] sub9, suba, subb, subc;
        static logic [7:0] sub_result;
        
        //
        //mul
        //
        static logic [7:0] mulsrc1, mulsrc2;
        static logic mulOv;
        static logic enable_mul;
        
        //
        //div
        //
        static logic [7:0] divsrc1,divsrc2;
        static logic divOv;
        static logic enable_div;
        
        //
        //da
        //
        static logic da_tmp, da_tmp1;
        //reg [8:0] da1;
        
        //
        // inc
        //
        static logic [15:0] inc, dec;
        


        // Multiplier signals

                        // wires
                        static logic [15:0] mul_result1, mul_result, shifted;
                        
                        // real registers
                        static logic [1:0] cycle;
                        static logic [15:0] tmp_mul;




        // Divider signals
                                        static logic div0, div1;
                        static logic [7:0] rem0, rem1, rem2;
                        static logic [8:0] sub0, sub1_div;
                        static logic [15:0] cmp0, cmp1;
                        static logic [7:0] div_out, rem_out;
                        
                        // real registers
                        static logic [1:0] cycle_div;
                        static logic [5:0] tmp_div;
                        static logic [7:0] tmp_rem;
                        


        /* Add */
        add1 = {1'b0,reference_item_h.src1[3:0]};
        add2 = {1'b0,reference_item_h.src2[3:0]};
        add3 = {3'b000,reference_item_h.srcCy};
        add4 = add1+add2+add3;
        
        add5 = {1'b0,reference_item_h.src1[6:4]};
        add6 = {1'b0,reference_item_h.src2[6:4]};
        add7 = {1'b0,1'b0,1'b0,add4[4]};
        add8 = add5+add6+add7;
        
        add9 = {1'b0,reference_item_h.src1[7]};
        adda = {1'b0,reference_item_h.src2[7]};
        addb = {1'b0,add8[3]};
        addc = add9+adda+addb;
        
        /* Sub */
        sub1 = {1'b1,reference_item_h.src1[3:0]};
        sub2 = {1'b0,reference_item_h.src2[3:0]};
        sub3 = {1'b0,1'b0,1'b0,reference_item_h.srcCy};
        sub4 = sub1-sub2-sub3;
        
        sub5 = {1'b1,reference_item_h.src1[6:4]};
        sub6 = {1'b0,reference_item_h.src2[6:4]};
        sub7 = {1'b0,1'b0,1'b0, !sub4[4]};
        sub8 = sub5-sub6-sub7;
        
        sub9 = {1'b1,reference_item_h.src1[7]};
        suba = {1'b0,reference_item_h.src2[7]};
        subb = {1'b0,!sub8[3]};
        subc = sub9-suba-subb;
        
        reference_item_h.sub_result = {subc[0],sub8[2:0],sub4[3:0]};
        
        /* inc */
        inc = {reference_item_h.src2, reference_item_h.src1} + {15'h0, 1'b1};
        dec = {reference_item_h.src2, reference_item_h.src1} - {15'h0, 1'b1};
        




        case (reference_item_h.op_code) /* synopsys full_case parallel_case */
        //operation add
            `OC8051_ALU_ADD: begin
            reference_item_h.des_acc = {addc[0],add8[2:0],add4[3:0]};
            reference_item_h.des1 = reference_item_h.src1;
            reference_item_h.des2 = reference_item_h.src3+ {7'b0, addc[1]};
            reference_item_h.desCy = addc[1];
            reference_item_h.desAc = add4[4];
            reference_item_h.desOv = addc[1] ^ add8[3];
        
            enable_mul = 1'b0;
            enable_div = 1'b0;
            end
        //operation subtract
            `OC8051_ALU_SUB: begin
            reference_item_h.des_acc = reference_item_h.sub_result;
        //      reference_item_h.des1 = reference_item_h.sub_result;
            reference_item_h.des1 = 8'h00;
            reference_item_h.des2 = 8'h00;
            reference_item_h.desCy = !subc[1];
            reference_item_h.desAc = !sub4[4];
            reference_item_h.desOv = !subc[1] ^ !sub8[3];
        
            enable_mul = 1'b0;
            enable_div = 1'b0;
            end
        //operation multiply
            `OC8051_ALU_MUL: begin
            reference_item_h.des_acc = mulsrc1;
            reference_item_h.des1 = reference_item_h.src1;
            reference_item_h.des2 = mulsrc2;
            reference_item_h.desOv = mulOv;
            reference_item_h.desCy = 1'b0;
            reference_item_h.desAc = 1'b0;
            enable_mul = 1'b1;
            enable_div = 1'b0;
            end
        //operation divide
            `OC8051_ALU_DIV: begin
            reference_item_h.des_acc = divsrc1;
            reference_item_h.des1 = reference_item_h.src1;
            reference_item_h.des2 = divsrc2;
            reference_item_h.desOv = divOv;
            reference_item_h.desAc = 1'b0;
            reference_item_h.desCy = 1'b0;
            enable_mul = 1'b0;
            enable_div = 1'b1;
            end
        //operation decimal adjustment
            `OC8051_ALU_DA: begin
        
            if (reference_item_h.srcAc==1'b1 | reference_item_h.src1[3:0]>4'b1001) {da_tmp, reference_item_h.des_acc[3:0]} = {1'b0, reference_item_h.src1[3:0]}+ 5'b00110;
            else {da_tmp, reference_item_h.des_acc[3:0]} = {1'b0, reference_item_h.src1[3:0]};
        
            if (reference_item_h.srcCy | da_tmp | reference_item_h.src1[7:4]>4'b1001)
                {da_tmp1, reference_item_h.des_acc[7:4]} = {reference_item_h.srcCy, reference_item_h.src1[7:4]}+ 5'b00110 + {4'b0, da_tmp};
            else {da_tmp1, reference_item_h.des_acc[7:4]} = {reference_item_h.srcCy, reference_item_h.src1[7:4]} + {4'b0, da_tmp};
        
            reference_item_h.desCy = da_tmp | da_tmp1;
            reference_item_h.des1 = reference_item_h.src1;
            reference_item_h.des2 = 8'h00;
            reference_item_h.desAc = 1'b0;
            reference_item_h.desOv = 1'b0;
            enable_mul = 1'b0;
            enable_div = 1'b0;
            end
        //operation not
        // bit operation not
            `OC8051_ALU_NOT: begin
            reference_item_h.des_acc = ~reference_item_h.src1;
            reference_item_h.des1 = ~reference_item_h.src1;
            reference_item_h.des2 = 8'h00;
            reference_item_h.desCy = !reference_item_h.srcCy;
            reference_item_h.desAc = 1'b0;
            reference_item_h.desOv = 1'b0;
            enable_mul = 1'b0;
            enable_div = 1'b0;
            end
        //operation and
        //bit operation and
            `OC8051_ALU_AND: begin
            reference_item_h.des_acc = reference_item_h.src1 & reference_item_h.src2;
            reference_item_h.des1 = reference_item_h.src1 & reference_item_h.src2;
            reference_item_h.des2 = 8'h00;
            reference_item_h.desCy = reference_item_h.srcCy & reference_item_h.bit_in;
            reference_item_h.desAc = 1'b0;
            reference_item_h.desOv = 1'b0;
            enable_mul = 1'b0;
            enable_div = 1'b0;
            end
        //operation xor
        // bit operation xor
            `OC8051_ALU_XOR: begin
            reference_item_h.des_acc = reference_item_h.src1 ^ reference_item_h.src2;
            reference_item_h.des1 = reference_item_h.src1 ^ reference_item_h.src2;
            reference_item_h.des2 = 8'h00;
            reference_item_h.desCy = reference_item_h.srcCy ^ reference_item_h.bit_in;
            reference_item_h.desAc = 1'b0;
            reference_item_h.desOv = 1'b0;
            enable_mul = 1'b0;
            enable_div = 1'b0;
            end
        //operation or
        // bit operation or
            `OC8051_ALU_OR: begin
            reference_item_h.des_acc = reference_item_h.src1 | reference_item_h.src2;
            reference_item_h.des1 = reference_item_h.src1 | reference_item_h.src2;
            reference_item_h.des2 = 8'h00;
            reference_item_h.desCy = reference_item_h.srcCy | reference_item_h.bit_in;
            reference_item_h.desAc = 1'b0;
            reference_item_h.desOv = 1'b0;
            enable_mul = 1'b0;
            enable_div = 1'b0;
            end
        //operation rotate left
        // bit operation cy= cy or (not ram)
            `OC8051_ALU_RL: begin
            reference_item_h.des_acc = {reference_item_h.src1[6:0], reference_item_h.src1[7]};
            reference_item_h.des1 = reference_item_h.src1 ;
            reference_item_h.des2 = 8'h00;
            reference_item_h.desCy = reference_item_h.srcCy | !reference_item_h.bit_in;
            reference_item_h.desAc = 1'b0;
            reference_item_h.desOv = 1'b0;
            enable_mul = 1'b0;
            enable_div = 1'b0;
            end
        //operation rotate left with carry and swap nibbles
            `OC8051_ALU_RLC: begin
            reference_item_h.des_acc = {reference_item_h.src1[6:0], reference_item_h.srcCy};
            reference_item_h.des1 = reference_item_h.src1 ;
            reference_item_h.des2 = {reference_item_h.src1[3:0], reference_item_h.src1[7:4]};
            reference_item_h.desCy = reference_item_h.src1[7];
            reference_item_h.desAc = 1'b0;
            reference_item_h.desOv = 1'b0;
            enable_mul = 1'b0;
            enable_div = 1'b0;
            end
        //operation rotate right
            `OC8051_ALU_RR: begin
            reference_item_h.des_acc = {reference_item_h.src1[0], reference_item_h.src1[7:1]};
            reference_item_h.des1 = reference_item_h.src1 ;
            reference_item_h.des2 = 8'h00;
            reference_item_h.desCy = reference_item_h.srcCy & !reference_item_h.bit_in;
            reference_item_h.desAc = 1'b0;
            reference_item_h.desOv = 1'b0;
            enable_mul = 1'b0;
            enable_div = 1'b0;
            end
        //operation rotate right with carry
            `OC8051_ALU_RRC: begin
            reference_item_h.des_acc = {reference_item_h.srcCy, reference_item_h.src1[7:1]};
            reference_item_h.des1 = reference_item_h.src1 ;
            reference_item_h.des2 = 8'h00;
            reference_item_h.desCy = reference_item_h.src1[0];
            reference_item_h.desAc = 1'b0;
            reference_item_h.desOv = 1'b0;
            enable_mul = 1'b0;
            enable_div = 1'b0;
            end
        //operation pcs Add
            `OC8051_ALU_INC: begin
            if (reference_item_h.srcCy) begin
                reference_item_h.des_acc = dec[7:0];
            reference_item_h.des1 = dec[7:0];
                reference_item_h.des2 = dec[15:8];
            end else begin
                reference_item_h.des_acc = inc[7:0];
            reference_item_h.des1 = inc[7:0];
                reference_item_h.des2 = inc[15:8];
            end
            reference_item_h.desCy = 1'b0;
            reference_item_h.desAc = 1'b0;
            reference_item_h.desOv = 1'b0;
            enable_mul = 1'b0;
            enable_div = 1'b0;
            end
        //operation exchange
        //if carry = 0 exchange low order digit
            `OC8051_ALU_XCH: begin
            if (reference_item_h.srcCy)
            begin
                reference_item_h.des_acc = reference_item_h.src2;
                reference_item_h.des1 = reference_item_h.src2;
                reference_item_h.des2 = reference_item_h.src1;
            end else begin
                reference_item_h.des_acc = {reference_item_h.src1[7:4],reference_item_h.src2[3:0]};
                reference_item_h.des1 = {reference_item_h.src1[7:4],reference_item_h.src2[3:0]};
                reference_item_h.des2 = {reference_item_h.src2[7:4],reference_item_h.src1[3:0]};
            end
            reference_item_h.desCy = 1'b0;
            reference_item_h.desAc = 1'b0;
            reference_item_h.desOv = 1'b0;
            enable_mul = 1'b0;
            enable_div = 1'b0;
            end
            `OC8051_ALU_NOP: begin
            reference_item_h.des_acc = reference_item_h.src1;
            reference_item_h.des1 = reference_item_h.src1;
            reference_item_h.des2 = reference_item_h.src2;
            reference_item_h.desCy = reference_item_h.srcCy;
            reference_item_h.desAc = reference_item_h.srcAc;
            reference_item_h.desOv = 1'b0;
            enable_mul = 1'b0;
            enable_div = 1'b0;
            end
        endcase




        ///////////////////multiplier              

                        
                        mul_result1 = reference_item_h.src1 * (cycle == 2'h0 ? reference_item_h.src2[7:6] 
                                                : cycle == 2'h1 ? reference_item_h.src2[5:4]
                                                : cycle == 2'h2 ? reference_item_h.src2[3:2]
                                                : reference_item_h.src2[1:0]);
                        
                        shifted = (cycle == 2'h0 ? 16'h0 : {tmp_mul[13:0], 2'b00});
                        mul_result = mul_result1 + shifted;
                        mulsrc1 = mul_result[15:8];
                        mulsrc2 = mul_result[7:0];
                        mulOv = | mulsrc1;
                        
                        if (reference_item_h.rst) begin
                            cycle =  2'b0;
                            tmp_mul =  16'b0;
                        end else begin
                            if (enable_mul) cycle =  cycle + 2'b1;
                            tmp_mul =  mul_result;
                        end



        ///////////////////divider      


                        // The main logic
                        cmp1 = reference_item_h.src2 << ({2'h3 - cycle_div, 1'b0} + 3'h1);
                        cmp0 = reference_item_h.src2 << ({2'h3 - cycle_div, 1'b0} + 3'h0);
                        
                        rem2 = cycle_div != 0 ? tmp_rem : reference_item_h.src1;
                        
                        sub1_div = {1'b0, rem2} - {1'b0, cmp1[7:0]};
                        div1 = |cmp1[15:8] ? 1'b0 : !sub1_div[8];
                        rem1 = div1 ? sub1_div[7:0] : rem2[7:0];
                        
                        sub0 = {1'b0, rem1} - {1'b0, cmp0[7:0]};
                        div0 = |cmp0[15:8] ? 1'b0 : !sub0[8];
                        rem0 = div0 ? sub0[7:0] : rem1[7:0];
                        
                        //
                        // in clock cycle_div 0 we first calculate two MSB bits, ...
                        // till finally in clock cycle_div 3 we calculate two LSB bits
                        div_out = {tmp_div, div1, div0};
                        rem_out = rem0;
                        divOv = reference_item_h.src2 == 8'h0;
                        
                        //
                        // divider works in four clock cycles -- 0, 1, 2 and 3
                        if (reference_item_h.rst) begin
                            cycle_div = 2'b0;
                            tmp_div =  6'h0;
                            tmp_rem = 8'h0;
                        end else begin
                            if (enable_div) cycle_div =  cycle_div + 2'b1;
                            tmp_div = div_out[5:0];
                            tmp_rem = rem_out;
                        end
                        
                        //
                        // assign outputs
                        divsrc1 = rem_out;
                        divsrc2 = div_out;



        case (reference_item_h.op_code) /* synopsys full_case parallel_case */
                //operation multiply
            `OC8051_ALU_MUL: begin
            reference_item_h.des_acc = mulsrc1;
            reference_item_h.des1 = reference_item_h.src1;
            reference_item_h.des2 = mulsrc2;
            reference_item_h.desOv = mulOv;
            reference_item_h.desCy = 1'b0;
            reference_item_h.desAc = 1'b0;
            enable_mul = 1'b1;
            enable_div = 1'b0;
            end
        //operation divide
            `OC8051_ALU_DIV: begin
            reference_item_h.des_acc = divsrc1;
            reference_item_h.des1 = reference_item_h.src1;
            reference_item_h.des2 = divsrc2;
            reference_item_h.desOv = divOv;
            reference_item_h.desAc = 1'b0;
            reference_item_h.desCy = 1'b0;
            enable_mul = 1'b0;
            enable_div = 1'b1;
            end
        endcase





        endfunction





endclass


