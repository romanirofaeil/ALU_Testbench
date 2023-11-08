//gets the packet from monitor, Generated the expected result and compares with the //actual result recived from Monitor
//`include "transaction3.sv"
import P::transaction;
class scoreboard;
    //total tests count, to specify number of tests to the scoreboard
    int  totalTests;
    //used to count the number of passed test cases
    int passedTests;
    //used to calculate the percentage of passed test cases
    real passedPercentage;
    //creating mailbox handle
    mailbox mon2scb;
    //event, to sample the coverage
    event updateCoverage;
    //constructor
    function new(mailbox mon2scb);
        //getting the mailbox handles from  environment 
        this.mon2scb = mon2scb;
    endfunction
    //Compares the Actual result with the expected result
    task main;
        transaction trans;
        repeat(totalTests) begin
            mon2scb.get(trans);
            trans.display("[ Scoreboard ]");
            if(trans.sel == 0)
                if((trans.a + trans.b) == trans.c) begin
                    $display("Result is as Expected");
                    passedTests++;
                end
                else
                    $error("Wrong Result.\n\tExpeced: %0d Actual: %0d", (trans.a + trans.b), trans.c);
            else if(trans.sel == 1)
                if((trans.a - trans.b) == trans.c) begin
                    $display("Result is as Expected");
                    passedTests++;
                end
                else
                    $error("Wrong Result.\n\tExpeced: %0d Actual: %0d", (trans.a - trans.b), trans.c);
            else if(trans.sel == 2)
                if((trans.a * trans.b) == trans.c) begin
                    $display("Result is as Expected");
                    passedTests++;
                end
                else
                    $error("Wrong Result.\n\tExpeced: %0d Actual: %0d", (trans.a * trans.b), trans.c);
            else
                if((trans.a / trans.b) == trans.c) begin
                    $display("Result is as Expected");
                    passedTests++;
                end
                else
                    $error("Wrong Result.\n\tExpeced: %0d Actual: %0d", (trans.a / trans.b), trans.c);
            -> updateCoverage;
        end
        passedPercentage = (passedTests * 100.00) / totalTests;
        $display("Scoreboard: %0d out of %0d tests passed with persentage %0.2f%%", passedTests, totalTests, passedPercentage);
    endtask
endclass
