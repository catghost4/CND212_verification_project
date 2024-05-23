
class ALU_sequencer_a extends uvm_sequencer # (ALU_sequence_item);

    `uvm_component_utils(ALU_sequencer_a)

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "ALU_sequencer_a", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("ALU_sequencer_a", "constructor", UVM_HIGH)
    endfunction: new

endclass: ALU_sequencer_a








