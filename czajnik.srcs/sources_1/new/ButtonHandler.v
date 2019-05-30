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
        input increaseHeatButton,
        input heatMaintainButton,
        input changeButtonSetting,
        output reg enableTimer = 0,
        output reg resetTimer = 0,
        output reg[6:0] settedTemperature = 0,
        output reg heatMaintain = 0,
        output reg stop = 0
       );
    
    localparam temperatureDelta = 7'b0011001; //25
    reg isButtonFunctionChanged = 0;
    
    always @(posedge heatMaintainButton) heatMaintain <= ~heatMaintain;
   
    always @(changeButtonSetting) isButtonFunctionChanged <= changeButtonSetting;
    
    always @(posedge increaseHeatButton) begin
        if(isButtonFunctionChanged) begin
            stop <= 1;
        end
        else begin
            stop <= 0;
            
            if(settedTemperature[6:0] >= 7'b1100100)
                settedTemperature = 0;
            settedTemperature = settedTemperature + temperatureDelta;
       end
    end
    
endmodule
