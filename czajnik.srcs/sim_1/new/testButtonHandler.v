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
 reg changeButtonSetting = 0;
 reg reset = 0;
 wire [6:0] settedTemperature;
 wire enable;
 
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
  
 end
 
 ButtonHandler buttonHandler(increaseHeatButton,changeButtonSetting, reset, settedTemperature, enable);
   /*
        input increaseHeatButton,
        input changeButtonSetting,
        input reset,
        output[6:0] settedTemperature,
        output reg enable =0
   */
   
endmodule
