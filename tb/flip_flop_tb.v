`timescale 1ns / 1ps

module flip_flop_tb;

reg [7:0] tb_d;
reg tb_clk;
reg tb_reset;
wire [7:0] tb_q;

FlipFlop uut (
    .clk(tb_clk),
    .reset(tb_reset),
    .d(tb_d),
    .q(tb_q)
);

// 20 ns clock period
always #10 tb_clk = ~tb_clk;

initial begin
    tb_clk = 0;
    tb_reset = 1;
    tb_d = 0;

    $display("Time    reset        d           q");

    #100; // hold reset
    tb_reset = 0;

    tb_d = 8'b00111000; #20;
    $display("%0t    %b       %b    %b", $time, tb_reset, tb_d, tb_q);

    tb_d = 8'b11110000; #20;
    $display("%0t    %b       %b    %b", $time, tb_reset, tb_d, tb_q);

    tb_d = 8'b00001111; #20;
    $display("%0t    %b       %b    %b", $time, tb_reset, tb_d, tb_q);

    tb_d = 8'b10101010; #20;
    $display("%0t    %b       %b    %b", $time, tb_reset, tb_d, tb_q);

    $finish;
end

endmodule