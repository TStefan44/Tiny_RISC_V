`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2022 14:06:52
// Design Name: 
// Module Name: forwarding
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


module forwarding(input [4:0] rs1,          // adresa registrului sursa 1 in etapa EX
                  input [4:0] rs2,          // adresa registrului sursa 2 in etapa EX
                  input [4:0] ex_mem_rd,    // adresa registrului destinatie in etapa MEM
                  input [4:0] mem_wb_rd,    // adresa registrului destinatie in etapa WB
                  input ex_mem_regwrite,    // semnalul de control RegWrite in etapa MEM
                  input mem_wb_regwrite,    // semnalul de control RegWrite in etapa WB
                  output reg [1:0] forwardA, forwardB); // semnalele de selectie a multiplexoarelor
                                                       // ce vor alege valoarea ce trebuie bypassata
                                                       

    always@(*)
    begin
        if (ex_mem_regwrite && (ex_mem_rd != 5'b0) && (ex_mem_rd == rs1))  // hazard in stagiul EX
        begin
            forwardA = 2'b10;
        end
        
        else if (mem_wb_regwrite && (mem_wb_rd != 5'b0) &&                // hazard in stagiul MEM
           ~(ex_mem_regwrite && (ex_mem_rd != 5'b0) && (ex_mem_rd == rs1)) &&
           (mem_wb_rd == rs1))
            begin
            forwardA = 2'b01;    
            end
            
        else begin
            forwardA = 2'b00;
        end
        
        
        if (ex_mem_regwrite && (ex_mem_rd != 5'b0) && (ex_mem_rd == rs2))  // hazard in stagiul EX
        begin
            forwardB = 2'b10;
        end
        
        else if (mem_wb_regwrite && (mem_wb_rd != 5'b0) &&                 // hazard in stagiul MEM
           ~(ex_mem_regwrite && (ex_mem_rd != 5'b0) && (ex_mem_rd == rs2)) &&
           (mem_wb_rd == rs2))
        begin
            forwardB = 2'b01;    
        end
        
        else begin
            forwardB = 2'b00;
        end
    end
endmodule
