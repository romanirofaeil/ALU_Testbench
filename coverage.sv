class coverage;
    //total tests count, to specify number of tests to the coverage
    int  totalTests;
    //creating virtual interface handle
    virtual intf vif;
    //event, to sample the coverage
    event updateCoverage;
    //covergroup handle
    covergroup CovGrp;
        sel : coverpoint vif.sel;
        a   : coverpoint vif.a;
        b   : coverpoint vif.b;
        crossCover : cross sel, a, b;
    endgroup
    //constructor
    function new(virtual intf vif);
        //getting the interface
        this.vif = vif;
        //crating coverage group
        CovGrp = new();
    endfunction
    //Samples the coverage group after scoreboard receives the transaction
    task main;
        repeat(totalTests) begin
            @(posedge updateCoverage);
                CovGrp.sample();
        end
    endtask
endclass
