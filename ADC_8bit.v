module adc(in, clk, out);
    parameter bits = 8, fullscale = 1.0, delay = 0, ttime = 0.2n, vdd = 3;
    input in, clk;
    output [0:bits-1] out;
    electrical in, clk, out;
    real sample, thresh;
    integer result[0:bits-1], i;
    
    analog begin
        @(cross(V(clk)-vdd/2, +1)) begin
            sample = V(in);
            thresh = fullscale/2.0;
            
            for (i = bits-1; i >= 0; i = i-1) begin
                if (sample > thresh) begin
                    result[i] = vdd;
                    sample = sample - thresh;
                end
                else
                    result[i] = 0;
                
                sample = 2.0 * sample;
            end
        end
        
        V(out[0]) <+ transition(result[0], delay, ttime);
        V(out[1]) <+ transition(result[1], delay, ttime);
        V(out[2]) <+ transition(result[2], delay, ttime);
        V(out[3]) <+ transition(result[3], delay, ttime);
        V(out[4]) <+ transition(result[4], delay, ttime);
        V(out[5]) <+ transition(result[5], delay, ttime);
        V(out[6]) <+ transition(result[6], delay, ttime);
        V(out[7]) <+ transition(result[7], delay, ttime);
    end
endmodule