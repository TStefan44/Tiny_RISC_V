`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2022 14:38:40
// Design Name: 
// Module Name: MEM_WB_pipe
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


module MEM_WB_reg(input clk,
              input reset,
              input write,
              
              input [4:0] RD_in,
              input [31:0] ALU_in,
              input [31:0] DATA_in,
              
              // control
              input RegWrite_in,
              input MemtoReg_in,
             
              output reg [4:0] RD_out,
              output reg [31:0] ALU_out,
              output reg [31:0] DATA_out,
              
              // control
              output reg RegWrite_out,
              output reg MemtoReg_out);
    
     always@(posedge clk) begin
        if (reset) begin 
            RD_out <= 5'b0;
            ALU_out <= 32'b0;
            DATA_out <= 32'b0;
         
            // control
            RegWrite_out <= 0;
            MemtoReg_out <= 0;
        end 
        
        else begin 
           if (write) begin 
             RD_out <= RD_in;
             ALU_out <= ALU_in;
             DATA_out <= DATA_in;
             
             // control
             RegWrite_out <= RegWrite_in;
             MemtoReg_out <= MemtoReg_in;
           end
        end 
     end         
endmodule