`include "config.svh"

module tb;

    localparam clk_mhz = 1,
               w_key   = 4,
               w_sw    = 8,
               w_led   = 8,
               w_digit = 8,
               w_gpio  = 100;

    //------------------------------------------------------------------------

    logic       clk;
    logic       rst;
    logic [3:0] key;
    logic [7:0] sw;

    //------------------------------------------------------------------------

    lab_top
    # (
        .clk_mhz ( clk_mhz ),
        .w_key   ( w_key   ),
        .w_sw    ( w_sw    ),
        .w_led   ( w_led   ),
        .w_digit ( w_digit ),
        .w_gpio  ( w_gpio  )
    )
    i_lab_top
    (
        .clk      ( clk ),
        .slow_clk ( clk ),
        .rst      ( rst ),
        .key      ( key ),
        .sw       ( sw  )
    );

    //------------------------------------------------------------------------

    initial
    begin
        clk = 1'b0;

        forever
            # 5 clk = ~ clk;
    end

    //------------------------------------------------------------------------

    initial
    begin
        rst <= 1'bx;
        repeat (2) @ (posedge clk);
        rst <= 1'b1;
        repeat (2) @ (posedge clk);
        rst <= 1'b0;
    end

    initial
    begin
        `ifdef __ICARUS__
            $dumpvars;
        `endif
        key[3:1] = '0;

        repeat (32)
        begin
             # 10
             sw  <= $urandom ();
             key[0] <= $urandom ();
        end

        $finish;
    end

endmodule
