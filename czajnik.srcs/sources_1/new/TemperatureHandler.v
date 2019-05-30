`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2019 22:31:17
// Design Name: 
// Module Name: TemperatureHandler
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


module TemperatureHandler(
        input clk,
        input reset,
        input start,
        input heatingMaintain,
        input[6:0] settedTemperature,
        input[6:0] tempratureSensorData,
        output[6:0] currentTemperature,
        output reg buzzerEnable = 0,
        output reg heaterEnable = 0
    );
    
    assign currentTemperature = tempratureSensorData;
    reg isStarted = 0;
    
    always @(posedge start) isStarted <=1;
    
    always @(posedge clk, posedge reset) begin
    
    if(reset) begin
        buzzerEnable <= 0;
        heaterEnable <= 0;
        isStarted <= 0;
    end
    else if( (isStarted | heatingMaintain) & !reset) begin
        
        if(tempratureSensorData < settedTemperature) begin
            heaterEnable <= 1;
        end  
        
        if(tempratureSensorData >= settedTemperature) begin
            isStarted <= 0;
            heaterEnable <= 0;
            buzzerEnable <= 1;
        end
        
              
    end
    
    end
    
endmodule
