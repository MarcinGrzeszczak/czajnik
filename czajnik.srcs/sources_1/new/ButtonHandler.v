`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2019 18:59:37
// Design Name: 
// Module Name: ButtonHandler
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


module ButtonHandler(
        input clk_100Mhz,
        input increaseHeatButton,
        input heatMaintainButton,
        input changeButtonSetting,
        output reg[6:0] settedTemperature = 0,
        output reg heatMaintain = 0,
        output reg stop = 0
       );
    
    localparam temperatureDelta = 7'b0011001; //25
    
    reg enableTimer = 0;
    reg resetTimer = 0;
    reg isButtonChanged = 0;
    
    always @(posedge increaseHeatButton) begin
        if(!enableTimer & !isButtonChanged)
            enableTimer <= 1;
        
        if(!isButtonChanged) begin
            resetTimer <= 1;
            
        end
                   
    end
    
    
endmodule
