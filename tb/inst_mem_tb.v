`timescale 1ns / 1ps

module inst_mem_tb;

reg [7:0] addr_tb;
wire [31:0] instruction_tb;

InstMem uut (
    .addr(addr_tb),
    .instruction(instruction_tb)
);

initial begin
    $display("time     address   index  instruction  expected");

    addr_tb = 8'b00001100; #10;
    $display("%0t    %b   3     %h     00308193", $time, addr_tb, instruction_tb);

    addr_tb = 8'b00100000; #10;
    $display("%0t    %b   8     %h     00208433", $time, addr_tb, instruction_tb);

    addr_tb = 8'b01000000; #10;
    $display("%0t    %b   16    %h     4d26a813", $time, addr_tb, instruction_tb);

    $finish;
end

endmodule