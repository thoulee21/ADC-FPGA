`include "test_alu.sv"
/**
 * @file test_alu_tb.sv
 * @brief Testbench for ALU module
 *
 * This testbench verifies the functionality of the ALU module by applying different inputs and checking the outputs.
 */

module test_alu_tb;

  // Inputs
  reg clk;
  reg rst;
  reg [3:0] A;
  reg [3:0] B;
  reg [1:0] opcode;

  // Outputs
  wire [4:0] C;

  // Instantiate the ALU module
  ALU dut (
      .clk(clk),
      .rst(rst),
      .A(A),
      .B(B),
      .opcode(opcode),
      .C(C)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Test stimulus
  initial begin
    // Initialize inputs
    clk = 0;
    rst = 1;
    A = 4'b0000;
    B = 4'b0000;
    opcode = 2'b00;

    // Apply inputs and check outputs
    #10;
    A = 4'b0010;
    B = 4'b0001;
    opcode = 2'b00;
    #10;
    A = 4'b0100;
    B = 4'b0011;
    opcode = 2'b01;
    #10;
    A = 4'b1001;
    B = 4'b0110;
    opcode = 2'b10;
    #10;
    A = 4'b1111;
    B = 4'b1010;
    opcode = 2'b11;
    #10;

    // Randomized tests
    repeat (10) begin
      A = $random % 16;
      B = $random % 16;
      opcode = $random % 4;
      #10;
    end

    // End simulation
    $finish;
  end

  initial begin
    $dumpfile("test_alu_tb.vcd");
    $dumpvars(0, test_alu_tb);
  end

endmodule
