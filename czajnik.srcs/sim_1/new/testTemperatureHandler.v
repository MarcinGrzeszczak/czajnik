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
reg reset = 0;
reg start = 0;
reg heatingMaintain = 1;
reg[6:0] settedTemperature = 0;
reg[6:0] tempratureSensorData = 0;
wire[6:0] currentTemperature = 0;
wire buzzerEnable;
wire heaterEnable;

TemperatureHandler tempHandler(clk,reset,start,heatingMaintain, settedTemperature, tempratureSensorData, currentTemperature, buzzerEnable, heaterEnable);

initial begin
    settedTemperature = 7'b1001011;
    #40 start = 1;
    #1000 reset = 1;
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

