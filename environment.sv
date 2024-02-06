class UART_Environment extends uvm_env;
  `uvm_component_utils(UART_Environment)

  UART_Agent agent;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Instantiate and connect environment components
    agent = UART_Agent::type_id::create("agent", this);
  endfunction : build_phase
endclass : UART_Environment
