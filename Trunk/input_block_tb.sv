//Input Block TB

module input_block_tb;

reg clk,rst;

xbar_if bus(.clk,.rst);
serdes_if [ports-1:0]
input_block    ipblk(.port(bus));

int count;


initial
begin
  clk=0;
  count='1;
  forever #5 clk=~clk;
end

always@(posedge clk)
begin
  if(rst)begin
  count++;
  bus.clk10=0;
  end

  if(count==9)
    begin
      count=0;
      bus.clk10=1;
    end
end

initial
begin
  rst=0;
  #8 rst=1;
  
  bus.mux_sel=0;
  bus.A=$urandom();
  
  #210;
  bus.mux_sel++;
  //bus.A=$urandom();
  #10;
  bus.mux_sel++;
  #10;
  bus.mux_sel++;
  #10;
  bus.mux_sel++;
  #10;
  bus.mux_sel++;
  #10;
  bus.mux_sel++;
  #10;
  bus.mux_sel++;
  
end

endmodule