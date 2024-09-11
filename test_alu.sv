/**
 * @file test_alu.sv
 * @brief ALU module
 *
 * This module implements an Arithmetic Logic Unit (ALU) that performs various arithmetic and logical operations.
 *
 * @param clk Clock input
 * @param rst Reset input
 * @param A Input A
 * @param B Input B
 * @param opcode Operation code
 * @param C Output C
 *
 * @details
 * The ALU module performs the following operations based on the opcode:
 * - 2'b00: Addition of A and B
 * - 2'b01: Subtraction of B from A
 * - 2'b10: Bitwise complement of A
 * - 2'b11: Bitwise OR of A and B
 *
 * The output C is updated on the positive edge of the clock or when the reset signal is negated.
 * If the reset signal is low, the output C is set to 0.
 */
module ALU (
    input wire clk,
    input wire rst,

    input wire [3:0] A,
    input wire [3:0] B,
    input wire [1:0] opcode,

    output reg [4:0] C
);

  always @(posedge clk or negedge rst) begin
    if (!rst) begin  // 如果复位信号为低电平，输出为0
      C <= 5'b0;
    end else begin
      case (opcode)
        2'b00: C <= A + B;  //+
        2'b01: C <= A - B;  //-
        2'b10: C <= ~A;  //位反转
        2'b11: C <= A | B;  //（输入B）的或运算

        default: C <= 5'b0;
      endcase
    end
  end

endmodule
