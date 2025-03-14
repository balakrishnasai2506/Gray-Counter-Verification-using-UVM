class wr_xtn extends uvm_sequence_item;
	`uvm_object_utils(wr_xtn)

	//Data Members
	rand bit rst;
	bit [3:0] gray_count, bin_count;

	//Constraints
	constraint valid_rst {rst inside {0,1};}


	//Methods
	extern function new(string name = "wr_xtn");
	extern function void do_print(uvm_printer printer);

endclass


//Constructor "new"
function wr_xtn::new(string name = "wr_xtn");
	super.new(name);
endfunction


//Do_print()
function void wr_xtn::do_print(uvm_printer printer);
	super.do_print(printer);
	printer.print_field("rst", this.rst, 1, UVM_BIN);
	printer.print_field("bin_count", this.bin_count, 4, UVM_HEX);
	printer.print_field("gray_count", this.gray_count, 4, UVM_HEX);
endfunction
