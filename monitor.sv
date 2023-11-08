//Samples the interface signals, captures into transaction packet and send the packet to scoreboard.
//`include "transaction2.sv"
import P::transaction;
class monitor;
    //total tests count, to specify number of tests to the monitor
    int  totalTests;
    //creating virtual interface handle
    virtual intf vif;
    //creating mailbox handle
    mailbox mon2scb;
    //constructor
    function new(virtual intf vif,mailbox mon2scb);
        //getting the interface
        this.vif = vif;
        //getting the mailbox handles from  environment 
        this.mon2scb = mon2scb;
    endfunction
    //Samples the interface signal and send the sample packet to scoreboard
    task main;
        repeat(totalTests) begin
            transaction trans;
            trans = new();
            @(posedge vif.clk);
                wait(vif.valid);
                trans.sel = vif.sel;
                trans.a   = vif.a;
                trans.b   = vif.b;
            @(posedge vif.clk);
                trans.c   = vif.c;
            @(posedge vif.clk);
                mon2scb.put(trans);
                trans.display("[ Monitor ]");
        end
    endtask
endclass
