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
reg CLK_1MHZ = 0;
reg increaseHeatButton = 0;
reg heatMaintainButton = 0;
reg [6:0] temperatureSensorData = 0;
wire enableHeater;
wire enableBuzzer;
wire [2:0] displayNumber;
wire [6:0] ledsOutput;
wire reset_therm;
wire checkTemperature;
reg[15:0] temperature = 0;
wire rst;
wire BUS_OW;
reg RST_OW;
wire BUS_IN;
wire BUS_OUT;

assign rst = RST_OW & reset_therm; 

bufif0(BUS_OW,1'b0,BUS_OUT);
assign BUS_IN = BUS_OW === 1'bZ ? 1'b1 : 1'b0;

initial begin
    RST_OW = 1;
    #10 RST_OW = 0;
    #530 RST_OW = 1;
    
    #100000 increaseHeatButton = 0;
    #1 increaseHeatButton = 1;
    #100000 increaseHeatButton = 0;
    /*
    #1 heatMaintainButton = 1;
    #100000 heatMaintainButton = 0;
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


always
    #500 CLK_1MHZ = ~CLK_1MHZ;

always @(posedge clk_100Mhz) begin
    if(enableHeater)
       #50000000 temperatureSensorData = temperatureSensorData + tempDelta;
    else if ( temperatureSensorData > 0)
       #50000000 temperatureSensorData = temperatureSensorData - tempDelta;     
 end
 
 always @(posedge checkTemperature) begin
    temperature <= {5'b00000,temperatureSensorData,4'd0000} ;
 end
 
 DS18B20Mock sensorMock(CLK_1MHZ, rst, temperature , BUS_IN, BUS_OUT, checkTemperature);
/*
 input CLK_1MHZ,
         input reset,
         input[15:0] temperature,
        input BUS_IN,
        output BUS_OUT,
        output reg checkTemperature
*/ 
top top1(clk_100Mhz, increaseHeatButton, heatMaintainButton, BUS_OW, RST_OW, reset_therm,enableHeater, enableBuzzer,displayNumber, ledsOutput);

/*
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
*/
endmodule