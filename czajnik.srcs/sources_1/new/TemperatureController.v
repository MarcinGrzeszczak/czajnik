`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.06.2019 16:44:20
// Design Name: 
// Module Name: TemperatureController
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


module TemperatureController(
        input CLK,
        input CLK_1MHZ,
        input RST,
        inout BUS,
        input ACK,
        output OW_RST_STAT,
        output RDY,
        output [7:0] BYTE0,
        output [7:0] BYTE1   
        );
   wire BUS_IN,BUS_OUT;     
    bufif0 (BUS,1'b0, BUS_OUT);
    assign BUS_IN = BUS;
    DS18B20 tempController(CLK,CLK_1MHZ,RST,BUS_IN,ACK,BUS_OUT,OW_RST_STAT,RDY,BYTE0,BYTE1);
endmodule
