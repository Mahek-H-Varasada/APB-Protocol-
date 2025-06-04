module apb_slave (
    input  wire        PCLK,
    input  wire        PRESETn,
    input  wire        PSELx,
    input  wire        PENABLE,
    input  wire        PWRITE,
    input  wire [7:0]  PADDR,
    input  wire [7:0]  PWDATA,
    output reg  [7:0]  PRDATA,
    output reg         PREADY
);

    reg [7:0] regfile [0:255]; // 256 8-bit registers

    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            PREADY <= 0;
            PRDATA <= 8'd0;
        end else begin
            if (PSELx && PENABLE) begin
                PREADY <= 1;  // Data is ready
                if (PWRITE)
                    regfile[PADDR] <= PWDATA;
                else
                    PRDATA <= regfile[PADDR];
            end else begin
                PREADY <= 0;
            end
        end
    end

endmodule
