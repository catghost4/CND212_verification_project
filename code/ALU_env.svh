
class ALU_env extends uvm_env;

    `uvm_component_utils(ALU_env)

    // ---------------------------------------------------------------------------------------------
    ALU_cfg_obj cfg_obj_h;
    // ---------------------------------------------------------------------------------------------
    


    ALU_agent_a agent_h_a;
    ALU_subscriber subscriber_h;
    ALU_scoreboard scoreboard_h;


    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "ALU_env", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("ALU_env", "constructor", UVM_HIGH)
    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Build Phase =========================================
    // ----------------------------------------------------------------------------------------------- */

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("ALU_env", "build phase", UVM_HIGH)
        agent_h_a = ALU_agent_a::type_id::create("agent_h_a", this);
        subscriber_h = ALU_subscriber::type_id::create("subscriber_h", this);
        scoreboard_h = ALU_scoreboard::type_id::create("scoreboard_h", this);
        
         // ---------------------------------------------------------------------------------------------
        cfg_obj_h = ALU_cfg_obj::type_id::create("cfg_obj_h");

        if(!uvm_config_db # (ALU_cfg_obj) :: get(this, "", "cfg_obj_h", cfg_obj_h)) begin
            `uvm_error("NO_cfg_obj", {"Configuration Object must be set for: ", get_full_name(), ".cfg_obj_h"});
        end

        uvm_config_db # (ALU_cfg_obj) :: set(this, "agent_h_a", "cfg_obj_h", cfg_obj_h);

         // ---------------------------------------------------------------------------------------------
    endfunction: build_phase

    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Connect Phase ========================================
    // ----------------------------------------------------------------------------------------------- */

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("ALU_env", "connect phase", UVM_HIGH)
        agent_h_a.ALU_analysis_port.connect(scoreboard_h.ALU_analysis_imp);
        agent_h_a.ALU_analysis_port.connect(subscriber_h.analysis_export);
    endfunction: connect_phase




endclass: ALU_env
