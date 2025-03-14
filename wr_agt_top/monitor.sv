class monitor extends uvm_monitor;
        `uvm_component_utils(monitor)

	virtual gray_counter_if.MON_MP vif;
	agent_config c_cfg;
	uvm_analysis_port#(wr_xtn) ap;

        extern function new(string name = "monitor", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();

endclass

//Constructor new
function monitor::new(string name = "monitor", uvm_component parent);
        super.new(name, parent);
	ap = new("ap", this);
endfunction


//Build Phase
function void monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(agent_config)::get(get_parent(),"","agent_config", c_cfg))
		`uvm_fatal("MONITOR", "Couldn't get AGENT_CONFIG from uvm_config_db... DID YOU SET IT RIGHT???")
endfunction


//Connect Phase
function void monitor::connect_phase(uvm_phase phase);
	vif = c_cfg.vif;
endfunction


//Run Phase
task monitor::run_phase(uvm_phase phase);
	forever begin
		collect_data();
	end
endtask


//Collect Data
task monitor::collect_data();
	wr_xtn xtnh;

	xtnh = wr_xtn::type_id::create("xtnh");

	@(vif.mon_cb);
	xtnh.rst = vif.mon_cb.rst;
	xtnh.bin_count = vif.mon_cb.bin_count;
	xtnh.gray_count = vif.mon_cb.gray_count;

	$display("------------------------------------------------------------------------");
	$display("Data Collected from Monitor.....");
	$display("------------------------------------------------------------------------");
	xtnh.print();

	ap.write(xtnh);
endtask
