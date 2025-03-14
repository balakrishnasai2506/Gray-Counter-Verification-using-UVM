class sequencer extends uvm_sequencer#(wr_xtn);
        `uvm_component_utils(sequencer)

        extern function new(string name = "sequencer", uvm_component parent);
endclass

function sequencer::new(string name = "sequencer", uvm_component parent);
        super.new(name, parent);
endfunction


