`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2019 19:42:45
// Design Name: 
// Module Name: testButtonHandler
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


module testButtonHandler;

 reg increaseHeatButton = 0;
 reg heatMaintainButton = 0;
 reg changeButtonSetting = 0;
 wire [6:0] settedTemperature;
 wire heatMaintain;
 wire stop;
 
 initial begin
 
  #5 increaseHeatButton = 1;
  #1  increaseHeatButton = 0;
 
  #5 increaseHeatButton = 1;
  #1  increaseHeatButton = 0;

  #5 increaseHeatButton = 1;
  #1  increaseHeatButton = 0;
 
  #5 increaseHeatButton = 1;
  #1  increaseHeatButton = 0;
 
  #5 increaseHeatButton = 1;
  #1  increaseHeatButton = 0;
 
  #5 increaseHeatButton = 1;
  #1  increaseHeatButton = 0;
  
  #5 changeButtonSetting = 1;
  
  #5 increaseHeatButton = 1;
  #1  increaseHeatButton = 0;
  
  #5 heatMaintainButton = 1;
  #1 heatMaintainButton = 0;
  
  #10 heatMaintainButton = 1;
  #1  heatMaintainButton = 0;
 end
 
 ButtonHandler buttonHandler(increaseHeatButton, heatMaintainButton, changeButtonSetting, settedTemperature, heatMaintain, stop);
 /*
  input increaseHeatButton,
        input heatMaintainButton,
        input changeButtonSetting,
        output reg[6:0] settedTemperature = 0,
        output reg heatMaintain = 0,
        output reg stop = 0
 */
endmodule
