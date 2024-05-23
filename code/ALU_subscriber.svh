


class ALU_subscriber extends uvm_subscriber # (ALU_sequence_item);

    `uvm_component_utils(ALU_subscriber)

    ALU_sequence_item sequence_item_h;


    covergroup cvr_grp;


        reset_cp: coverpoint sequence_item_h.rst;
        op_code_cp: coverpoint sequence_item_h.op_code;
        srcCy_cp: coverpoint sequence_item_h.srcCy;
        srcAc_cp: coverpoint sequence_item_h.srcAc;
        bit_in_cp: coverpoint sequence_item_h.bit_in;


        src1_cp: coverpoint sequence_item_h.src1 iff(!sequence_item_h.rst){
            bins zero_data= {0};
            bins FFFF_data = {8'hFF};
            bins medium_data = {[1:8'hFE]};
        }
        src2_cp: coverpoint sequence_item_h.src2 iff(!sequence_item_h.rst){
            bins zero_data= {0};
            bins FFFF_data = {8'hFF};
            bins medium_data = {[1:8'hFE]};
        }
        src3_cp: coverpoint sequence_item_h.src3 iff(!sequence_item_h.rst){
            bins zero_data= {0};
            bins FFFF_data = {8'hFF};
            bins medium_data = {[1:8'hFE]};
        }


                
        src1Xop_code: cross src1_cp,op_code_cp;
        
        src2Xop_code: cross src2_cp,op_code_cp;
        
        src3Xop_code: cross src3_cp,op_code_cp;


    endgroup


    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "ALU_subscriber", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("ALU_subscriber", "constructor", UVM_HIGH)
        cvr_grp = new();

    endfunction: new







    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Other Methods ========================================
    // ----------------------------------------------------------------------------------------------- */

    function void write(ALU_sequence_item t);
        sequence_item_h = t;
        sequence_item_h.display_out("ALU_subscriber");

    cvr_grp.sample();

    endfunction: write


endclass: ALU_subscriber
