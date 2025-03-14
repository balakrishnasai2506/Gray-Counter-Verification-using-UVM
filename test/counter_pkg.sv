package counter_pkg;


//import uvm_pkg.sv
	import uvm_pkg::*;
//include uvm_macros.sv
	`include "uvm_macros.svh"

`include "wr_xtn.sv"
`include "agent_config.sv"
`include "env_config.sv"
`include "driver.sv"
`include "monitor.sv"
`include "sequencer.sv"
`include "agent.sv"
`include "wr_agent_top.sv"
`include "sequence.sv"

`include "scoreboard.sv"

`include "counter_tb.sv"


`include "test.sv"
endpackage
