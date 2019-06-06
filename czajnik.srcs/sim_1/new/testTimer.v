`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2019 21:15:44
// Design Name: 
// Module Name: testTimer
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


module testTimer;
    
    reg clk_1Hz = 0;
    reg reset = 0;
    reg enable = 0;
    wire done;
    
    initial begin
        #1000000000 reset = 0;
        #1000000000 reset = 0;
        #1 enable = 1;
        #1000000000 reset = 0;
        #1000000000 reset = 0;
        //#1 reset = 1;
        #1000000000 reset = 0;
        #1000000000 reset = 0;
        #1000000000 reset = 0;
        #1 enable = 0;
        #1000000000 reset = 0;
        #1000000000 reset = 0;
        #1000000000 reset = 0;
        //#1 reset = 1; 
        #1000000000 reset = 0;
        
    end
    
    always
        #500000000 clk_1Hz = ~clk_1Hz;
        
    SecondsTimer #(2) timer(clk_1Hz,enable,reset,done);
    /*
      input clk_1Hz,
        input enable,
        input reset,
        output reg done = 0
    */
    
endmodule
