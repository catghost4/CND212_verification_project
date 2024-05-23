
vlog \
-permissive \
+cover\
-f ALU_compile_files.f

vsim \
-c \
-displaymsgmode both \
-onfinish stop \
-voptargs=+acc \
-coverage\
+UVM_TESTNAME=ALU_test \
+UVM_VERBOSITY=UVM_HIGH \
+UVM_NO_RELNOTES \
work.ALU_tb


add wave -position insertpoint sim:/ALU_tb/intf_a/*


run -all

wave zoom full
