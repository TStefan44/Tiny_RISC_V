`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2022 13:46:04
// Design Name: 
// Module Name: data_memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module data_memory(input clk,       
                   input mem_read, 
                   input mem_write,
                   input [31:0] address,
                   input [31:0] write_data,
                   output reg [31:0] read_data
                   );
    reg [31:0] memory [0:1023];    // memoria de date     
    integer i;
    
   initial begin
    for (i = 0; i < 1024; i = i + 1) begin
      memory[i] = 32'b0;
    end
  end
  
  //scriere sincrona
    always@(posedge clk)
    begin
        if (mem_write == 1)
            memory[address[11:2]] <= write_data;
    end
    
    //citire asincrona
    always@(*)
    begin
        if (mem_read == 1)
            read_data = memory[address[11:2]];
    end
    
    
endmodule