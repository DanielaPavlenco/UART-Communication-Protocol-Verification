class UART_Sequence extends uvm_sequence #(UART_Transaction);
  `uvm_object_utils(UART_Sequence)

  // Add necessary fields for your sequence here
  rand bit start_of_packet;

  function new(string name = "UART_Sequence");
    super.new(name);
  endfunction : new

  task body();
    // Implement the sequence body here
    // Optionally, create and randomize transactions

    // Create a new transaction
    UART_Transaction tx_trans = UART_Transaction::type_id::create("tx_trans", ,get_full_name());

    // Randomize transaction fields
    start_of_packet = $urandom_range(0, 1);
    tx_trans.data = $urandom_range(0, 255);

    // Set start_of_packet field in the transaction
    tx_trans.start_of_packet = start_of_packet;

    // Send the transaction to the sequencer using seq_item_port
    seq_item_port.put(tx_trans, sequencer);

    // Optionally, wait for acknowledgment or other relevant signals
    // ...

    // Optionally, create and randomize receive transaction
    UART_Transaction rx_trans = UART_Transaction::type_id::create("rx_trans", get_full_name());

    // Randomize receive transaction fields
    // ...

    // Send the receive transaction to the scoreboard
    seq_item_port.put(rx_trans, sequencer);

    // Optionally, check for sequences and notify the sequencer
    if (start_of_packet) begin
      sequencer.seq_done.set_sequencer(sequencer);
      sequencer.seq_done.start_item(tx_trans);
      seq_item_port.item_done();
      sequencer.seq_done.finish_item(tx_trans);
    end
  endtask : body
endclass : UART_Sequence
