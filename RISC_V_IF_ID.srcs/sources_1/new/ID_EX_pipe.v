`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2022 16:28:39
// Design Name: 
// Module Name: ID_EX_pipe
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


module ID_EX_reg(input clk,
                 input reset,
                 input write,
                 
                 input [31:0] IMM_in,
                 input [4:0] RD_in,
                 input [4:0] RS1_in,
                 input [4:0] RS2_in,
                 input [31:0] ALU_A_in,
                 input [31:0] ALU_B_in,
                 input [2:0] FUNCT3_in,
                 input [6:0] FUNCT7_in,
                 input [31:0] PC_in,
                 
                 // control
                  input RegWrite_in,
                  input MemtoReg_in,
                  input MemRead_in,
                  input MemWrite_in,
                  input [1:0] ALUop_in,
                  input ALUSrc_in,
                  input Branch_in,
                  
                  // 
                  output reg [31:0] IMM_out,
                  output reg [4:0] RD_out,
                  output reg [4:0] RS1_out,
                  output reg [4:0] RS2_out,
                  output reg [31:0] ALU_A_out,
                  output reg [31:0] ALU_B_out,
                  output reg [2:0] FUNCT3_out,
                  output reg [6:0] FUNCT7_out,
                  output reg [31:0] PC_out,
                 
                 // control
                  output reg RegWrite_out,
                  output reg MemtoReg_out,
                  output reg MemRead_out,
                  output reg MemWrite_out,
                  output reg [1:0] ALUop_out,
                  output reg ALUSrc_out,
                  output reg Branch_out);
                   
     always@(posedge clk) begin
        if (reset) begin 
             IMM_out <= 32'b0;
             RD_out <= 5'b0;
             RS1_out <= 5'b0;
             RS2_out <= 5'b0;
             ALU_A_out <= 32'b0;
             ALU_B_out <= 32'b0;
             FUNCT3_out <= 3'b0;
             FUNCT7_out <= 7'b0;
             PC_out <= 32'b0;
             
             // control
             RegWrite_out <= 0;
             MemtoReg_out <= 0;
             MemRead_out <= 0;
             MemWrite_out <= 0;
             ALUop_out <= 2'b0;
             ALUSrc_out <= 0;
             Branch_out <= 0;
        end 
        else begin 
           if (write) begin 
             IMM_out <= IMM_in;
             RD_out <= RD_in;
             RS1_out <= RS1_in;
             RS2_out <= RS2_in;
             ALU_A_out <= ALU_A_in;
             ALU_B_out <= ALU_B_in;
             FUNCT3_out <= FUNCT3_in;
             FUNCT7_out <= FUNCT7_in;
             PC_out <= PC_in;
             
             // control
             RegWrite_out <= RegWrite_in;
             MemtoReg_out <= MemtoReg_in;
             MemRead_out <= MemRead_in;
             MemWrite_out <= MemWrite_in;
             ALUop_out <= ALUop_in;
             ALUSrc_out <= ALUSrc_in;
             Branch_out <= Branch_in;
           end
        end 
     end
endmodule