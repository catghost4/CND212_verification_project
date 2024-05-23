
class ALU_sequence_item extends uvm_sequence_item;

    `uvm_object_utils(ALU_sequence_item)

    logic rst;
    rand logic        srcCy, srcAc, bit_in;
    rand logic  [3:0] op_code;
    rand logic  [7:0] src1, src2, src3;
        
        
        logic       desCy, desAc, desOv;
        logic [7:0] des1, des2, des_acc, sub_result;

    

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "ALU_sequence_item");
        super.new(name);
        `uvm_info(name, "constructor", UVM_HIGH)
    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Other Methods ========================================
    // ----------------------------------------------------------------------------------------------- */

    function void display_in(input string name = "");
        $display("------------------------------------------------------------------------------------------------------------------------------------");
        `uvm_info(name,
                  $sformatf("\n Transaction Data:\n rst = %h, srcCy = %h, srcAc = %h, bit_in = %h, op_code = %h,src1 = %h, src2 = %h,src3 = %h \n",
                  rst, srcCy, srcAc, bit_in, op_code,src1,src2,src3),
                  UVM_MEDIUM);
    endfunction: display_in

    function void display_out(input string name = "");
        $display("------------------------------------------------------------------------------------------------------------------------------------");
        `uvm_info(name,
                  $sformatf("\n Transaction Data:\n rst = %h, srcCy = %h, srcAc = %h, bit_in = %h, op_code = %h,src1 = %h,src2 = %h,src3 = %h,\n  desCy = %h,desAc = %h,desOv = %h,des1 = %h,des2 = %h,des_acc = %h,sub_result = %h \n",
                  rst, srcCy, srcAc, bit_in, op_code,src1,src2,src3,desCy,desAc,desOv,des1,des2,des_acc,sub_result),
                  UVM_MEDIUM);
    endfunction: display_out


       function void reset();

            rst = 1;

            srcCy = 0;
            srcAc = 0;
            bit_in = 0;
            op_code = 0;
            src1 = 0;
            src2 = 0;
            src3 = 0;
            
            desCy = 0;
            desAc = 0;
            desOv = 0;
            des1 = 0;
            des2 = 0; 
            des_acc = 0;
            sub_result = 0;
    endfunction




endclass: ALU_sequence_item
