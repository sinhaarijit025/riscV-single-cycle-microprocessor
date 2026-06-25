module Single_Cycle_Top(clk,rst);

    input clk,rst;

    wire [31:0] PC_Top,RD_Instr,RD1_Top,Imm_Ext_Top,ALUResult,ReadData,PCPlus4,RD2_Top,SrcB,Result;
    wire RegWrite,MemWrite,ALUSrc;
    wire [1:0]ImmSrc;
    wire [2:0]ALUControl_Top;
    wire Jump;
    wire [31:0] PC_Target;
    wire [31:0] PC_Next;
    wire [1:0] ResultSrc;

    assign PC_Target = PC_Top + Imm_Ext_Top;

    assign PC_Next = (Jump) ? PC_Target : PCPlus4;

    assign Result =
    (ResultSrc == 2'b00) ? ALUResult :
    (ResultSrc == 2'b01) ? ReadData  :
    (ResultSrc == 2'b10) ? PCPlus4   :
                           32'b0;
    PC_Module PC(
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_Next(PC_Next)
    );

    PC_Adder PC_Adder(
                    .a(PC_Top),
                    .b(32'd4),
                    .c(PCPlus4)
    );
    
    Instruction_Memory Instruction_Memory(
                            .rst(rst),
                            .A(PC_Top),
                            .RD(RD_Instr)
    );

    Register_File Register_File(
                            .clk(clk),
                            .rst(rst),
                            .WE3(RegWrite),
                            .WD3(Result),
                            .A1(RD_Instr[19:15]),
                            .A2(RD_Instr[24:20]),
                            .A3(RD_Instr[11:7]),
                            .RD1(RD1_Top),
                            .RD2(RD2_Top)
    );

    Mux Mux_Register_to_ALU(
                            .a(RD2_Top),
                            .b(Imm_Ext_Top),
                            .s(ALUSrc),
                            .c(SrcB)

    );

    Sign_Extend Sign_Extend(
                        .In(RD_Instr),
                        .ImmSrc(ImmSrc),
                        .Imm_Ext(Imm_Ext_Top)
    );

    ALU ALU(
            .A(RD1_Top),
            .B(SrcB),
            .Result(ALUResult),
            .ALUControl(ALUControl_Top),
            .OverFlow(),
            .Carry(),
            .Zero(),
            .Negative()
    );

    Control_Unit_Top Control_Unit_Top(
    .Op(RD_Instr[6:0]),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),          
    .Branch(),
    .funct3(RD_Instr[14:12]),
    .funct7(RD_Instr[31:25]),       
    .ALUControl(ALUControl_Top),.Jump(Jump)
);

    Data_Memory Data_Memory(
                        .clk(clk),
                        .rst(rst),
                        .WE(MemWrite),
                        .WD(RD2_Top),
                        .A(ALUResult),
                        .RD(ReadData)
    );

     Mux3to1 Mux_DataMemory_to_Register(
                           .a(ALUResult),
                           .b(ReadData),
                           .c(PCPlus4),
                           .sel(ResultSrc),
                           .out(Result)
    );

    
endmodule
