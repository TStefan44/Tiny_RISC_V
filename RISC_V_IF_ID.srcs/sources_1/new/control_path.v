////////////////////////////////////////CONTROL_PATH_MODULE///////////////////////////////////////////////////      
module control_path(input [6:0] opcode,
                    input control_sel,
                    output reg RegWrite,
                    output reg MemtoReg,
                    output reg MemRead,
                    output reg MemWrite,
                    output reg Branch,
                    output reg ALUSrc,
                    output reg [1:0] ALUop);
  
  always@(control_sel,opcode) begin
    casex({control_sel,opcode})
      8'b1_xxxxxxx: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b00000000;
      8'b0_0000000: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b00000000; //nop from ISA
      8'b0_0000011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b11110000; //lw
      8'b0_0100011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b10001000; //sw
      8'b0_0110011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b00100010; //R32-format
      8'b0_0010011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b10100011; //Register32-Immediate Arithmetic Instructions
      8'b0_1100011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b00000101; //branch instructions
      default: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b00000000;
    endcase
  end

endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
