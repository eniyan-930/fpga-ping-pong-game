module score_counter(
input clk,
input rst,
 input hit,
 input miss,
 input hit1,
 input hit2,
 output  [3:0]score,
 output  [3:0]score_1,
 output  [3:0]score_2,
 output  [1:0]heart
    );
    
    reg [3:0] score_d,score_1_d,score_2_d;
    reg[1:0] heart_d;
    
    
    always @( posedge clk , posedge rst)
    begin
     if(rst)
     begin
     score_d<=0;
     score_1_d<=0;
     score_2_d<=0;
     heart_d<=3;
     end
     else  if(hit) score_d<=score_d+1;
      else if(hit1) score_1_d<=score_1_d+1;
     else  if(hit2) score_2_d<=score_2_d+1;
    else if(miss) heart_d<=heart_d-1;
    else  begin
          score_d<=score_d;
          score_1_d<=score_1_d;
          score_2_d<=score_2_d;
          heart_d<=heart_d;
          end
    end
     assign score=score_d;
  assign score_1=score_1_d; 
   assign score_2=score_2_d;
    assign heart=heart_d;

endmodule
