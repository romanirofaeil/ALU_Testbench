class transaction;
    //declaring the transaction items
    randc bit[1:0] sel;
    randc bit[3:0] a;
    randc bit[3:0] b;
    bit[6:0] c;
    function void display(string name);
        $display("---------------%s---------------", name);
        $display("- sel = %0d, a = %0d, b = %0d", sel, a, b);
        $display("- c = %0d", c);
        $display("---------------%s---------------", name);
    endfunction
endclass
