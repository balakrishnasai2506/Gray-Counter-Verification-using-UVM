class counter_tb extends uvm_env;
	`uvm_component_utils(counter_tb)

	wr_agent_top wagt_top;

	env_config e_cfg;
	scoreboard sb;

	extern function new(string name = "counter_tb", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass


//-----------------------------Constructor "new"--------------------------------
function counter_tb::new(string name = "counter_tb", uvm_component parent);
	super.new(name,parent);
endfunction


//-----------------------------Build Phase--------------------------------
function void counter_tb::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(env_config)::get(this,"*","env_config",e_cfg))
		`uvm_fatal("ROUTER_TB","Could not get env_config from uvm_config_db... did u set it?")

	//Create object for source agt top
	begin
		wagt_top = wr_agent_top::type_id::create("wagt_top",this);
	end
//endfunction

	if(e_cfg.has_scoreboard) begin
		sb = scoreboard::type_id::create("sb", this);
	end
endfunction


//-----------------------------Connect Phase--------------------------------
function void counter_tb::connect_phase(uvm_phase phase);
	wagt_top.agnth[0].s_monh.ap.connect(sb.fifo_wrh[0].analysis_export);
endfunction

