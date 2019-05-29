`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2019 21:46:53
// Design Name: 
// Module Name: testBuzzerHandler
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


module testBuzzerHandler;

reg clk = 0;
reg start = 0;
wire enableBuzzer;

initial begin
    #100 start = 1;
    #100 start = 0;
    
    #700 start = 1;
    #100 start = 0;
end

always
    #100 clk = ~clk;

BuzzerHandler buzzer(clk,start,enableBuzzer);

endmodule
