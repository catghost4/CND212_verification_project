
/* ----------------------------------------------------------------------------------------------- //
Project Title: UVM-Based Functional Verification of PCIe PHY Layer
Institution: University of Science and Technology, Zewail City
Project Team: Marwan Eid - Alaa Taha - Pater Gad - Almomenbelah Allam - Mahmoud Marzouk
File Description: Tx test base-class
Version: 1.0
// ----------------------------------------------------------------------------------------------- */
class test_base extends uvm_test; 
  `uvm_component_utils(test_base) 
 
  ALU_env env_h; 
   
  function new(string name, uvm_component parent); 
    super.new(name, parent); 
  endfunction 
 
  function void build_phase(uvm_phase phase); 
    super.build_phase(phase); 
    env_h = ALU_env::type_id::create("env_h", this); 
      
  endfunction 
 
  function void start_of_simulation_phase(uvm_phase phase); 
    super.start_of_simulation_phase(phase); 
    if (uvm_report_enabled(UVM_HIGH)) begin 
      this.print(); 
      factory.print(); 
    end 
  endfunction 
endclass