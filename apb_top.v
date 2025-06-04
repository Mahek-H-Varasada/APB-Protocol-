module apb_top (
    input          PCLK,
    input          PRESETn,
    input          start_write,
    input          start_read,
    output  [7:0]  rdata,
    output         done,
    input         addr,
    input         wdata
);
   
   // reg [7:0]  addr= 8'h10 ; 
   // reg  [7:0]  wdata = 8'hAB ;

    wire        PSELx, PENABLE, PWRITE, PREADY;
    wire [7:0]  PADDR, PWDATA, PRDATA;

    apb_master master (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PSELx(PSELx),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PADDR(PADDR),
        .PWDATA(PWDATA),
        .PRDATA(PRDATA),
        .PREADY(PREADY),
        .start_write(start_write),
        .start_read(start_read),
        .addr(addr),
        .wdata(wdata),
        .rdata(rdata),
        .done(done)
    );

    apb_slave slave (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PSELx(PSELx),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PADDR(PADDR),
        .PWDATA(PWDATA),
        .PRDATA(PRDATA),
        .PREADY(PREADY)
    );

endmodule