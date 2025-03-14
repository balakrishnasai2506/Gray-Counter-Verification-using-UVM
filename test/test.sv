class counter_test extends uvm_test;
	`uvm_component_utils(counter_test)

//Declare Agent and Env config handles
	agent_config c_cfg[];
	
	env_config e_cfg;

	//Declare router_env handle
	counter_tb env;

	int no_of_wagts = 1; //Source agent

	int has_sagt = 1;

	//Methods
	extern function new(string name = "counter_test",uvm_component parent);
	extern function void config_counter();
	extern function void build_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);
endclass

function counter_test::new(string name = "counter_test", uvm_component parent);
	super.new(name,parent);
endfunction

function void counter_test::config_counter();
	if(has_sagt) begin
		c_cfg = new[no_of_wagts];
		foreach(c_cfg[i]) begin
			c_cfg[i] = agent_config::type_id::create($sformatf("c_cfg[%d]",i));
			if(!uvm_config_db#(virtual gray_counter_if)::get(this, "", "vif", c_cfg[i].vif))
				`uvm_fatal("VIF_CONG AT SOURCE","cannot get() interface from uvm_config_db, did you set it right?");
		$display("-----------------------%p",c_cfg[i]);
			c_cfg[i].is_active = UVM_ACTIVE;
				e_cfg.agt_cfg[i] = c_cfg[i];
		end
	end

	e_cfg.no_of_agt = no_of_wagts;

endfunction


function void counter_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
	e_cfg = env_config::type_id::create("e_cfg");
	
	if(has_sagt)
		e_cfg.agt_cfg = new[no_of_wagts];

	config_counter();

	uvm_config_db#(env_config)::set(this,"*","env_config",e_cfg); //Setting env_cfg into uvm_config_db

	env = counter_tb::type_id::create("env",this);

endfunction


function void counter_test::end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
	uvm_top.print_topology();
endfunction


//------------------------------------Reset and Count test------------------------------------------------
class reset_then_count_test extends counter_test;
	`uvm_component_utils(reset_then_count_test) //Factory Registration
	reset_seq seq1;
	counter_seq seq2;

	//Methods
	extern function new(string name = "reset_then_count_test", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass


//--------------------------------Constructor "new"----------------------------------------
function reset_then_count_test::new(string name = "reset_then_count_test", uvm_component parent);
	super.new(name, parent);
endfunction


//--------------------------------Build Phase()--------------------------------------------
function void reset_then_count_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction


//--------------------------------Run Phase()--------------------------------------------
task reset_then_count_test::run_phase(uvm_phase phase);
	//Create object for seq1 using "create" method
	seq1 = reset_seq::type_id::create("seq1");
	seq2 = counter_seq::type_id::create("seq2");

	phase.raise_objection(this);
		seq1.start(env.wagt_top.agnth[0].s_seqrh);
		#10;
		seq2.start(env.wagt_top.agnth[0].s_seqrh);
		#100;
		seq1.start(env.wagt_top.agnth[0].s_seqrh);
		#10;
		seq2.start(env.wagt_top.agnth[0].s_seqrh);
		#200;
	phase.drop_objection(this);
endtask
