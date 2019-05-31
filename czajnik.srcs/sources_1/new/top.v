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
      output [2:0] displayNumber,
      output [6:0] ledsOutput
    );
    
    wire clk_1Hz;
    wire [6:0] settedTemperature;
    wire heatMaintain;
    wire startHeating;
    wire stop;
    
    ClockDivider #(1) clockDivider_1Hz (clk_100Mhz, clk_1Hz);
    
    
    Display display(clk_100Mhz,settedTemperature,displayNumber,ledsOutput);
    
    TemperatureHandler temperatureHandler(clk_100Mhz, ,startHeating, heatMaintain, settedTemperature, temperatureSensorData, ,enableHeater);
    /*
    input clk,
        input reset,
        input start,
        input heatingMaintain,
        input[6:0] settedTemperature,
        input[6:0] tempratureSensorData,
        output[6:0] currentTemperature,
        output reg buzzerEnable = 0,
        output reg heaterEnable = 0
    */
endmodule
