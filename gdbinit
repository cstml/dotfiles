# gdb-init
#
# revision 1
#
# date 2020-06-13
#--------------------------------
# refresh screen every time next 
# or similar commands are called
#define hook-next
#  refresh
#end
#--------------------------------
# 
#--------------------------------
# enables vi- like commands for 
# the TUI
set editing-mode vi
#--------------------------------
# 
#--------------------------------
# Display instructions in Intel format
set disassembly-flavor intel
#--------------------------------
# 
#--------------------------------
# Display instructions in Intel format
define nextloc
    next info locals
end
document nextloc
next and info locals
end
#--------------------------------
# 
