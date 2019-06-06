`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.06.2019 18:36:27
// Design Name: 
// Module Name: VirtualDS18B20Sensor
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


module VirtualDS18B20Sensor(
        input CLK_1MHZ,
         input reset,
        input BUS_IN,
        output BUS_OUT
    );
    
    integer  counter = 0;
    reg [3:0]st = 0;
    
    wire timerDone;
    wire readDone;
    wire writeDone;
    
    reg enableTimer;
    reg enableRead;
    reg enableWrite;
    wire enableTimerWire;
    
    wire enableTimerRead;
    wire enableTimerWrite;
    wire[6:0] timerDataWire;
    
    reg busOut = 1'b1;
    wire busOutWrite;
    wire busOutRead;
    
    reg [7:0] writeData;
    reg [6:0] timerData;
    wire [7:0] readData;
    wire [6:0] timerDataRead;
    wire [6:0] timerDataWrite;
    
    reg resetRead = 1;
    wire resetReadWire = resetRead & reset;
    
    reg [15:0] temperature= 16'b0000011111010000;
    reg [7:0] temperatureConversionDone = 8'b00000001;
    
    reg writing2byte;
    assign enableTimerWire = enableTimer | enableTimerRead | enableTimerWrite;
    assign timerDataWire = timerData | timerDataRead | timerDataWrite;
    assign BUS_OUT = busOut & busOutWrite & busOutRead;
           
    TIMER owTimer(timerDataWire ,enableTimerWire, CLK_1MHZ, timerDone);
     /*
    input [6:0] DATA,
             input LD,
             CLK,
             output reg Z
    */
    
    OW_READ read(CLK_1MHZ, resetReadWire, enableRead,timerDone, BUS_IN, , ,readDone, enableTimerRead, busOutRead, , readData, timerDataRead);
    /*
    input CLK,RST,RX_ACT,Z,BUS_IN,CRC_RST,CRC_EN,
               output reg DONE,LD,
               output BUS_OUT,
               output reg [7:0] CRC,DATA,
               output [6:0] TIME_C);
    */

    OW_WRITE write(CLK_1MHZ, reset, enableWrite, timerDone, writeDone, enableTimerWrite, busOutWrite, writeData, timerDataWrite);
    /*
    input CLK,RST,TX_ACT,Z,
                output reg DONE,LD,
                output BUS_OUT,
                input [7:0] DATA,
                output [6:0] TIME_C
    */
    
    always @(posedge CLK_1MHZ) begin

        if(~BUS_IN & st == 0) begin
            counter <= counter + 1;
        end
        else if(counter >= 480) begin
            counter <= 0;
            st <= 4'd1;       
        end
    end
    
    always @(posedge CLK_1MHZ) begin
        
        case (st)
        4'd0: begin
         resetRead <= 1;
        
            timerData <=0;
            enableTimer <=0;
            enableWrite<=0;
            enableRead <= 0;
            writing2byte <=0;
            busOut <= 1;
        end
        
        4'd1: begin
            timerData <= 7'd6;
            enableTimer <= 1'b1;
            
            if(timerDone)
                st <=  4'd2;
        end
        
       4'd2: begin
            enableTimer <= 1'b0;
            busOut <= 1'b0;
            st <= 4'd3;
            end
        
        4'd3: begin
            timerData <= 7'd20;
            enableTimer <= 1'b1;
            
          if(timerDone)
                st <=  4'd5;
        end
        
        4'd5: begin
            enableTimer <= 1'b0;
            busOut <= 1'b1;
            st <= 4'd6; 
        end
        
        4'd6: begin
            if(~BUS_IN)
              st <= 4'd7;   
       end  
       
        4'd7: begin
            timerData<=0;
            enableRead <= 1;
            if(readDone) begin
                case(readData)
                  8'h44: begin 
                        writeData <= temperatureConversionDone;
                        enableRead <= 0;
                        resetRead <= 0;
                        st<= 4'd0;
                    end
                  8'hbe: begin
                        writeData <= temperature[15:8];
                        enableRead <= 0;
                        resetRead <= 0;
                        st<= 4'd8;
                  end
                endcase
            end 
        end
        4'd8: begin
           resetRead <= 1; 
           enableWrite <=1;
           if(writeDone && writing2byte) begin
                enableWrite<=0;
                st <= 4'd0;
           end
           else  if(writeDone) begin
                enableWrite<=0;
                st <= 4'd9;    
           end  
        
        end
        4'd9: begin
            writing2byte <= 1;
            writeData <= temperature[7:0];
            st<= 4'd8;   
        end
        endcase         
    end

endmodule
