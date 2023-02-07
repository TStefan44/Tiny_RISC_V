`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2022 13:25:00
// Design Name: 
// Module Name: EX
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


module EX(input [31:0] IMM_EX,          // valoarea immediate in EX
          input [31:0] REG_DATA1_EX,    // valoarea registrului sursa 1
          input [31:0] REG_DATA2_EX,    // valoarea registrului sursa 2
          input [31:0] PC_EX,           // adresa instructiunii curente in EX
          input [2:0] FUNCT3_EX,        // funct3 pt instructiunea din EX
          input [6:0] FUNCT7_EX,        // funct7 pentru instructiunea din EX
          input [4:0] RD_EX,            // adresa registrului destinatie
          input [4:0] RS1_EX,           // adresa registrului sursa 1
          input [4:0] RS2_EX,           // adresa registrului sursa 2
          input RegWrite_EX,            // semnal de scriere in bancul de registrii
          input MemtoReg_EX,            // ...
          input MemRead_EX,             // semnal pentru activarea citirii din memorie
          input MemWrite_EX,            // semnal pentru activarea scrierii in memorie
          input [1:0] ALUop_EX,         // semnalul de control ALUop
          input ALUSrc_EX,              // semnal de selectie intre RS2 si valoarea imediata
          input Branch_EX,              // semnal de indentificare a instructiunii de tip branch
          input [1:0] forwardA, forwardB,// semnalele de selectie pentru multiplexoarele de forwarding
          
          input [31:0] ALU_DATA_WB,     // valoarea calculata de ALU, prezenta in WB  
          input [31:0] ALU_OUT_MEM,     // valoarea calculatata ALU in MEM
            
          output ZERO_EX,               // flag-ul ZERO calculat de ALU
          output [31:0] ALU_OUT_EX,     // rezultatul calculat de ALU in EX
          output [31:0] PC_Branch_EX,   // adresa de salt calculata in EX
          output [31:0] REG_DATA2_EX_FINAL  // valoarea registrului susrsa 2 selectata dintre
                                            // valorile prezente in etapele EX, MEM si WB
          );
          
    wire[3:0] ALUinput;
    wire[31:0] ALU_Source1;
    wire[31:0] ALU_Source2;
    
    mux3_1 mux1(REG_DATA1_EX, ALU_DATA_WB, ALU_OUT_MEM, forwardA, ALU_Source1);
 
    mux3_1 mux2(REG_DATA2_EX, ALU_DATA_WB, ALU_OUT_MEM, forwardB, REG_DATA2_EX_FINAL);   
    
    mux2_1 mux3_EX( REG_DATA2_EX_FINAL, IMM_EX, ALUSrc_EX, ALU_Source2);
    
    ALUcontrol alu_control(ALUop_EX, FUNCT7_EX, FUNCT3_EX, ALUinput);
    
    ALU alu(ALUinput, ALU_Source1, ALU_Source2, ZERO_EX, ALU_OUT_EX);
   
    adder AddSum(IMM_EX, PC_EX, PC_Branch_EX); 
endmodule