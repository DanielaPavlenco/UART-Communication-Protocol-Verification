`timescale 1ns/1ps

module tb_UART;
  // Testbench signals and configurations
  reg clk, rst_n;
  reg tx_start, rx_start;
  reg [7:0] tx_data, rx_input;
  wire tx_busy, tx_done, rx_error;
  wire [7:0] rx_data;

  // Instantiate the UART_Testbench with a specific baud rate
  UART_Testbench #(9600) tb (
    .clk(clk),
    .rst_n(rst_n),
    .tx_start(tx_start),
    .tx_data(tx_data),
    .tx_busy(tx_busy),
    .tx_done(tx_done),
    .rx_start(rx_start),
    .rx_input(rx_input),
    .rx_data(rx_data),
    .rx_error(rx_error)
  );

  // Clock generation logic (replace with your actual clock generation)
  always begin
    #5 clk = ~clk;
  end

  // Initializations and configurations
  initial begin
    // Your test scenarios here
    run_test();
  end

  // Your test procedure
  task run_test();
    // Reset
    rst_n = 0;
    #10 rst_n = 1;

    // Example: Transmit data
    #10 tx_start = 1;
    #10 tx_data = 8'h42;
    #10 tx_start = 0;

    // Example: Receive data
    #10 rx_start = 1;

    // Example: Varying Baud Rate
    #10 tb.test.env.agent.driver.baud_rate = 4800;  // Change baud rate to 4800
    #10 tb.test.env.agent.driver.baud_rate = 19200; // Change baud rate to 19200

    // Example: Hardware Flow Control (RTS/CTS)
    // Add your scenarios for hardware flow control here

    // Run simulation for 100 clock cycles
    #100 $stop;
  endtask

endmodule : tb_UART
