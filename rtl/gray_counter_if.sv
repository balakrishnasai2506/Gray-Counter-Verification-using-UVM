interface gray_counter_if(input bit clk);
	logic [3:0] gray_count, bin_count;
	logic rst;
	
	clocking drv_cb @(posedge clk);
		default input #1 output #1;
		output rst;
	endclocking

	clocking mon_cb @(posedge clk);
		default input #1 output #1;
		input gray_count, bin_count, rst;
	endclocking

	modport DRV_MP(clocking drv_cb);
	modport MON_MP(clocking mon_cb);
endinterface
