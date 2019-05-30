`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2019 20:58:22
// Design Name: 
// Module Name: Timer
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


module Timer #(seconds = 2)(
        input clk_1Hz,
        input reset,
        output reg done = 0
    );
    
    integer counter = 0;
    
    always @(negedge clk_1Hz or posedge reset) begin
        if(reset) begin
            done <= 0;
            counter <= 0;
        end
        
        if(done == 0) begin
            if(counter == seconds) begin 
                done <= 1;
            end
            
            counter <= counter + 1;
        end
        
        
    end
endmodule
