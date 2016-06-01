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

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config  -ruleid {1}  -id {USF-XSim 62}  -string {{ERROR: [USF-XSim-62] 'compile' step failed with error(s). Please check the Tcl console output or 'C:/Users/Ben/Documents/GitHub/Fpga_project/Visualisatie/visualisatie.sim/sim_1/behav/xvhdl.log' file for more information.}}  -suppress 

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  create_project -in_memory -part xc7a35tcpg236-1
  set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir C:/Users/Ben/Documents/GitHub/Fpga_project/Visualisatie/Visualisatie.cache/wt [current_project]
  set_property parent.project_path C:/Users/Ben/Documents/GitHub/Fpga_project/Visualisatie/Visualisatie.xpr [current_project]
  set_property ip_repo_paths c:/Users/Ben/Documents/GitHub/Fpga_project/Visualisatie/Visualisatie.cache/ip [current_project]
  set_property ip_output_repo c:/Users/Ben/Documents/GitHub/Fpga_project/Visualisatie/Visualisatie.cache/ip [current_project]
  add_files -quiet C:/Users/Ben/Documents/GitHub/Fpga_project/Visualisatie/Visualisatie.runs/synth_1/Top.dcp
  read_xdc C:/Users/Ben/Documents/GitHub/Fpga_project/Visualisatie/Basys3_Master.xdc
  link_design -top Top -part xc7a35tcpg236-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force Top_opt.dcp
  report_drc -file Top_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file Top.hwdef}
  place_design 
  write_checkpoint -force Top_placed.dcp
  report_io -file Top_io_placed.rpt
  report_utilization -file Top_utilization_placed.rpt -pb Top_utilization_placed.pb
  report_control_sets -verbose -file Top_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force Top_routed.dcp
  report_drc -file Top_drc_routed.rpt -pb Top_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file Top_timing_summary_routed.rpt -rpx Top_timing_summary_routed.rpx
  report_power -file Top_power_routed.rpt -pb Top_power_summary_routed.pb
  report_route_status -file Top_route_status.rpt -pb Top_route_status.pb
  report_clock_utilization -file Top_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

