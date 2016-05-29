proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config  -ruleid {1}  -id {USF-XSim 62}  -string {{ERROR: [USF-XSim-62] 'compile' step failed with error(s). Please check the Tcl console output or 'C:/Users/Ben/Documents/GitHub/Fpga_project/Visualisatie/visualisatie.sim/sim_1/behav/xvhdl.log' file for more information.}}  -suppress 

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  open_checkpoint Top_routed.dcp
  set_property webtalk.parent_dir C:/Users/Ben/Documents/GitHub/Fpga_project/Visualisatie/Visualisatie.cache/wt [current_project]
  catch { write_mem_info -force Top.mmi }
  write_bitstream -force Top.bit 
  catch { write_sysdef -hwdef Top.hwdef -bitfile Top.bit -meminfo Top.mmi -file Top.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

