`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2019 01:39:06
// Design Name: 
// Module Name: testDisplay
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


module testDisplay;

reg clk_10kHz = 0;

reg[11:0] number = 0;

wire [2:0] displayNumber;
wire [6:0] ledsOutput;

initial
    begin
        #10 number = 12'b000010010101;
        #10000000 number = 12'b000100100110;
    end
always
    #50000 clk_10kHz = ~clk_10kHz;
    
DisplayController display(clk_10kHz,number, displayNumber, ledsOutput);

endmodule
