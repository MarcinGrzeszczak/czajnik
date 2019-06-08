`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.06.2019 16:04:37
// Design Name: 
// Module Name: testDS18B20
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

module testDS18B20;

reg CLK;
reg CLK_1MHZ;
reg RST;
reg ACK;
wire BUS_IN;
wire BUS_OUT;
reg [15:0] temperature = 0;

wire OW_RST_STAT;
wire RDY;
wire[7:0] BYTE0;
wire[7:0] BYTE1;
wire checkTemperature;

initial begin
   
    CLK = 0;
    CLK_1MHZ = 0;
    RST = 0;
    ACK = 0;
    
    #510 RST = 1;
end


always
    #5 CLK = ~CLK;

always
    #500 CLK_1MHZ = ~CLK_1MHZ;

always @(posedge RDY)
    #100000 ACK <= 1;

always @(posedge checkTemperature)
    temperature <= temperature + 16'd20; 

VirtualDS18B20Sensor sensor(CLK_1MHZ, RST, temperature, BUS_OUT, BUS_IN, checkTemperature);
/*
   input CLK_1MHZ,
         input reset,
         input[15:0] temperature,
        input BUS_IN,
        output BUS_OUT,
        output reg checkTemperature
*/    

DS18B20 ds(CLK,CLK_1MHZ,RST,BUS_IN,ACK,BUS_OUT, OW_RST_STAT,RDY,BYTE0,BYTE1);
/*
  input CLK,
        input CLK_1MHZ,
        input RST,
        inout BUS,
        input ACK,
        output OW_RST_STAT,
        output RDY,
        output [7:0] BYTE0,
        output [7:0] BYTE1
*/

endmodule
