class UART_Driver extends uvm_driver #(UART_Transaction);
  `uvm_component_utils(UART_Driver)

  // Add necessary ports and FIFOs here
  uvm_blocking_put_port #(UART_Transaction) tx_put_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  task run_phase(uvm_phase phase);
    UART_Transaction tx_trans;
    // Implement the driver functionality here
    forever begin
      seq_item_port.get_next_item(tx_trans);
      // Convert and send data to the UART interface
      // Wait for acknowledgment or other relevant signals
      // For simplicity, we'll just call the put task in the interface
      tx_put_port.put(tx_trans); // Send the transaction to the interface
      seq_item_port.item_done(); // Notify the sequencer that the item is done
    end
  endtask : run_phase
endclass : UART_Driver
