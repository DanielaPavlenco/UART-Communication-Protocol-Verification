class UART_Scoreboard extends uvm_scoreboard;
  `uvm_component_utils(UART_Scoreboard)

  // Add necessary fields and methods for tracking score here
  int expected_data;
  int received_data;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  task run_phase(uvm_phase phase);
    // Implement the scoreboard functionality here
    // Compare expected and received transactions
    // Track and report errors or discrepancies
    forever begin
      UART_Transaction rx_trans;
      seq_item_port.get_next_item(rx_trans);

      // Compare expected and received data
      if (rx_trans.start_of_packet) begin
        expected_data = 8'h42; // Set expected data for a start_of_packet

        // Check for errors
        if (rx_trans.data != expected_data) begin
          `uvm_error(get_type_name(), $sformatf("Mismatch: Expected data %h, Received data %h", expected_data, rx_trans.data))
        end
      end

      // Optionally, track and report other errors or discrepancies

      seq_item_port.item_done(); // Notify sequencer that the item is done
    end
  endtask : run_phase
endclass : UART_Scoreboard
