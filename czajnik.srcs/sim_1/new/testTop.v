`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2019 22:21:49
// Design Name: 
// Module Name: testTop
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


module testTop;

localparam tempDelta = 7'b0000001;

reg clk_100Mhz = 0;
reg increaseHeatButton = 0;
reg heatMaintainButton = 0;
reg [6:0] temperatureSensorData = 0;
wire enableHeater;
wire enableBuzzer;
wire [2:0] displayNumber;
wire [6:0] ledsOutput;

initial begin
    #100000000 increaseHeatButton = 0;
    #1 increaseHeatButton = 1;
    #1 heatMaintainButton = 1;
    #100000000 heatMaintainButton = 0;
    #1 increaseHeatButton = 0;
    //#1000000000increaseHeatButton = 0;
    //#1000000000 increaseHeatButton = 0;
    //#1 increaseHeatButton = 1;
    #100000000 increaseHeatButton = 0;
    #100000000 increaseHeatButton = 0;
    /*
    //#100000000 increaseHeatButton = 0;
    #100000000 increaseHeatButton = 0;
    #1 increaseHeatButton = 1;
    #100000000 increaseHeatButton = 0;
    #100000000 increaseHeatButton = 0;
    //#100000000 increaseHeatButton = 0;
    #100000000 increaseHeatButton = 0;
    #1 increaseHeatButton = 1;
    #1000000000increaseHeatButton = 0;
    */
end

always
    #5 clk_100Mhz = ~clk_100Mhz;

always @(posedge clk_100Mhz) begin
    if(enableHeater)
       #50000000 temperatureSensorData = temperatureSensorData + tempDelta;
    else if ( temperatureSensorData > 0)
       #50000000 temperatureSensorData = temperatureSensorData - tempDelta;     
 end
 
top top1(clk_100Mhz, increaseHeatButton, heatMaintainButton, temperatureSensorData, enableHeater, enableBuzzer,displayNumber, ledsOutput);
/*
    input clk_100Mhz,
      input increaseHeatButton,
      input heatMaintainButton,
      input [6:0] temperatureSensorData,
      output enableHeater,
      output enableBuzzer,
      output [2:0] displayNumber,
      output [6:0] ledsOutput
*/
endmodule
