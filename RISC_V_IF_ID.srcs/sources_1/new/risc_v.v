//////////////////////////////////////////////RISC-V_MODULE///////////////////////////////////////////////////
module RISC_V(input clk,
              input reset,
              
              output [31:0] PC_EX,
              output [31:0] ALU_OUT_EX,
              output [31:0] PC_MEM,
              output PCSrc,
              output [31:0] DATA_MEMORY_MEM,
              output [31:0] ALU_DATA_WB,
              output [1:0] forwardA, forwardB,
              output pipeline_stall);
  
    // IF_ID_reg signal
    // input
    wire IF_ID_WRITE;
    wire [31:0] INSTRCUTION_IF, PC_IF;
    // output 
    wire [31:0] INSTRUCTION_ID, PC_ID;
    
    IF_ID_reg IF_ID_REGISTER(clk, reset, IF_ID_WRITE,
                             PC_IF, INSTRCUTION_IF,
                             
                             PC_ID, INSTRUCTION_ID);
    // ID_EX_reg signal 
    // input 
    wire [31:0] IMM_ID;
    wire [4:0] RD_ID, RS1_ID, RS2_ID;
    wire [31:0] REG_DATA1_ID, REG_DATA2_ID;
    wire [2:0] func3_ID;
    wire [6:0] func7_ID;
    wire RegWrite_ID;
    wire MemtoReg_ID;
    wire MemRead_ID;
    wire MemWrite_ID;
    wire [1:0] ALUop_ID;
    wire ALUSrc_ID;
    wire Branch_ID;
    // output 
    wire [31:0] IMM_EX;
    wire [4:0] RD_EX, RS1_EX, RS2_EX;
    wire [31:0] REG_DATA1_EX, REG_DATA2_EX;
    wire [2:0] func3_EX;
    wire [6:0] func7_EX;
    wire RegWrite_EX;
    wire MemtoReg_EX;
    wire MemRead_EX;
    wire MemWrite_EX;
    wire [1:0] ALUop_EX;
    wire ALUSrc;
    wire Branch_EX;
    
    ID_EX_reg ID_EX_REGISTER(clk, reset, 1'b1,
                             IMM_ID,
                             RD_ID, RS1_ID, RS2_ID,
                             REG_DATA1_ID, REG_DATA2_ID,
                             func3_ID, func7_ID,
                             PC_ID,
                             RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID, ALUop_ID, ALUSrc_ID, Branch_ID,
                             
                             IMM_EX,
                             RD_EX, RS1_EX, RS2_EX,
                             REG_DATA1_EX, REG_DATA2_EX,
                             func3_EX, func7_EX,
                             PC_EX,
                             RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, ALUop_EX, ALUSrc, Branch_EX);
                             
    // EX_MEM signal 
    // input
    wire [31:0] MUX_B_temp_EX;
    wire ZERO_EX;
    wire [31:0] PC_BRANCH_EX;
    // output 
    wire [4:0] RD_MEM;
    wire [31:0] REG_DATA2_MEM;
    wire [31:0] ALU_OUT_MEM;
    wire ZERO_MEM;
    wire [2:0] func3_MEM;
    wire RegWrite_MEM;
    wire MemtoReg_MEM;
    wire MemRead_MEM;
    wire MemWrite_MEM;
    wire Branch_MEM;
    
    EX_MEM_reg EX_MEM_REGISTER(clk, reset, 1'b1,
                               RD_EX,
                               MUX_B_temp_EX,
                               ALU_OUT_EX,
                               ZERO_EX,
                               func3_EX,
                               PC_BRANCH_EX,
                               RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, Branch_EX,
                               
                               RD_MEM,
                               REG_DATA2_MEM,
                               ALU_OUT_MEM,
                               ZERO_MEM,
                               func3_MEM,
                               PC_MEM,
                               RegWrite_MEM, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM);
                               
    // MEM_WB signal
    // output 
    wire [4:0] RD_WB;
    wire [31:0] ALU_OUT_WB;
    wire [31:0] DATA_MEMORY_WB;
    wire MemtoReg_WB;
    wire RegWrite_WB;
    
    MEM_WB_reg MEM_WB_REGISTER(clk, reset, 1'b1,
                               RD_MEM,
                               ALU_OUT_MEM,
                               DATA_MEMORY_MEM,
                               RegWrite_MEM, MemtoReg_MEM,
                               
                               RD_WB,
                               ALU_OUT_WB,
                               DATA_MEMORY_WB,
                               RegWrite_WB, MemtoReg_WB);
                               
    // IF stage 
    wire PC_write;
    IF instruction_fetch(clk, reset,
                         PCSrc, PC_write, PC_MEM,
                         
                         PC_IF, INSTRCUTION_IF);
                         
    // ID stage
    wire [6:0] opcode;
    hazard_detection HAZARD_DETECTION_UNIT(RD_EX, RS1_ID, RS2_ID, MemRead_EX,
            
                                            PC_write, IF_ID_WRITE, pipeline_stall);
                                            
   ID instruction_decode(clk,
                         PC_ID, INSTRUCTION_ID,
                         RegWrite_WB,
                         ALU_DATA_WB,
                         RD_WB,
                         pipeline_stall,
                         
                         IMM_ID,
                         REG_DATA1_ID, REG_DATA2_ID,
                         func3_ID, func7_ID,
                         opcode,
                         RD_ID, RS1_ID, RS2_ID,
                         RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID,
                         ALUop_ID,
                         ALUSrc_ID,
                         Branch_ID);
                         
    // EX stage 
    forwarding FORWARDING_UNIT(RS1_EX, RS2_EX,
                               RD_MEM, RD_WB,
                               RegWrite_MEM, RegWrite_WB,
                               
                               forwardA, forwardB);
                               
    EX execute(IMM_EX,
               REG_DATA1_EX, REG_DATA2_EX,
               PC_EX,
               func3_EX, func7_EX,
               RD_EX, RS1_EX, RS2_EX,
               RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX,
               ALUop_EX, ALUSrc, Branch_EX,
               forwardA, forwardB,
               ALU_DATA_WB, ALU_OUT_MEM,
                                  
               ZERO_EX, ALU_OUT_EX, PC_BRANCH_EX, MUX_B_temp_EX);
               
    // MEM stage 
    MEM memory(clk,
               ZERO_MEM, ALU_OUT_MEM, PC_MEM, REG_DATA2_MEM,
               RD_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM,
               func3_MEM,
               
               DATA_MEMORY_MEM, PCSrc);
               
    // WB stage 
    WB writeback(ALU_OUT_WB, DATA_MEMORY_WB, MemtoReg_WB,
                
                ALU_DATA_WB);
                                                          
endmodule
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
