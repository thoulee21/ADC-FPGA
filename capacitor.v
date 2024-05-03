`include "disciplines.h"

module cap(n1, n2);
    inout n1, n2;
    electrical n1, n2;
    parameter real c = 1p;
    
    analog begin
        I(n1, n2) <+ c * ddt(V(n1, n2));
    end
endmodule
