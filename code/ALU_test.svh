
/* ----------------------------------------------------------------------------------------------- //
Project Title: UVM-Based Functional Verification of PCIe PHY Layer
Institution: University of Science and Technology, Zewail City
Project Team: Marwan Eid - Alaa Taha - Pater Gad - Almomenbelah Allam - Mahmoud Marzouk
File Description: Tx ALU Test Component Class
Version: 1.0
// ----------------------------------------------------------------------------------------------- */

class ALU_test extends test_base;

    `uvm_component_utils(ALU_test)


    // define another class named cfg_obj that extends uvm_object and contains
    // the virtual interface
    // ---------------------------------------------------------------------------------------------
    ALU_cfg_obj cfg_obj_h;


    virtual ALU_if_a vif_a;

    ALU_random_sequence write_sequence;

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "ALU_test", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("ALU_test", "constructor", UVM_HIGH)
    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Build Phase =========================================
    // ----------------------------------------------------------------------------------------------- */

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("ALU_test", "build phase", UVM_HIGH)


         // construct config_object class
        // ---------------------------------------------------------------------------------------------
        cfg_obj_h = ALU_cfg_obj::type_id::create("cfg_obj_h");
        // ---------------------------------------------------------------------------------------------
       

        if(!uvm_config_db # (virtual ALU_if_a) :: get(this, "", "vif_a", vif_a)) begin
            `uvm_error("NOVIF_a", {"virtual interface must be set for: ", get_full_name(), ".vif_a"});
        end
       
        // insert the virtual interface into the config_object class (config_object_h.vif = vif)
        // ---------------------------------------------------------------------------------------------
        cfg_obj_h.vif_a = vif_a;        
        // ---------------------------------------------------------------------------------------------
       
        uvm_config_db # (ALU_cfg_obj) :: set(this, "env_h", "cfg_obj_h", cfg_obj_h);

    endfunction: build_phase

    /* ----------------------------------------------------------------------------------------------- //
       ========================================== Run Phase ==========================================
    // ----------------------------------------------------------------------------------------------- */

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    
    write_sequence = ALU_random_sequence::type_id::create("write_sequence");

        `uvm_info("ALU_test", "run phase", UVM_HIGH)
        
        
        phase.raise_objection(this, "Starting Sequences");
        
        write_sequence.start(env_h.agent_h_a.sequencer_h_a);

        phase.drop_objection(this, "Finished Sequences");
    endtask: run_phase

endclass: ALU_test
