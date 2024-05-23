
class ALU_monitor_a extends uvm_monitor;
    `uvm_component_utils(ALU_monitor_a)

    virtual ALU_if_a vif_a;

    ALU_sequence_item sequence_item_h;

    uvm_analysis_port # (ALU_sequence_item) ALU_analysis_port;

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "ALU_monitor_a", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("ALU_monitor_a", "constructor", UVM_HIGH)
    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Build Phase =========================================
    // ----------------------------------------------------------------------------------------------- */

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("ALU_monitor_a", "build phase", UVM_HIGH)
        sequence_item_h = ALU_sequence_item::type_id::create("sequence_item_h");
        
        if(!uvm_config_db # (virtual ALU_if_a) :: get(this, "", "vif_a", vif_a)) begin
            `uvm_error("NOVIF_a", {"virtual interface must be set for: ", get_full_name(), ".vif_a"});
        end
        ALU_analysis_port = new("ALU_analysis_port", this);
    endfunction: build_phase

    /* ----------------------------------------------------------------------------------------------- //
       ========================================== Run Phase ==========================================
    // ----------------------------------------------------------------------------------------------- */

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("ALU_monitor_a", "run phase", UVM_HIGH)
        forever begin

            monitor();
          //sequence_item_h.display_out("ALU_monitor_a");
            ALU_analysis_port.write(sequence_item_h);
        end
    endtask: run_phase

    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Other Methods ========================================
    // ----------------------------------------------------------------------------------------------- */

    task monitor;


        @vif_a.cb_a;
        
        sequence_item_h = new;
    

             sequence_item_h.rst = vif_a.cb_a.rst;
            sequence_item_h.srcCy = vif_a.cb_a.srcCy;
            sequence_item_h.srcAc = vif_a.cb_a.srcAc;
            sequence_item_h.bit_in = vif_a.cb_a.bit_in;
            sequence_item_h.op_code = vif_a.cb_a.op_code;
            sequence_item_h.src1 =  vif_a.cb_a.src1;
            sequence_item_h.src2 = vif_a.cb_a.src2;
            sequence_item_h.src3 = vif_a.cb_a.src3;


            sequence_item_h.desCy = vif_a.cb_a.desCy;
            sequence_item_h.desAc = vif_a.cb_a.desAc;
            sequence_item_h.desOv =  vif_a.cb_a.desOv;
            sequence_item_h.des1 = vif_a.cb_a.des1;
            sequence_item_h.des2 = vif_a.cb_a.des2;
            sequence_item_h.des_acc = vif_a.cb_a.des_acc;
            sequence_item_h.sub_result = vif_a.cb_a.sub_result;



    endtask: monitor

endclass: ALU_monitor_a








