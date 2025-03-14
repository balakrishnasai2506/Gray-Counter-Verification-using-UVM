module top;
	//Import UVM and Local Packages
	import uvm_pkg::*;
	import counter_pkg::*;

	//Generating Clock
	bit clk;
	always #5 clk = ~clk;

	//Instantiating Interface
	gray_counter_if rif(clk);

	//Instantiating DUT/RTL and passing interface instance as an argument
	/*module gray_counter();
	input clk,rst;
	output reg [3:0] gray_count;
	reg [3:0] bin_count;
*/
	gray_counter DUT(
				.clk(clk),
				.rst(rif.rst),
				.gray_count(rif.gray_count),
				.bin_count_out(rif.bin_count)
		        );

	initial begin
		//Set the virtual interfaces as strings into uvm_config_db
		uvm_config_db#(virtual gray_counter_if)::set(null,"*","vif",rif);

		//Call run_test()
		run_test();
	end
endmodule

