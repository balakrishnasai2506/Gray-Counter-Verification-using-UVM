class scoreboard extends uvm_scoreboard;

	`uvm_component_utils(scoreboard)

	uvm_tlm_analysis_fifo #(wr_xtn) fifo_wrh[];
	
	wr_xtn wr_data;
	wr_xtn wr_cov_data;

	env_config e_cfg;

	int xtns_in, xtns_dropped, xtns_compared;
	
	extern function new(string name = "scoreboard", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern function void check_data(wr_xtn xtn);
	extern function void report_phase(uvm_phase phase);

	covergroup counter_fcov;
		option.per_instance = 1;

		//RESET
		RESET : coverpoint wr_cov_data.rst{
					    bins rst_assert = {1'b1};
					    bins rst_deassert = {1'b0};
						  }

		//GRAY_COUNT
		GRAY : coverpoint wr_cov_data.gray_count {
			bins valid_gray[] = (0 => 1 => 3 => 2 => 6 => 7 => 5 => 4 => 12 => 13 => 15 => 14 => 10 => 11 => 9 => 8);
  			}

		//BIN_COUNT
		BIN : coverpoint wr_cov_data.bin_count {
			bins bin_val[] = {[0:15]};
  			}
		//CROSS
		//RESET_X_GRAY_X_BIN : cross RESET,GRAY,BIN;
	endgroup

endclass


function scoreboard::new(string name = "scoreboard", uvm_component parent);
	super.new(name,parent);

	counter_fcov = new;
endfunction


function void scoreboard::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(env_config)::get(this,"","env_config",e_cfg))
		`uvm_fatal("SCOREBOARD","Couldn't get ENV_CONFIG from uvm_config_db... Did you set it right???")

	fifo_wrh = new[e_cfg.no_of_agt];
	foreach(fifo_wrh[i])
		begin
			fifo_wrh[i] = new($sformatf("fifo_wrh[%0d]",i), this);
		end
endfunction

task scoreboard::run_phase(uvm_phase phase);
	forever begin
		foreach(fifo_wrh[i]) begin
			fifo_wrh[i].get(wr_data);
			`uvm_info("Scoreboard","Received Data", UVM_LOW)
			xtns_in++;
	//		wr_data.print;
			wr_cov_data = wr_data;
			counter_fcov.sample();
			check_data(wr_data);
		end
	end
endtask

function void scoreboard::check_data(wr_xtn xtn);
	bit[3:0] expected_gray_count;

	expected_gray_count = {xtn.bin_count[3],
                         xtn.bin_count[3]^xtn.bin_count[2],
                         xtn.bin_count[2]^xtn.bin_count[1],
                         xtn.bin_count[1]^xtn.bin_count[0]};

	if(xtn.gray_count !== expected_gray_count) begin
		xtns_dropped++;
    		`uvm_error("SCOREBOARD", $sformatf("Mismatch! bin_count=%0d, Expected gray_count=%0d, Actual gray_count=%0d", xtn.bin_count, expected_gray_count, xtn.gray_count))
  	end else begin
		xtns_compared++;
   		 `uvm_info("SCOREBOARD", $sformatf("Match! bin_count=%0d, gray_count=%0d", xtn.bin_count, xtn.gray_count), UVM_MEDIUM)
  	end

endfunction


function void scoreboard::report_phase(uvm_phase phase);
	`uvm_info(get_type_name(), $sformatf("Scoreboard Report:\n Transactions Received: %0d\n Transactions Dropped: %0d\n", xtns_in, xtns_dropped), UVM_LOW)
endfunction
