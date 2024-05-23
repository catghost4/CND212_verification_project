
class ALU_agent_a extends uvm_agent;
    `uvm_component_utils(ALU_agent_a)


    ALU_cfg_obj cfg_obj_h;

    ALU_driver_a driver_h_a;
    ALU_monitor_a monitor_h_a;
    ALU_sequencer_a sequencer_h_a;

    uvm_analysis_port # (ALU_sequence_item) ALU_analysis_port;

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "ALU_agent_a", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("ALU_agent_a", "constructor", UVM_HIGH)
    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Build Phase =========================================
    // ----------------------------------------------------------------------------------------------- */

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("ALU_agent_a", "build phase", UVM_HIGH)

        
        cfg_obj_h = ALU_cfg_obj::type_id::create("cfg_obj_h");

        if(!uvm_config_db # (ALU_cfg_obj) :: get(this, "", "cfg_obj_h", cfg_obj_h)) begin
            `uvm_error("NO_cfg_obj", {"Configuration Object must be set for: ", get_full_name(), ".cfg_obj_h"});
        end

        driver_h_a = ALU_driver_a::type_id::create("driver_h_a", this);
        sequencer_h_a = ALU_sequencer_a::type_id::create("sequencer_h_a", this);
         
        uvm_config_db # (virtual ALU_if_a) :: set(this, "driver_h_a", "vif_a", cfg_obj_h.vif_a);
        
        monitor_h_a = ALU_monitor_a::type_id::create("monitor_h_a", this);

        uvm_config_db # (virtual ALU_if_a) :: set(this, "monitor_h_a", "vif_a", cfg_obj_h.vif_a);
        ALU_analysis_port = new("ALU_analysis_port", this);

    endfunction: build_phase

    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Connect Phase ========================================
    // ----------------------------------------------------------------------------------------------- */

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("ALU_agent_a", "connect phase", UVM_HIGH)
       
        driver_h_a.seq_item_port.connect(sequencer_h_a.seq_item_export);

        monitor_h_a.ALU_analysis_port.connect(ALU_analysis_port);
    endfunction: connect_phase

endclass: ALU_agent_a



