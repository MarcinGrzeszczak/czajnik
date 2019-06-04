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
        input enable,
        input[6:0] settedTemperature,
        input[6:0] tempratureSensorData,
        output reg finished = 0,
        output reg buzzerEnable = 0,
        output reg heaterEnable = 0
    );
    
    always @(posedge clk) begin
        if(buzzerEnable)
            buzzerEnable <= 0;
         
        if(enable) begin
            if(tempratureSensorData < settedTemperature) begin
                heaterEnable <= 1;
             end  
    
            if(tempratureSensorData >= settedTemperature ) begin
                heaterEnable <= 0;
                
                if(!finished) begin
                    buzzerEnable <= 1;
                    finished <=1;
                end
            end   
        end
        else begin
            finished <= 0;
            buzzerEnable <=0;
            heaterEnable <= 0;
        end
    end
    
endmodule
