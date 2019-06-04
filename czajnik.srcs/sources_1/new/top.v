`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2019 13:10:34
// Design Name: 
// Module Name: top
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


module top(
      input clk_100Mhz,
      input increaseHeatButton,
      input heatMaintainButton,
      input [6:0] temperatureSensorData,
      output enableHeater,
      output enableBuzzer,
      output [2:0] displayNumber,
      output [6:0] ledsOutput
    );
    
    wire clk_1Hz;
    wire clk_1Hz_Controls;
    wire clk_1Hz_Buzzer;
    wire [6:0] settedTemperature;
    wire heatMaintain;
    wire startHeating; 
    wire resetControls;
    wire controlsDisplayTemp;
    wire enableBuzzerHandlerWire;
    wire [6:0] displayTemp = controlsDisplayTemp ? settedTemperature : temperatureSensorData;
    
    buf b1(clk_1Hz_Controls, clk_1Hz_Buzzer, clk_1Hz);
    
    ClockDivider #(1) clockDivider_1Hz (clk_100Mhz, clk_1Hz);
    
    
    Display display(clk_100Mhz,displayTemp, displayNumber,ledsOutput);
    
    Controls controls(clk_1Hz_Controls, increaseHeatButton, heatMaintainButton, resetControls, controlsDisplayTemp, settedTemperature, heatMaintain, startHeating);
    /*
         input clk_1Hz,
        input increaseHeatButton,
        input heatMaintainButton,
        input reset,
        output displayTemperature,
        output [6:0] settedTemperature,
        output heatMaintain,
        output start
    */
    
    TemperatureHandler temperatureHandler(clk_100Mhz, startHeating, heatMaintain, settedTemperature, temperatureSensorData, resetControls ,enableBuzzerHandlerWire ,enableHeater);
    /*
        input clk,
        input enable,
        input heatingMaintain,
        input[6:0] settedTemperature,
        input[6:0] tempratureSensorData,
        output reg finishedHeating,
        output reg buzzerEnable = 0,
        output reg heaterEnable = 0
    */
    
    BuzzerHandler buzzer(clk_1Hz_Buzzer, enableBuzzerHandlerWire, enableBuzzer);
    /*
      input clk,
        input start,
        output reg enableBuzzer = 0
    */
endmodule
