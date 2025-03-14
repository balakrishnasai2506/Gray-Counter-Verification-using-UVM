class seq_base extends uvm_sequence#(wr_xtn);
	`uvm_object_utils(seq_base)

	//Methods
	extern function new(string name = "seq_base");
endclass

//Constructor new
function seq_base::new(string name = "seq_base");
	super.new(name);
endfunction


//Reset Sequence
class reset_seq extends seq_base;
	`uvm_object_utils(reset_seq)

	//Methods
	extern function new(string name = "reset_seq");
	extern task body();
endclass

//Constructor new
function reset_seq::new(string name = "reset_seq");
	super.new(name);
endfunction


//Body()
task reset_seq::body();
	req = wr_xtn::type_id::create("wr_xtn");

	start_item(req);
	assert(req.randomize() with {rst == 1;});
	finish_item(req);
endtask



//Counter Run Sequence
class counter_seq extends seq_base;
	`uvm_object_utils(counter_seq)

	//Methods
	extern function new(string name = "counter_seq");
	extern task body();
endclass

//Constructor new
function counter_seq::new(string name = "counter_seq");
	super.new(name);
endfunction


//Body()
task counter_seq::body();
		req = wr_xtn::type_id::create("wr_xtn");
		start_item(req);
		assert(req.randomize() with {rst == 0;});
		finish_item(req);
endtask
