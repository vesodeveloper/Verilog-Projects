module processor (
    input clk, reset_n,
    input [3:0] icode
);


    reg [3:0] icode_s1, icode_s2, icode_s3, icode_s4;
    reg valid_instr_s1, valid_instr_s2, valid_instr_s3,valid_instr_s4; 
    reg mem_out_s3;
    reg [3:0] result_s4;
    wire [3:0] mem_out;
    always @ (posedge clk or negedge reset_n )
        if(~reset_n) begin
            icode_s1 <= 4'b0000;
            icode_s2 <= 4'b0000;
            icode_s3 <= 4'b0000;
            icode_s4 <= 4'b0000;
        end 
        else begin 
            icode_s1 <= icode;
            icode_s2 <= icode_s1;
            icode_s3 <= icode_s2;
            icode_s4 <= icode_s3;
        end 
always @ (posedge clk or negedge reset_n )
    if(~reset_n) begin
        mem_out_s3 <= 4'b0000;
        else
            mem_out_s3 <= mem_out;
always @ (posedge clk or negedge reset_n )
    if(~reset_n) begin 
        result_s4 <= 4'b0000;
        else
            result_s4 <= mem_out_s3 + 1;
 always @ (posedge clk or negedge reset_n )
     if(~reset_n) begin
         valid_instr_s1 <= 1'b0;
         valid_instr_s2 <= 1'b0;
         valid_instr_s3 <= 1'b0;
         valid_instr_s4 <= 1'b0;
     end 
     else begin
         valid_instr_s1 <= 1'b1;
         valid_instr_s2 <= valid_instr_s1;
         valid_instr_s3 <= valid_instr_s2;
         valid_instr_s4 <= valid_instr_s3;
     end
    d_p_mem u_d_p_mem (
        .clk (clk),
        .reset_n (reset_n),
        .wE_0 (1'b0),
        .wE_1 (),
        .Addr_0 (icode_s1),
        .Addr_1 (icode_s4),
        .WrData_0 (4'b0000),
        .WrData_1 (result_s4),
        .RdData_0 (mem_out),
        .RdData_1 ()
    );
endmodule
