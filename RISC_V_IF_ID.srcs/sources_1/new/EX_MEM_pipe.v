`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2022 14:27:16
// Design Name: 
// Module Name: EX_MEM_pipe
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


module EX_MEM_reg(input clk,
                   input reset,
                   input write,
              
                   input [4:0] RD_in,
                   input [31:0] REG2_DATA_in,
                   input [31:0] ALU_in,
                   input ZERO_in,
                   input [2:0] FUNCT3_in,
                   input [31:0] PC_in,
                   
                   // control
                   input RegWrite_in,
                   input MemtoReg_in,
                   input MemRead_in,
                   input MemWrite_in,
                   input Branch_in,
                   
                   output reg [4:0] RD_out,
                   output reg [31:0] REG2_DATA_out,
                   output reg [31:0] ALU_out,
                   output reg ZERO_out,
                   output reg [2:0] FUNCT3_out,
                   output reg [31:0] PC_out,
                   
                   // control
                   output reg RegWrite_out,
                   output reg MemtoReg_out,
                   output reg MemRead_out,
                   output reg MemWrite_out,
                   output reg Branch_out);
     
     always@(posedge clk) begin
        if (reset) begin
            RD_out <= 5'b0;
            REG2_DATA_out <= 32'b0;
            ALU_out <= 32'b0;
            ZERO_out <= 0;
            FUNCT3_out <= 3'b0;
            PC_out <= 32'b0;
        
             // control
             RegWrite_out <= 0;
             MemtoReg_out <= 0;
             MemRead_out <= 0;
             MemWrite_out <= 0;
             Branch_out <= 0;
        end 
        
        else begin 
           if (write) begin
             RD_out <= RD_in;
             REG2_DATA_out <= REG2_DATA_in;
             ALU_out <= ALU_in;
             ZERO_out <= ZERO_in;
             FUNCT3_out <= FUNCT3_in;
             PC_out <= PC_in;
           
             // control
             RegWrite_out <= RegWrite_in;
             MemtoReg_out <= MemtoReg_in;
             MemRead_out <= MemRead_in;
             MemWrite_out <= MemWrite_in;
             Branch_out <= Branch_in;
           end
        end 
     end         
     
endmodule