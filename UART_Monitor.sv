class UART_Monitor extends uvm_monitor;
  `uvm_component_utils(UART_Monitor)

  // Add necessary ports and FIFOs here
  uvm_blocking_get_port #(UART_Transaction) rx_get_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  task run_phase(uvm_phase phase);
    UART_Transaction rx_trans;
    // Implement the monitor functionality here

    forever begin
      // Receive data from the UART interface
      rx_get_port.get(rx_trans);

      // Analyze and check for errors
      if (rx_trans.start_of_packet) begin
        if (rx_trans.data == 8'h42) begin
          `uvm_info(get_type_name(), $sformatf("Received valid start_of_packet with data: %h", rx_trans.data), UVM_MEDIUM)
        end else begin
          `uvm_error(get_type_name(), $sformatf("Received invalid data: %h", rx_trans.data))
        end
      end

      // Send data to the scoreboard
      seq_item_port.put(rx_trans, sequencer);

      // Optionally, check for sequences and notify the sequencer
      if (rx_trans.start_of_packet) begin
        sequencer.seq_done.set_sequencer(sequencer);
        sequencer.seq_done.start_item(rx_trans);
        seq_item_port.item_done();
        sequencer.seq_done.finish_item(rx_trans);
      end
    end
  endtask : run_phase
endclass : UART_Monitor
