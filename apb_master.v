
module apb_master (
    input  wire        PCLK,
    input  wire        PRESETn,
    output reg         PSELx,
    output reg         PENABLE,
    output reg         PWRITE,
    output reg  [7:0]  PADDR,
    output reg  [7:0]  PWDATA,
    input  wire [7:0]  PRDATA,
    input  wire        PREADY,
    input  wire        start_write,
    input  wire        start_read,
    input  wire [7:0]  addr,
    input  wire [7:0]  wdata,
    output reg  [7:0]  rdata,
    output reg         done
);

    typedef enum logic [1:0] {IDLE, SETUP, ACCESS} state_t;
    state_t state, next_state;

    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE:   if (start_write || start_read) next_state = SETUP;
            SETUP:  next_state = ACCESS;
            ACCESS: if (PREADY) next_state = IDLE;
        endcase
    end

    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            PSELx   <= 0;
            PENABLE <= 0;
            PWRITE  <= 0;
            PADDR   <= 8'd0;
            PWDATA  <= 8'd0;
            rdata   <= 8'd0;
            done    <= 0;
        end else begin
            case (next_state)
                IDLE: begin
                    PSELx   <= 0;
                    PENABLE <= 0;
                    done    <= 0;
                end
                SETUP: begin
                    PSELx   <= 1;
                    PENABLE <= 0;
                    PADDR   <= addr;
                    PWRITE  <= start_write;
                    PWDATA  <= wdata;
                end
                ACCESS: begin
                    PENABLE <= 1;
                    if (PREADY) begin
                        if (!PWRITE)
                            rdata <= PRDATA;
                        done <= 1;
                    end
                end
            endcase
        end
    end

endmodule
