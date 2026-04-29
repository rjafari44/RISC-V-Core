`timescale 1ns / 1ps

module reg_file_tb;

reg clk_tb;
reg reset_tb;
reg rg_wrt_en_tb;
reg [4:0] rg_wrt_addr_tb;
reg [4:0] rg_rd_addr1_tb;
reg [4:0] rg_rd_addr2_tb;
reg [31:0] rg_wrt_data_tb;

wire [31:0] rg_rd_data1_tb;
wire [31:0] rg_rd_data2_tb;

RegFile uut (
    .clk(clk_tb),
    .reset(reset_tb),
    .rg_wrt_en(rg_wrt_en_tb),
    .rg_wrt_addr(rg_wrt_addr_tb),
    .rg_rd_addr1(rg_rd_addr1_tb),
    .rg_rd_addr2(rg_rd_addr2_tb),
    .rg_wrt_data(rg_wrt_data_tb),
    .rg_rd_data1(rg_rd_data1_tb),
    .rg_rd_data2(rg_rd_data2_tb)
);

always #10 clk_tb = ~clk_tb;

initial begin
    clk_tb = 0;

    $display("Time   reset wr wr_addr wr_data        rd1         rd2");

    // RESET
    reset_tb = 1;
    rg_wrt_en_tb = 0;
    rg_rd_addr1_tb = 18;
    rg_rd_addr2_tb = 5;

    #20;
    $display("%0t    %b    %b     -       -        %h   %h (expected 0)", 
              $time, reset_tb, rg_wrt_en_tb, rg_rd_data1_tb, rg_rd_data2_tb);

    reset_tb = 0;

    // WRITE x18
    rg_wrt_en_tb = 1;
    rg_wrt_addr_tb = 5'd18;
    rg_wrt_data_tb = 32'h12345678;

    #20;
    $display("%0t    %b    %b     18    %h   %h   -", 
              $time, reset_tb, rg_wrt_en_tb, rg_wrt_data_tb, rg_rd_data1_tb);

    // WRITE x5
    rg_wrt_addr_tb = 5'd5;
    rg_wrt_data_tb = 32'hABCDEF01;

    rg_rd_addr1_tb = 18;
    rg_rd_addr2_tb = 5;

    #20;
    $display("%0t    %b    %b     5     %h   %h   %h", 
              $time, reset_tb, rg_wrt_en_tb, rg_wrt_data_tb, rg_rd_data1_tb, rg_rd_data2_tb);

    // RESET AGAIN
    reset_tb = 1;
    #20;

    $display("%0t    RESET -> rd1=%h rd2=%h (expected 0)", 
              $time, rg_rd_data1_tb, rg_rd_data2_tb);

    $finish;
end

endmodule