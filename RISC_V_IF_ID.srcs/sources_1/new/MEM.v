`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2022 21:24:34
// Design Name: 
// Module Name: MEM
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


module MEM( input clk,
            input ZERO_MEM,
            input [31:0] ALU_OUT_MEM,
            input [31:0] PC_MEM,
            input [31:0] REG_DATA2_MEM,
          
            input [4:0] RD_MEM,
            input MemRead_MEM, MemWrite_MEM, Branch_MEM,
            input [2:0] FUNCT3_MEM,
            
            output [31:0] DATA_MEMORY_WB,
            output Branch_OUT
    );
    
    
    data_memory DATA_MEMORY_MODULE(clk, MemRead_MEM, MemWrite_MEM, ALU_OUT_MEM, REG_DATA2_MEM, DATA_MEMORY_WB);
    branch_control BRANCH_MODULE(ZERO_MEM, ALU_OUT_MEM[0], Branch_MEM, FUNCT3_MEM, Branch_OUT);
    
endmodule
