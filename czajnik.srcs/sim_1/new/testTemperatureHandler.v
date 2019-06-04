`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2019 11:35:16
// Design Name: 
// Module Name: testTemperatureHandler
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


module testTemperatureHandler;

localparam tempDelta = 7'b0000001;

reg clk = 0;
reg enable = 0;
reg heatingMaintain = 1;
reg[6:0] settedTemperature = 0;
reg[6:0] tempratureSensorData = 0;
wire buzzerEnable;
wire heaterEnable;
wire finishedHeating;

TemperatureHandler tempHandler(clk, enable, heatingMaintain, settedTemperature, tempratureSensorData, finishedHeating, buzzerEnable, heaterEnable);
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
initial begin
    settedTemperature = 7'b1001011;
    #40 enable = 1;
end

always @(posedge clk) begin
    if(heaterEnable)
        tempratureSensorData <= tempratureSensorData + tempDelta;
    else if ( tempratureSensorData > 0)
       tempratureSensorData <= tempratureSensorData - tempDelta;     
 
end

always 
    #10 clk <= ~clk;
    
    
       
endmodule

