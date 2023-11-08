package P;
    `include "transaction.sv" 
endpackage 
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "coverage.sv"
class environment;
    //generator and driver instance
    generator gen;
    driver driv;
    monitor mon;
    scoreboard scb;
    //coverage instance
    coverage cov;
    //mailbox handle's
    mailbox gen2driv;
    mailbox mon2scb;
    //virtual interface
    virtual intf vif;
    //constructor
    function new(virtual intf vif);
        //get the interface from main
        this.vif = vif;
        //creating the mailbox (Same handle will be shared across generator and driver)
        gen2driv = new();
        mon2scb  = new();
        //creating generator and driver
        gen  = new(gen2driv);
        driv = new(vif, gen2driv);
        mon  = new(vif, mon2scb);
        scb  = new(mon2scb);
        //creating coverage
        cov = new(vif);
    endfunction
    //reset
    task reset();
        driv.reset();
    endtask
    //runs all the environment classes
    task main();
        cov.updateCoverage = scb.updateCoverage;
        fork
            gen.main();
            driv.main();
            mon.main();
            scb.main();
            cov.main();
        join
    endtask
    //run task
    task run();
        reset();
        main();
        $finish;
    endtask
endclass
