`include "disciplines.h" 
module diode(n1,n2); 
    inout n1,n2; 
    electrical n1,n2; 
    parameter real isat=10^-6; 
    analog begin 
        I(n1,n2)<+ isat*(exp(V(n1,n2)/$vt())-1); 
    end 
endmodule