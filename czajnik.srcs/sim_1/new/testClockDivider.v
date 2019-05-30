`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2019 17:33:15
// Design Name: 
// Module Name: testClockDivider
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


module testClockDivider;

reg clk = 0;
wire clk_10kHz;

always
#5 clk = ~clk; //100Mhz

ClockDivider #(10000) divider_1Hz (clk,clk_10kHz);
endmodule
