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
      input clk_100MHz,
      input increaseHeatButton,
      input heatMaintainButton,
      inout BUS_OW,
      input RESET_OW,
      output reset_therm,
      output enableHeater,
      output enableBuzzer,
      output [2:0] displayNumber,
      output [6:0] ledsOutput
    );
    
    wire clk_1Hz;
    wire clk_1MHz;
    wire [6:0] settedTemperature;
    
    wire resetDS18B20;
    wire BUS_IN;
    wire BUS_OUT;
    wire ACK_reading;
    wire RDY_reading;
    
    wire [15:0] currentTemperature;
    wire [6:0] savedTemperature;
    wire reset;  
    wire startComparing; 
    wire resetControls;
    wire controlRequiredDisplay;
    wire enableBuzzerHandlerWire;
    wire [6:0] displayTemp = controlRequiredDisplay ? settedTemperature : savedTemperature;
   assign reset = resetDS18B20 & RESET_OW;
   bufif0(BUS_OW,1'b0,BUS_OUT);
   assign BUS_IN = BUS_OW === 1'bZ ? 1'b1 : 1'b0;
   assign reset_therm = reset; 
    ClockDivider #(1) clockDivider_1Hz (clk_100MHz, clk_1Hz);
    ClockDivider #(1000000) clockDivider_1Mhz(clk_100MHz, clk_1MHz);
    
    Display display(clk_100MHz,displayTemp, displayNumber,ledsOutput);
    
    DS18B20 t_controller(clk_100MHz, clk_1MHz, reset, BUS_IN, , BUS_OUT, , RDY_reading, currentTemperature[15:8], currentTemperature[7:0]);
    EnableThermometer enableThermometer(clk_100MHz, ACK_reading, resetDS18B20);
    /*
    input CLK,
    input CLK_1MHZ,
    input RST,
    input BUS_IN,
    input ACK,
    output BUS_OUT,
    output OW_RST_STAT,
    output reg RDY,
    output reg [7:0] BYTE0,
    output reg [7:0] BYTE1
    */
    FD tempFd (currentTemperature[11:3], RDY_reading, savedTemperature);
    Controls controls(clk_1Hz, increaseHeatButton, heatMaintainButton, resetControls, controlRequiredDisplay, settedTemperature, startComparing);
    /*
        input clk_1Hz,
        input increaseHeatButton,
        input heatMaintainButton,
        input reset,
        output displayRequired,
        output [6:0] settedTemperature,
        output start
    */
    
    TemperatureHandler temperatureHandler(clk_100MHz, startComparing, RDY_reading, settedTemperature, savedTemperature, ACK_reading, resetControls ,enableBuzzerHandlerWire ,enableHeater);
    /*
        input clk,
        input enable,
        input temperatureReady,
        input[6:0] settedTemperature,
        input[6:0] tempratureSensorData,
        output reg comparingFinished,
        output reg finished = 0,
        output reg buzzerEnable = 0,
        output reg heaterEnable = 0
    */
    
    BuzzerHandler buzzer(clk_1Hz, enableBuzzerHandlerWire, enableBuzzer);
    /*
      input clk,
        input start,
        output reg enableBuzzer = 0
    */
endmodule
