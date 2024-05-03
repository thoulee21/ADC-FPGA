`timescale 1ns/100ps
module tb_ADC_top (); /* this is automatically generated */
parameter ADC_WIDTH = 8;     // ADC精度，单位bit
	logic                 clk_in;
	logic                 rstn;
	logic                 analog_cmp;
	logic                 analog_out;
	logic [ADC_WIDTH-1:0] digital_out;
	logic                 sample_rdy_i;
	// clock
	initial begin
		clk_in = '0;
		forever #(0.5) clk_in = ~clk_in;
	end

	initial begin
		rstn <= '0;
		analog_cmp <= '0;
		#10;
		rstn <= '1;
		#50000
		$finish;
	end
initial
   forever begin
   	#1;analog_cmp <= '1;
   	#1;analog_cmp <= '1;
   	#1;analog_cmp <= '0;
   	#1;analog_cmp <= '0;
   	#1;analog_cmp <= '1;
   	#1;analog_cmp <= '0;
   	#1;analog_cmp <= '0;
   	#1;analog_cmp <= '1;
   	#1;analog_cmp <= '0;
   	#1;analog_cmp <= '1;
   	#1;analog_cmp <= '0;
   	#1;analog_cmp <= '1;
   	#1;analog_cmp <= '0;
   	#1;analog_cmp <= '0;
   	#1;analog_cmp <= '1;
   	#1;analog_cmp <= '1;
   end

	ADC_top test (
			.clk_in       (clk_in),
			.rstn         (rstn),
			.analog_cmp   (analog_cmp),
			.analog_out   (analog_out),
			.digital_out  (digital_out),
			.sample_rdy_i (sample_rdy_i)
		);

	// dump wave
	initial begin
    $dumpfile("tb.lxt");  //生成lxt的文件名称
    $dumpvars(0, test);   //tb中实例化的仿真目标实例名称
	end

endmodule
