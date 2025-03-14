class agent extends uvm_agent;
	`uvm_component_utils(agent) //Factory Registration

	//Declare the handles for driver, monitor and sequencer
	driver s_drvh;
	monitor s_monh;
	sequencer s_seqrh;

	//Declare the handle for source_agent_config
	agent_config c_cfg;

	//Standard Methods
	extern function new(string name = "agent", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass


//------------------------------Constructor "new"---------------------------------
function agent::new(string name = "agent", uvm_component parent);
	super.new(name,parent);
endfunction


//------------------------------Build Phase---------------------------------
function void agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	//Get the agent config from uvm_config_db
	if(!uvm_config_db #(agent_config)::get(this,"","agent_config",c_cfg))
		`uvm_fatal("SOURCE AGENT","Could not get AGENT_CONFIG.... Did u set it???")

	//Create object for monitor
	s_monh = monitor::type_id::create("s_monh",this);

	//Create objects for driver and sequencer if is_active is UVM_ACTIVE
	if(c_cfg.is_active == UVM_ACTIVE) begin
		s_drvh = driver::type_id::create("s_drvh",this);
		s_seqrh = sequencer::type_id::create("s_seqrh",this);
	end

endfunction


//------------------------------Connect Phase---------------------------------
function void agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	s_drvh.seq_item_port.connect(s_seqrh.seq_item_export);
endfunction

