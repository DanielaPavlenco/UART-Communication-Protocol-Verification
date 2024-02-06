class UART_Sequencer extends uvm_sequencer #(UART_Transaction);
  `uvm_component_utils(UART_Sequencer)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  task run_phase(uvm_phase phase);
    // Implement the sequencer functionality here
    forever begin
      UART_Sequence seq = UART_Sequence::type_id::create("seq");
      // Optionally, randomize or create sequences based on your test cases

      // Set the data for the sequence
      seq.data = 8'h42; // Set the data for the sequence

      // Send sequence to the driver using seq_item_port
      seq_item_port.put(seq);

      // Optionally, add delays or other sequence items

      seq_item_port.item_done(); // Notify the sequencer that the item is done
    end
  endtask : run_phase
endclass : UART_Sequencer
