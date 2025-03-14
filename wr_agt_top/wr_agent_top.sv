class wr_agent_top extends uvm_env;
	`uvm_component_utils(wr_agent_top) //Factory Registration

	//Declare Write Agent handle
	agent agnth[];

	//Declare a handle for env_config
	env_config e_cfg;

	//Standard Methods
	extern function new(string name = "wr_agent_top", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass


//---------------------------------Constructor "new"-------------------------------------
function wr_agent_top::new(string name = "wr_agent_top", uvm_component parent);
	super.new(name,parent);
endfunction


//---------------------------------Build Phase-------------------------------------
function void wr_agent_top::build_phase(uvm_phase phase);
	super.build_phase(phase);

	//Get the env_config from uvm_config_db
	if(!uvm_config_db #(env_config)::get(this,"*","env_config",e_cfg))
		`uvm_fatal("WR_AGENT_TOP","Could not get ENV_CONFIG.... Did u set it???")

	agnth = new[e_cfg.no_of_agt];

	foreach(agnth[i]) begin
		agnth[i] = agent::type_id::create($sformatf("agnth[%0d]",i),this);
		uvm_config_db #(agent_config)::set(this,$sformatf("agnth[%0d]",i),"agent_config",e_cfg.agt_cfg[i]);
	end
endfunction
