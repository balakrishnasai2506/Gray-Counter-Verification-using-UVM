class driver extends uvm_driver#(wr_xtn);
	`uvm_component_utils(driver)

	virtual gray_counter_if.DRV_MP vif;
	agent_config c_cfg;

	//Methods
	extern function new(string name = "driver", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(wr_xtn xtn);
endclass

//Constructor new
function driver::new(string name = "driver", uvm_component parent);
	super.new(name, parent);
endfunction


//Build_phase
function void driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(agent_config)::get(get_parent(),"","agent_config",c_cfg))
		`uvm_fatal("DRIVER","Couldn't get AGENT_CONFIG from uvm_config_db.... Did you set it right???")
endfunction


//Connect Phase
function void driver::connect_phase(uvm_phase phase);
	vif = c_cfg.vif;
endfunction


//Run Phase
task driver::run_phase(uvm_phase phase);
	forever begin
		seq_item_port.get_next_item(req);
		send_to_dut(req);
		seq_item_port.item_done();

		$display("------------------------------------------------------------------------");
		$display("Data Driven from Driver...");
		$display("------------------------------------------------------------------------");
		req.print();
	end
endtask


//Send To DUT
task driver::send_to_dut(wr_xtn xtn);
	@(vif.drv_cb);
	vif.drv_cb.rst <= xtn.rst;
	@(vif.drv_cb);
endtask

