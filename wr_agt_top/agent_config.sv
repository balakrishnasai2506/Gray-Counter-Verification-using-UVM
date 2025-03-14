class agent_config extends uvm_object;
	`uvm_object_utils(agent_config)

	virtual gray_counter_if vif;
	
	uvm_active_passive_enum is_active;

	extern function new(string name = "agent_config");
endclass

function agent_config::new(string name = "agent_config");
	super.new(name);
endfunction 
