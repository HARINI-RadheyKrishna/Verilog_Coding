vcom -work EE560CMP -refresh -force_refresh
vsim -gui -novopt EE560CMP.cmp_tb
run 100us
mem save -o DM.mem -f mti -data hex -addr hex -startaddress 0 -endaddress 35 -wordsperline 4 /cmp_tb/uut_cmp/uut_MM/Data_MM/d_mem