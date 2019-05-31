`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2019 19:28:14
// Design Name: 
// Module Name: Controls
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


module Controls(
        input clk_1Hz,
        input increaseHeatButton,
        input heatMaintainButton,
        output [6:0] settedTemperature,
        output heatMaintain,
        output start,
        output stop
    );
    
    wire enableTimer;
    wire resetTimer;
    wire endCounting;
    buf buf1(endCounting,start);
    ButtonHandler buttonHandler(increaseHeatButton, heatMaintainButton,endCounting);
    /*
       input increaseHeatButton,
        input heatMaintainButton,
        input changeButtonSetting,
        output reg[6:0] settedTemperature = 0,
        output reg heatMaintain = 0,
        output reg stop = 0
    */
    
    Timer #(2) timer_2s(clk_1Hz, enableTimer, resetTimer, endCounting);
    /*
       input clk_1Hz,
        input enable,
        input reset,
        output reg done = 0
    */
endmodule
