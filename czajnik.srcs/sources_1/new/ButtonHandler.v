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
        output reg[6:0] settedTemperature = 0
        //output heatMaintain 
       );
    
    localparam temperatureDelta = 7'b0011001; //25
    //wire heatMaintainNegation;
    //Fd heatMaintainFd(heatMaintainButton, ~heatMaintain, heatMaintain);

    always @(posedge increaseHeatButton) begin
         if(!changeButtonSetting) begin
            if(settedTemperature[6:0] >= 7'b1100100)
                settedTemperature = 0;
          
            settedTemperature = settedTemperature + temperatureDelta;
       end
       else
            settedTemperature = 0;
    end
    
endmodule
