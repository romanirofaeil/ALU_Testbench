`include "environment.sv"
program test(intf i_intf);
    //total tests, to specify number of test cases to be generated
    int  totalTests = 8*1024;
    //declaring environment instance
    environment env;
    initial begin
        //creating environment
        env = new(i_intf);
        //setting the total tests count
        env.gen.totalTests  = totalTests;
        env.driv.totalTests = totalTests;
        env.mon.totalTests  = totalTests;
        env.scb.totalTests  = totalTests;
        env.cov.totalTests  = totalTests;
        //calling run of env, it interns calls generator and driver main tasks.
        env.run();
    end
endprogram
