`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2019 15:48:27
// Design Name: 
// Module Name: testBin2Bcd
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


module testBin2Bcd;

reg clk = 0;
reg [6:0] binaryNumber = 0;
wire [11:0] bcdNumber;

initial begin
    #100 binaryNumber = 7'b1111101; // 125
    #200 binaryNumber = 7'b0110100; //52
end

always
    #5 clk = ~clk;

Bin2Bcd bcdConverter(clk, binaryNumber, bcdNumber);

endmodule
