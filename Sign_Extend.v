module Sign_Extend (In, Imm_Ext, ImmSrc);

    input [31:0] In;
    input [1:0] ImmSrc;
    output reg [31:0] Imm_Ext;

    always @(*) begin
        case (ImmSrc)
            2'b00: Imm_Ext = {{20{In[31]}}, In[31:20]}; // I-type
            2'b01: Imm_Ext = {{20{In[31]}}, In[31:25], In[11:7]}; // S-type
            2'b10: Imm_Ext = {{19{In[31]}}, In[31], In[7], In[30:25], In[11:8], 1'b0}; // B-type
            2'b11: Imm_Ext = {{11{In[31]}}, In[31], In[19:12], In[20], In[30:21], 1'b0}; // J-type ✅
        endcase
    end

endmodule
