
`timescale 1ns/1ps



`include "CYCLE.sv"

module ALU_tb;

    import uvm_pkg::*;
    import ALU_pkg::*;

    ALU_if_a intf_a();


    initial begin
        uvm_config_db # (virtual ALU_if_a) :: set(null, "uvm_test_top", "vif_a", intf_a);
        
        $timeformat(-9,3,"ns");
        run_test();
    end

    initial begin
                intf_a.clk <= 0;
    end

    // clock generation
    always #(`CYCLE/2) intf_a.clk <= ~intf_a.clk;

    // DUT instantiation

 oc8051_alu ALU_DUT (intf_a.clk, intf_a.rst, intf_a.op_code, intf_a.src1, intf_a.src2, intf_a.src3, intf_a.srcCy, intf_a.srcAc, intf_a.bit_in, 
                  intf_a.des1, intf_a.des2, intf_a.des_acc, intf_a.desCy, intf_a.desAc, intf_a.desOv, intf_a.sub_result);




endmodule