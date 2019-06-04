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
        input reset,
        output displayTemperature,
        output [6:0] settedTemperature,
        output reg heatMaintain = 0,
        output start
    );
    reg enableTimer = 0;

    wire timerDone;
    wire changeButtonSetting;
    wire heatMaintainDone;
    wire resetMaintainTimer = reset | heatMaintainDone;
    wire enableHeatMaintainTimer;
    and(enableHeatMaintainTimer, timerDone, heatMaintain);
    
    buf(start, changeButtonSetting,timerDone);
    and(displayTemperature, enableTimer, ~timerDone);
    
    always @(posedge heatMaintainButton) heatMaintain <= ~heatMaintain;
    
    always @(posedge resetMaintainTimer) heatMaintain <= 0;
    
    always @(posedge increaseHeatButton) begin
        if(!changeButtonSetting)
            enableTimer <= 1;
        else
            enableTimer <= 0;
    end
    
    always @(posedge reset or negedge start)
        if(reset | !start) begin
            enableTimer <= 0;
        end
     
    ButtonHandler buttonHandler(increaseHeatButton, heatMaintainButton, changeButtonSetting, settedTemperature);//, heatMaintain);
   /*
        input increaseHeatButton,
        input heatMaintainButton,
        input changeButtonSetting,
        input reset,
        output reg[6:0] settedTemperature = 0,
        output heatMaintain 
    */
   
   
    Timer #(2) timer_2s(clk_1Hz, enableTimer, increaseHeatButton, timerDone);
    /*
       input clk_1Hz,
        input enable,
        input reset,
        output reg done = 0
    */
    Timer #(5) timer_1h(clk_1Hz, , resetMaintainTimer, heatMaintainDone);
endmodule
