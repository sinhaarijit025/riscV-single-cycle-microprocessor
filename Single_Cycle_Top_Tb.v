
module Single_Cycle_Top_Tb ();
    
    reg clk =1'b1, rst;

    Single_Cycle_Top Single_Cycle_Top(
                                .clk(clk),
                                .rst(rst)
    );

    initial begin
        $dumpfile("wave_finals.vcd");
        $dumpvars(0);
    end

    always 
    begin
        clk = ~ clk;
        #1;  
        
    end
    
    initial
    begin
        rst = 1'b1;
        #2;

        rst =1'b0;
        #500;
        $finish;
    end
endmodule
