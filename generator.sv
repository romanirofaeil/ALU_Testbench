//`include "transaction.sv"
import P::transaction;
class generator;
    //declaring transaction classes
    rand transaction uniqueTrans;
    transaction trans;
    //total tests count, to specify number of tests to the generator
    int  totalTests;
    //mailbox, to generate and send the packet to driver
    mailbox gen2driv;
    //constructor
    function new(mailbox gen2driv);
        //getting the mailbox handle from env, in order to share the transaction packet between the generator and driver, the same mailbox is shared between both.
        this.gen2driv = gen2driv;
    endfunction
    //main task, generates(create and randomizes) the totalTests number of transaction packets and puts into mailbox
    task main();
        uniqueTrans = new();
        repeat(totalTests) begin
            trans = new();
            if(!uniqueTrans.randomize())
                $fatal("Gen:: trans randomization failed");
            trans.sel = uniqueTrans.sel;
            trans.a = uniqueTrans.a;
            trans.b = uniqueTrans.b;
            trans.display("[ Generator ]");
            gen2driv.put(trans);
        end
    endtask
endclass
