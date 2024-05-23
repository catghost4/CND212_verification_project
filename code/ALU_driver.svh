
class ALU_driver_a extends uvm_driver # (ALU_sequence_item);

    `uvm_component_utils(ALU_driver_a)

    virtual ALU_if_a vif_a;

    ALU_sequence_item sequence_item_h;

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "ALU_driver_a", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("ALU_driver_a", "constructor", UVM_HIGH)
    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Build Phase =========================================
    // ----------------------------------------------------------------------------------------------- */

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("ALU_driver_a", "build phase", UVM_HIGH)
        if(!uvm_config_db # (virtual ALU_if_a) :: get(this, "", "vif_a", vif_a)) begin
            `uvm_error("NOVIF_a", {" virtual interface must be set for: ", get_full_name(), ".vif_a"});
        end
    endfunction: build_phase

    /* ----------------------------------------------------------------------------------------------- //
       ========================================== Run Phase ==========================================
    // ----------------------------------------------------------------------------------------------- */

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("ALU_driver_a", "run phase", UVM_HIGH)

        initialize();

        forever begin
            seq_item_port.get_next_item(sequence_item_h);
            //sequence_item_h.display_in("driving interface");
            drive();
            seq_item_port.item_done();
        end
    endtask: run_phase

    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Other Methods ========================================
    // ----------------------------------------------------------------------------------------------- */



    task drive;
          @vif_a.cb_a;

            vif_a.cb_a.rst <= sequence_item_h.rst;
            vif_a.cb_a.srcCy <= sequence_item_h.srcCy;
            vif_a.cb_a.srcAc <= sequence_item_h.srcAc;
            vif_a.cb_a.bit_in <= sequence_item_h.bit_in;
            vif_a.cb_a.op_code <= sequence_item_h.op_code;
            vif_a.cb_a.src1 <= sequence_item_h.src1;
            vif_a.cb_a.src2 <= sequence_item_h.src2;
            vif_a.cb_a.src3 <= sequence_item_h.src3;
            
    endtask: drive



//function to initialize values at time 0 were some errors may occur. not necessary but maybe helpful
        task initialize(); // Does not use clocking block 

            vif_a.rst <= 1;

            vif_a.srcCy <= 0;
            vif_a.srcAc <= 0;
            vif_a.bit_in <= 0;
            vif_a.op_code <= 0;
            vif_a.src1 <= 0;
            vif_a.src2 <= 0;
            vif_a.src3 <= 0;
            
            vif_a.desCy <= 0;
            vif_a.desAc <= 0;
            vif_a.desOv <= 0;
            vif_a.des1 <= 0;
            vif_a.des2 <= 0; 
            vif_a.des_acc <= 0;
            vif_a.sub_result <= 0;
        endtask
endclass: ALU_driver_a








