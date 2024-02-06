class UART_Agent extends uvm_agent;
  `uvm_component_utils(UART_Agent)

  UART_Driver driver;
  UART_Monitor monitor;
  UART_Sequencer sequencer;
  UART_Scoreboard scoreboard;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Instantiate and connect agent components
    driver = UART_Driver::type_id::create("driver", this);
    monitor = UART_Monitor::type_id::create("monitor", this);
    sequencer = UART_Sequencer::type_id::create("sequencer", this);
    scoreboard = UART_Scoreboard::type_id::create("scoreboard", this);

    driver.tx_put_port.connect(monitor.rx_get_port);
    monitor.rx_get_port.connect(driver.tx_put_port);
    sequencer.seq_item_port.connect(driver.seq_item_export);
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    // Start sequencer in a new phase
    phase.raise_objection(this);
    fork
      sequencer.run_phase(phase);
    join_none
    phase.drop_objection(this);
  endtask : run_phase
endclass : UART_Agent
