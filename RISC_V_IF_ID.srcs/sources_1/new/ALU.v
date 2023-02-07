`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2022 13:10:35
// Design Name: 
// Module Name: ALU
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


module ALU(input [3:0] ALUop, // selecteaza operatia
           input [31:0] ina, inb, // operanzi
           output zero, //semnal ce verifica daca rezultatul este 0
           output reg [31:0] out); // rezultat

    always@(*) begin
    case(ALUop)
      4'b0000: out = ina & inb;         //and
      4'b0001: out = ina | inb;         //or
      4'b0010: out = ina + inb;         //add
      4'b0011: out = ina ^ inb;         //xor
      4'b0100: out = ina << inb;    	//sll
      4'b0101: out = ina >> inb;   	    //srl
      4'b0110: out = ina - inb;         //sub
      4'b0111: out = (ina < inb) ? 32'b1 : 32'b0;       		        //sltu
      4'b1000: out = ($signed(ina) < $signed(inb)) ? 32'b1 : 32'b0;     //slt
      4'b1001: out = ina >>> inb[4:0];       //sra
      default: out = 0;
    endcase
  end
  
  assign zero = (out == 32'b0) ? 1'b1 : 1'b0;
           
endmodule
