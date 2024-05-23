
class ALU_cfg_obj extends uvm_object;

    `uvm_object_utils(ALU_cfg_obj)

    virtual ALU_if_a vif_a;
    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "ALU_cfg_obj");
        super.new(name);
        `uvm_info("ALU_cfg_obj", "constructor", UVM_HIGH)
    endfunction: new

endclass: ALU_cfg_obj
