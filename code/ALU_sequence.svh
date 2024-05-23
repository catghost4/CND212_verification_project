


class ALU_random_sequence extends uvm_sequence;

    `uvm_object_utils(ALU_random_sequence)

    ALU_sequence_item sequence_item_h;

    int Transaction_count = 480;
    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "ALU_random_sequence");
        super.new(name);
        `uvm_info("ALU_random_sequence", "constructor", UVM_HIGH)
    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Other Methods ========================================
    // ----------------------------------------------------------------------------------------------- */

    task pre_body;
        `uvm_info("ALU_random_sequence", "pre_body", UVM_HIGH)
        sequence_item_h = ALU_sequence_item::type_id::create("sequence_item_h");
    endtask: pre_body

    task body;
        `uvm_info("ALU_random_sequence", "body", UVM_HIGH)
        $display("---------------------------------------------------------------------------------------------------------------------------------------");
        $display("\n");
        $display("***************************************************************************************************************************************");
        $display("Starting Reset Transaction:");
        $display("***************************************************************************************************************************************");
        
// 5 cycles of reset
        repeat(5)begin
        start_item(sequence_item_h);
        sequence_item_h.reset();
       // sequence_item_h.display_in("buffer_sequence  ");
        finish_item(sequence_item_h);
        end

// 160 operations of random data.
        for (int i = 1; i <= Transaction_count/3; i++) begin
            $display("---------------------------------------------------------------------------------------------------------------------------------------");
            $display("\n");
            $display("***************************************************************************************************************************************");
            $display("Starting Transaction Number %0d:", i);
            $display("***************************************************************************************************************************************");
            
            start_item(sequence_item_h);
            sequence_item_h.op_code =  i/10;

            //stopping randomization if we are multiplying or dividing
            if(sequence_item_h.op_code!=4'b0011 &&sequence_item_h.op_code!=4'b0100)begin
            sequence_item_h.randomize();
            end
            
            sequence_item_h.rst =  0;

            sequence_item_h.op_code =  i/10;

            finish_item(sequence_item_h);
        end

        start_item(sequence_item_h);
        sequence_item_h.reset();
        finish_item(sequence_item_h);


// 160 operations of maximum data.
    for (int i = 1; i <= Transaction_count/3; i++) begin
    $display("---------------------------------------------------------------------------------------------------------------------------------------");
    $display("\n");
    $display("***************************************************************************************************************************************");
    $display("Starting Transaction Number %0d:", (i+160));
    $display("***************************************************************************************************************************************");
    
            start_item(sequence_item_h);
            sequence_item_h.op_code =  i/10;

            //stopping randomization if we are multiplying or dividing
            if(sequence_item_h.op_code!=4'b0011 &&sequence_item_h.op_code!=4'b0100)begin
            sequence_item_h.randomize();
            end
            
            sequence_item_h.rst =  0;

            sequence_item_h.src1 = 0;
            sequence_item_h.src2 = 0;
            sequence_item_h.src3 = 0;
            
            sequence_item_h.op_code =  i/10;

            finish_item(sequence_item_h);
        end

        
        start_item(sequence_item_h);
        sequence_item_h.reset();
        finish_item(sequence_item_h);

// 160 operations of maximum data.
    for (int i = 1; i <= Transaction_count/3; i++) begin
    $display("---------------------------------------------------------------------------------------------------------------------------------------");
    $display("\n");
    $display("***************************************************************************************************************************************");
    $display("Starting Transaction Number %0d:", (i+320));
    $display("***************************************************************************************************************************************");
    
            start_item(sequence_item_h);
            sequence_item_h.op_code =  i/10;

            //stopping randomization if we are multiplying or dividing
            if(sequence_item_h.op_code!=4'b0011 &&sequence_item_h.op_code!=4'b0100)begin
            sequence_item_h.randomize();
            end
            
            sequence_item_h.rst =  0;

            
            sequence_item_h.src1 = 255;
            sequence_item_h.src2 = 255;
            sequence_item_h.src3 = 255;
            
            sequence_item_h.op_code =  i/10;

            finish_item(sequence_item_h);
        end

    endtask: body

endclass: ALU_random_sequence


