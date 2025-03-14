class env_config extends uvm_object;

	`uvm_object_utils(env_config) //Factory Registration

	//Source and Destination Agent Configuration Class Handles Declaration
	agent_config agt_cfg[];
	

	//Data Members
	int no_of_agt;
	bit has_scoreboard = 1;
	//Methods
	extern function new(string name = "env_config");

endclass

//---------------------Constructor "new"---------------------------

function env_config::new(string name = "env_config");
	super.new(name);
endfunction
