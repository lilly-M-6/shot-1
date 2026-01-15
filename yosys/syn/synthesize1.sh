# LEAKAGE ABC


# Command line arguments:
# $1: The projects hardware description language (either VHDL or Verilog)
# $2: The path to the rtl code. All files must be in one directory
# $3: The name of the top module

# The yosys script runs the following steps
# 1.) Read all design files
# 2.) Read all library files
# 3.) Prevent any cross-boundary optimizations
# 4.) Generic synthesis with a given top module
# 5.) Mapping flip-flops to the library
# 6.) Mapping logic to the library
# 7.) Print some statistics
# 8.) Remove the keep hierarchy attribute
# 9.) Flatten the netlist
# 10.) Identify unused signals and cells and remove them
# 11.) Select the top module
# 12.) Write the synthsized design without attributes

# Path to the Yosys library files
LIBRARY_PATH="../lib/"

if [[ $1 == "VHDL" || $1 == "vhdl" || $1 == "Vhdl" ]]; 
then
    # Analyze VHDL sources
    ghdl -a $2*.vhd

    # Run 1.) - 12.)
    yosys -m ghdl -p 'ghdl '"$3"'; read_verilog -lib '"$LIBRARY_PATH"'custom_cells.v; setattr -set keep_hierarchy 1; 
    synth -top '"$3"'; dfflibmap -liberty '"$LIBRARY_PATH"'custom_cells.lib; abc -liberty '"$LIBRARY_PATH"'custom_cells.lib; 
    stat -liberty '"$LIBRARY_PATH"'custom_cells.lib; setattr -set keep_hierarchy 0; flatten; opt_clean -purge; select '"$3"'; 
    write_verilog -noattr -selected design.v;';
elif [[ $1 == "VERILOG" || $1 == "verilog" || $1 == "Verilog" ]]
then
    # Run 1.) - 12.)
    # Build list of Verilog files (expand glob in shell, not in yosys)
    VERILOG_FILES=""
    for file in "$2"*.v; do
        if [ -f "$file" ]; then
            VERILOG_FILES="$VERILOG_FILES $file"
        fi
    done
    if [ -z "$VERILOG_FILES" ]; then
        echo "ERROR: No Verilog files found in $2"
        exit 1
    fi
    # Modified for masking: Keep hierarchy, don't flatten, minimal optimization
    # Use synth with -noabc to skip ABC technology mapping (which transforms XOR to XNOR)
    # This should preserve XOR logic while still mapping to library cells
    # Write all modules (not just selected) to include submodules
    yosys -p 'read_verilog '"$VERILOG_FILES"'; read_verilog -lib '"$LIBRARY_PATH"'custom_cells.v; 
    setattr -set keep_hierarchy 1; 
    synth -top '"$3"' -noabc; 
    dfflibmap -liberty '"$LIBRARY_PATH"'custom_cells.lib; 
    stat -liberty '"$LIBRARY_PATH"'custom_cells.lib; 
    write_verilog -noattr design.v;';
else
    echo "Command " $1 " is not supported.";
fi
