module numberpad(a1, a2, d1, d2, num1, num2, num3); 
    output [3:0] num1, num2, num3;
    input a1, a2, d1, d2; // a1为加1端口，a2为加2端口，d1为减1端口，d2为减2端口 
    wire co1, co2, co3, ci1, ci2, ci3;
    pad pad1(a1, a2, d1, d2, num1, co1, ci1); // 将三个pad级联 
    pad pad2(co1, 0, ci1, 0, num2, co2, ci2); 
    pad pad3(co2, 0, ci2, 0, num3, co3, ci3); 
endmodule

// pad模块，输出为4位8421BCD码，由a1, a2, d1, d2来实现加减操作。有进位和借位端口 
module pad(a1, a2, d1, d2, num, co, ci);
    output reg [3:0] num; // 输出4位8421BCD码 
    output reg co, ci; // co 进位信号, ci是借位信号
    input a1, a2, d1, d2; // a1为加1端口，a2为加2端口，d1为减1端口，d2为减2端口 
    wire rem;
    
    initial num <= 4'b0000;
    assign rem = a1 | a2 | d1 | d2;
    
    always @(posedge rem) begin
        if (a1 && !a2 && !d1 && !d2) begin // 仅a1输入脉冲时加1，必要时进位 
            if (num == 4'b1001) begin
                num <= 4'b0000;
                co <= 1'b1;
            end else begin
                num <= num + 4'b0001;
                co <= 1'b0;
            end
        end else if (a2 && !a1 && !d1 && !d2) begin // 仅a2输入脉冲时加2，必要时进位 
            if (num == 4'b1000) begin
                num <= 4'b0000;
                co <= 1'b1;
            end else if (num == 4'b1001) begin
                num <= 4'b0001;
                co <= 1'b1;
            end else begin
                num <= num + 4'b0010;
                co <= 1'b0;
            end
        end else if (d1 && !a1 && !a2 && !d2) begin // 仅d1输入脉冲时减1，必要时借位 
            if (num == 4'b0000) begin
                num <= 4'b1001;
                ci <= 1'b1;
            end else begin
                num <= num - 4'b0001;
                ci <= 1'b0;
            end
        end else if (d2 && !a1 && !a2 && !d1) begin // 仅d2输入脉冲时减2，必要时借位	
            if (num == 4'b0001) begin
                num <= 4'b1001;
                ci <= 1'b1;
            end else if (num == 4'b0000) begin
                num <= 4'b1000;
                ci <= 1'b1;
            end else begin
                num <= num - 4'b0010;
                ci <= 1'b0;
            end
        end else begin // 多个端口同时输入，输出保持原来的值
            num <= num;
            co <= 1'b0;
            ci <= 1'b0;
        end
    end
endmodule