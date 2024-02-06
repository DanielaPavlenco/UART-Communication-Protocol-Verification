`include "uvm_macros.svh"

class UART_Test extends uvm_test;
  `uvm_component_utils(UART_Test)

  UART_Environment env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Instantiate and connect test components
    env = UART_Environment::type_id::create("env", this);
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask : run_phase
endclass : UART_Test
