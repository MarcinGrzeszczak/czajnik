`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2019 21:15:04
// Design Name: 
// Module Name: EnableThermometer
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


module EnableThermometer(
        input clk,
        input trigger,
        output reg start
    );
    
    always @(posedge clk or posedge trigger)
        if(trigger)
            start <= 0;
        else
            start <= 1;
            
endmodule
