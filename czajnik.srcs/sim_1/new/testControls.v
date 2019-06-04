`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2019 19:26:34
// Design Name: 
// Module Name: testControls
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


module testControls;

reg clk_1Hz =0;
reg increaseHeatButton = 0;
reg heatMaintainButton = 0;
reg reset = 0;
wire [6:0] settedTemperature;;
wire displayRequired;
wire start;

initial begin 
    #1000000000 reset = 0;
    #1000000000 increaseHeatButton = 0;
    #1000000000 increaseHeatButton = 0;
    #1 increaseHeatButton = 1;
    #500000000 increaseHeatButton = 0;
    #1 heatMaintainButton = 1;
    #500000000 heatMaintainButton = 0;
    
    #1000000000 increaseHeatButton = 0;
    #1000000000 increaseHeatButton = 0;
    #1000000000 increaseHeatButton = 0;
    #1000000000 increaseHeatButton = 0;
    #1 reset = 1;
end

always
     #500000000 clk_1Hz = ~clk_1Hz;

Controls controls(clk_1Hz, increaseHeatButton, heatMaintainButton, reset, displayRequired, settedTemperature, start);
/*
        input clk_1Hz,
        input increaseHeatButton,
        input heatMaintainButton,
        input reset,
        output displayRequired,
        output [6:0] settedTemperature,
        output start
*/

endmodule
