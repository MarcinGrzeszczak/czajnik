`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.06.2019 16:04:37
// Design Name: 
// Module Name: testDS18B20
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

module testDS18B20;

reg CLK;
reg CLK_1MHZ;
reg RST;
reg ACK;
wire BUS_IN;
wire BUS_OUT;


wire OW_RST_STAT;
wire RDY;
wire[7:0] BYTE0;
wire[7:0] BYTE1;

initial begin
   
    CLK = 0;
    CLK_1MHZ = 0;
    RST = 0;
    ACK = 0;
    
    #510 RST = 1;
end


always
    #5 CLK = ~CLK;

always
    #500 CLK_1MHZ = ~CLK_1MHZ;

/*
integer counter = 0;

always @(negedge CLK_1MHZ) begin
    if(~BUS_OUT) counter <= counter + 1;
    else begin
        
        if(counter >= 480) begin
            #15000 BUS_IN = 1;
            #15000 BUS_IN = 0;
            #100000 BUS_IN = 1;
        end
        counter <= 0;
    end
    
         
end
  */

VirtualDS18B20Sensor sensor(CLK_1MHZ, RST,BUS_OUT, BUS_IN);
/*
 input CLK_1MHZ,
        input BUS_IN,
        output BUS_OUT
*/    

DS18B20 ds(CLK,CLK_1MHZ,RST,BUS_IN,ACK,BUS_OUT, OW_RST_STAT,RDY,BYTE0,BYTE1);
/*
  input CLK,
        input CLK_1MHZ,
        input RST,
        inout BUS,
        input ACK,
        output OW_RST_STAT,
        output RDY,
        output [7:0] BYTE0,
        output [7:0] BYTE1
*/

endmodule
