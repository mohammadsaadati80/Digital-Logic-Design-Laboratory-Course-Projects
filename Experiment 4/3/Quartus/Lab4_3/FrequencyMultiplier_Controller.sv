module FM_CU(input clk, input rst, input cout, input adjust, input kc, output reg counterEnable, output reg conterLoad, output reg valid);  
  typedef enum {idle, start, calK, loadCounter, count} FM_C_States;
	FM_C_States ps, ns;

  always @(kc, adjust, cout) begin
    ns = idle;
    case (ps)
      idle: begin
              ns = idle;
              if (adjust) 
                ns = start;
          end
      start: begin
              ns = calK;
              if (adjust) 
                ns = start;
          end
      calK: begin
              ns = calK;
              if (kc) 
                ns = loadCounter; 
          end
      loadCounter: ns = count;
      count: begin
              ns = count;
              if (cout) 
                ns = loadCounter; 
              else if (adjust) 
                ns = start;  
          end
      default: ns = idle;
    endcase
  end
  
  always @(ps) begin
    valid = 1'b0;
    conterLoad = 1'b0;
    counterEnable = 1'b0;
    case (ps)  
      count: begin
                valid = 1'b1;
                counterEnable = 1'b1;
            end
      loadCounter: begin
                valid = 1'b1;
                conterLoad = 1'b1;
            end
    endcase
  end

  always @(posedge clk, posedge rst)
    if (rst) ps <= idle;
    else ps <= ns;
  
endmodule