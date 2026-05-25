module Register_File(clk,rst,WE3, WD3, A1, A2, A3, RD1, RD2);

    input clk, WE3;
    input [4:0] A1, A2, A3;
    input [31:0] WD3;
    output [31:0] RD1, RD2;
    input rst;

    reg [31:0] Register [0:31];

    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1)
            Register[i] = 0;
    end

    always @ (posedge clk) begin
        if (WE3 && A3 != 0)
            Register[A3] <= WD3;
    end

    
    assign RD1 = (A1 == 0) ? 32'd0 : Register[A1];
    assign RD2 = (A2 == 0) ? 32'd0 : Register[A2];

endmodule