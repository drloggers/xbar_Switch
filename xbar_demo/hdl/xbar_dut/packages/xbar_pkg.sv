// Package for data type support of header for 8x8 Crossbar Switch 

package xbar_pkg;

  localparam ports          = 8,
             slots          = 4,
             packet_width   = 8,
             payload_width  = 8,
             valid_bit      = packet_width-1,
             port_add_msb   = valid_bit-1,
             port_add_width = $clog2(ports),
             slot_id_msb    = port_add_msb-port_add_width,
             slot_id_width  = $clog2(slots);
             
              

   typedef struct packed{
    logic valid;
    logic [port_add_msb:(port_add_msb-port_add_width+1)]port_address;
    logic [slot_id_msb:(slot_id_msb-slot_id_width+1)]slot_id;
    logic payload_parity;
    logic header_parity;    
  }header_packet;
  
  typedef struct packed{
    logic [packet_width-1:(packet_width-payload_width)] data;
  }payload_packet;
  
  typedef union packed{
  
    header_packet header;
    payload_packet payload;        
 
  
  }packet;
  
endpackage
