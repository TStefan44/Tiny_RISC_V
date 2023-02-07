`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2022 22:09:15
// Design Name: 
// Module Name: WB
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


module WB(input [31:0] ALU_OUT_WB, DATA_MEMORY_WB,  
          input MemtoReg_WB,
          output [31:0] ALU_DATA_WB);
    
    mux2_1 mux_wb(ALU_OUT_WB, DATA_MEMORY_WB, MemtoReg_WB, ALU_DATA_WB);
endmodule
