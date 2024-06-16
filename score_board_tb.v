`timescale 1ns / 1ps

module score_board_tb;
    reg a1, a2, d1, d2;
    wire [3:0] num1, num2, num3;

    // 实例化numberpad模块
    numberpad U1 (.a1(a1), .a2(a2), .d1(d1), .d2(d2), .num1(num1), .num2(num2), .num3(num3));

    initial begin
    // 初始化输入
    a1 = 0; a2 = 0; d1 = 0; d2 = 0;

    // 等待一段时间
    #10;

    // 测试加1操作
    a1 = 1;
    #10;
    a1 = 0;
    #10;

    // 测试加2操作
    a2 = 1;
    #10;
    a2 = 0;
    #10;

    // 测试减1操作
    d1 = 1;
    #10;
    d1 = 0;
    #10;

    // 测试减2操作
    d2 = 1;
    #10;
    d2 = 0;
    #10;

    // 结束测试
    $finish;
    end

    initial begin
    $monitor("At time %d, a1 = %b, a2 = %b, d1 = %b, d2 = %b, num1 = %b, num2 = %b, num3 = %b",
         $time, a1, a2, d1, d2, num1, num2, num3);
    end
endmodule