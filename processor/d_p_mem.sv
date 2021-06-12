module d_p_mem(
clk,
reset_n,
wE_0,
wE_1,
Addr_0,
Addr_1,
WrData_0,
WrData_1,
RdData_0,
RdData_1
);

    input clk, reset_n;
    input wE_0, wE_1;
    input [3:0] Addr_0, Addr_1;
    input [3:0] WrData_0, WrData_1;
    output [3:0] RdData_0, RdData_1;

    reg wE_0_r;
    reg wE_1_r;
    reg [3:0] Addr_0_r;
    reg [3:0] Addr_1_r;
    reg [3:0] WrData_0_r;
    reg [3:0] WrData_1_r;

    always @ (posedge clk or negedge reset_n)
        if(~reset_n) begin
            wE_0_r <= 1'b0;
            wE_1_r <= 1'b0;
            Addr_0_r <= 4'b0000;
            Addr_1_r <= 4'b0000;
            WrData_0_r <= 4'b0000;
            WrData_1_r <= 4'b0000;
        end
        else begin
            wE_0_r <= wE_0;
            wE_1_r <= wE_1;
            Addr_0_r <= Addr_0;
            Addr_1_r <= Addr_1;
            WrData_0_r <= WrData_0;
            WrData_1_r <= WrData_1;
        end

    reg [3:0] mem_array [0:15];

    always @(*)
        if(wE_0_r && wE_1_r && Addr_0_r && Addr_1_r )
            mem_array[Addr_0_r] = 8'bxxxxxxxx;
        else begin
            if(wE_0_r)
                mem_array[Addr_0_r] = WrData_0_r;
            if(wE_1_r)
                mem_array[Addr_1_r] = WrData_1_r;
        end

    assign RdData_0 = mem_array[Addr_0_r];
    assign RdData_1 = mem_array[Addr_1_r];

    integer i;
    initial begin
        for(i=0;i<16;i=i+1)
            mem_array[i] = 0;
    end

endmodule
