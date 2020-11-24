################################################################################
# Copyright (c) 2018 STMicroelectronics.
# All rights reserved. This program and the accompanying materials
# is the property of STMicroelectronics and must not be
# reproduced, disclosed to any third party, or used in any
# unauthorized manner without written consent.
################################################################################

# Support all OpenOCD Command and Driver Index based on following reference manual
# http://openocd.org/doc-release/pdf/openocd.pdf
# Open On-Chip Debugger: OpenOCD Users Guide
# Release 0.10.0 - 15 January 2017


# Define way to locate openOCD sub TCL script
proc find {subFile} {
	global OPENOCD_SCRIPTS_LOCATIONS

	foreach path $OPENOCD_SCRIPTS_LOCATIONS {
		set files [glob -nocomplain $path/$subFile]
		#set files [list $path/$subFile]
		if {[llength $files] != 0} then {return [lindex $files 0]}
	}

	return ""
 }

# Define dump procedures
proc dumpEnv {} {
	global fileId

	if {[llength [info globals]]!=0} {
		puts $fileId "\### Env dump"
	}

	foreach varname [lsort [info globals]] {
        upvar "#0" $varname var
        if {[array exists var]} continue;    # Skip global arrays...
		if {[string length $var] == 0} continue; # Skip null variable...
        puts $fileId "set $varname $var"
    }

	if {[llength [info globals]]!=0} {
		puts $fileId "\n\n\### Script dump"
	}
}

set DO_DUMP 1
proc dump {cmdName args} {
	global DO_DUMP
	global fileId

	for {set i 0} {$i<[llength $args]} {incr i} {
		append string [lindex $args $i]
	}

	if { [expr ($DO_DUMP == 1)] } {
		puts $fileId "$cmdName $string"
	}
}

# Define some key interface global variables
set _using_hla false
set _using_jtag false
set _using_swd false
set _using_stlink_swd false
set _using_stlink_jtag false

proc interface {interface} {
	global _using_hla
	global _using_jtag
	global _using_swd
	if {[string equal "hla" $interface]} {
		set _using_hla true
	} elseif {[string equal "jtag" $interface]} {
		set _using_jtag true
	} elseif {[string equal "swd" $interface]} {
		set _using_swd true
	}

	dump [lindex [info level 0] 0] $interface
}

proc using_hla {} {
	global _using_hla
	return $_using_hla
}

proc using_jtag {} {
	global _using_jtag
	return $_using_jtag
}

proc using_swd {} {
	global _using_swd
	return $_using_swd
}

proc using_stlink_jtag {} {
	global _using_stlink_jtag
	return $_using_stlink_jtag
}

proc using_stlink_swd {} {
	global _using_stlink_swd
	return $_using_stlink_swd
}

# Define some key procedures override
proc hla_use_stlink_server {args} {
	dump [lindex [info level 0] 0] $args
}

proc st-link {args} {
	dump [lindex [info level 0] 0] $args
}

proc transport {args} {
	if {[llength $args]!=1} {
		dump [lindex [info level 0] 0] $args
	}
}

proc target {cmd varName args} {

	dump [lindex [info level 0] 0] $cmd " " $varName " " $args

	if {[string equal "create" $cmd]} {
		global  $varName
		set procName ""
		append procName $varName
		proc $procName {args} {
			dump [lindex [info level 0] 0] $args
		}
	}
}

proc dap {cmd varName args} {

	dump [lindex [info level 0] 0] $cmd " " $varName " " $args

	if {[string equal "create" $cmd]} {
		global  $varName
		set procName ""
		append procName $varName
		proc $procName {args} {
			dump [lindex [info level 0] 0] $args
		}
	}
}

proc flash {cmd varName args} {

	dump [lindex [info level 0] 0] $cmd " " $varName " " $args

	if {[string equal "bank" $cmd]} {
		global  $varName
		set procName ""
		append procName $varName
		proc $procName {args} {
			dump [lindex [info level 0] 0] $args
		}
	}
}

proc cti {cmd varName args} {

	dump [lindex [info level 0] 0] $cmd " " $varName " " $args

	if {[string equal "create" $cmd]} {
		global  $varName
		set procName ""
		append procName $varName
		proc $procName {args} {
			dump [lindex [info level 0] 0] $args
		}
	}
}

# Define some documentation procedures
proc add_usage_text {args} {
	dump [lindex [info level 0] 0] $args
}

proc add_help_text {args} {
	dump [lindex [info level 0] 0] $args
}

# Command and driver index catalog
proc adapter {args} {
	dump [lindex [info level 0] 0] $args
}

proc adapter_khz {args} {
	dump [lindex [info level 0] 0] $args
}

proc adapter_name {args} {
	dump [lindex [info level 0] 0] $args
}

proc adapter_nsrst_assert_width {args} {
	dump [lindex [info level 0] 0] $args
}

proc adapter_nsrst_delay {args} {
	dump [lindex [info level 0] 0] $args
}

proc add_script_search_dir {args} {
	dump [lindex [info level 0] 0] $args
}

proc addreg {args} {
	dump [lindex [info level 0] 0] $args
}

proc aduc702x {args} {
	dump [lindex [info level 0] 0] $args
}

proc ambiqmicro {args} {
	dump [lindex [info level 0] 0] $args
}

proc amt_jtagaccel {args} {
	dump [lindex [info level 0] 0] $args
}

proc append_file {args} {
	dump [lindex [info level 0] 0] $args
}

proc arm {args} {
	dump [lindex [info level 0] 0] $args
}

proc arm-jtag-ew {args} {
	dump [lindex [info level 0] 0] $args
}

proc arm11 {args} {
	dump [lindex [info level 0] 0] $args
}

proc arm720t {args} {
	dump [lindex [info level 0] 0] $args
}

proc arm7_9 {args} {
	dump [lindex [info level 0] 0] $args
}

proc arm9 {args} {
	dump [lindex [info level 0] 0] $args
}

proc arm920t {args} {
	dump [lindex [info level 0] 0] $args
}

proc arm926ejs {args} {
	dump [lindex [info level 0] 0] $args
}

proc arm966e {args} {
	dump [lindex [info level 0] 0] $args
}

proc armjtagew_info {args} {
	dump [lindex [info level 0] 0] $args
}

proc arp_examine {args} {
	dump [lindex [info level 0] 0] $args
}

proc arp_halt {args} {
	dump [lindex [info level 0] 0] $args
}

proc arp_poll {args} {
	dump [lindex [info level 0] 0] $args
}

proc arp_reset {args} {
	dump [lindex [info level 0] 0] $args
}

proc arp_waitstate {args} {
	dump [lindex [info level 0] 0] $args
}

proc array2mem {args} {
	dump [lindex [info level 0] 0] $args
}

proc at91rm9200 {args} {
	dump [lindex [info level 0] 0] $args
}

proc at91sam3 {args} {
	dump [lindex [info level 0] 0] $args
}

proc at91sam4 {args} {
	dump [lindex [info level 0] 0] $args
}

proc at91sam4l {args} {
	dump [lindex [info level 0] 0] $args
}

proc at91sam7 {args} {
	dump [lindex [info level 0] 0] $args
}

proc at91sam9 {args} {
	dump [lindex [info level 0] 0] $args
}

proc at91samd {args} {
	dump [lindex [info level 0] 0] $args
}

proc atsamv {args} {
	dump [lindex [info level 0] 0] $args
}

proc avr {args} {
	dump [lindex [info level 0] 0] $args
}

proc bcm2835gpio {args} {
	dump [lindex [info level 0] 0] $args
}

proc bindto {args} {
	dump [lindex [info level 0] 0] $args
}

proc bp {args} {
	dump [lindex [info level 0] 0] $args
}

proc cache_config {args} {
	dump [lindex [info level 0] 0] $args
}

proc cat {args} {
	dump [lindex [info level 0] 0] $args
}

proc cfi {args} {
	dump [lindex [info level 0] 0] $args
}

proc cget {args} {
	dump [lindex [info level 0] 0] $args
}

proc cmsis-dap {args} {
	dump [lindex [info level 0] 0] $args
}

proc cmsis_dap_serial {args} {
	dump [lindex [info level 0] 0] $args
}

proc cmsis_dap_vid_pid {args} {
	dump [lindex [info level 0] 0] $args
}

proc configure {args} {
	dump [lindex [info level 0] 0] $args
}

proc cortex_a {args} {
	dump [lindex [info level 0] 0] $args
}

proc cortex_m {args} {
	dump [lindex [info level 0] 0] $args
}

proc cortex_r {args} {
	dump [lindex [info level 0] 0] $args
}

proc cp {args} {
	dump [lindex [info level 0] 0] $args
}

proc curstate {args} {
	dump [lindex [info level 0] 0] $args
}

proc davinci {args} {
	dump [lindex [info level 0] 0] $args
}

proc debug_level {args} {
	dump [lindex [info level 0] 0] $args
}

proc drscan {args} {
	dump [lindex [info level 0] 0] $args
}

proc du_select {args} {
	dump [lindex [info level 0] 0] $args
}

proc dummy {args} {
	dump [lindex [info level 0] 0] $args
}

proc dump_image {args} {
	dump [lindex [info level 0] 0] $args
}

proc echo {args} {
	dump [lindex [info level 0] 0] $args
}

proc efm32 {args} {
	dump [lindex [info level 0] 0] $args
}

proc ep93xx {args} {
	dump [lindex [info level 0] 0] $args
}

proc etb {args} {
	dump [lindex [info level 0] 0] $args
}

proc etm {args} {
	dump [lindex [info level 0] 0] $args
}

proc etm_dummy {args} {
	dump [lindex [info level 0] 0] $args
}

proc eventlist {args} {
	dump [lindex [info level 0] 0] $args
}

proc exit {args} {
	dump [lindex [info level 0] 0] $args
}

proc fast_load {args} {
	dump [lindex [info level 0] 0] $args
}

proc fast_load_image {args} {
	dump [lindex [info level 0] 0] $args
}

proc flush_count {args} {
	dump [lindex [info level 0] 0] $args
}

proc fm3 {args} {
	dump [lindex [info level 0] 0] $args
}

proc fm4 {args} {
	dump [lindex [info level 0] 0] $args
}

proc ftdi {args} {
	dump [lindex [info level 0] 0] $args
}

proc ftdi_channel {args} {
	dump [lindex [info level 0] 0] $args
}

proc ftdi_device_desc {args} {
	dump [lindex [info level 0] 0] $args
}

proc ftdi_get_signal {args} {
	dump [lindex [info level 0] 0] $args
}

proc ftdi_layout_init {args} {
	dump [lindex [info level 0] 0] $args
}

proc ftdi_layout_signal {args} {
	dump [lindex [info level 0] 0] $args
}

proc ftdi_location {args} {
	dump [lindex [info level 0] 0] $args
}

proc ftdi_serial {args} {
	dump [lindex [info level 0] 0] $args
}

proc ftdi_set_signal {args} {
	dump [lindex [info level 0] 0] $args
}

proc ftdi_tdo_sample_edge {args} {
	dump [lindex [info level 0] 0] $args
}

proc ftdi_vid_pid {args} {
	dump [lindex [info level 0] 0] $args
}

proc gdb_breakpoint_override {args} {
	dump [lindex [info level 0] 0] $args
}

proc gdb_flash_program {args} {
	dump [lindex [info level 0] 0] $args
}

proc gdb_memory_map {args} {
	dump [lindex [info level 0] 0] $args
}

proc gdb_port {args} {
	dump [lindex [info level 0] 0] $args
}

proc gdb_report_data_abort {args} {
	dump [lindex [info level 0] 0] $args
}

proc gdb_save_tdesc {args} {
	dump [lindex [info level 0] 0] $args
}

proc gdb_target_description {args} {
	dump [lindex [info level 0] 0] $args
}

proc gw16012 {args} {
	dump [lindex [info level 0] 0] $args
}

proc halt {args} {
	dump [lindex [info level 0] 0] $args
}

proc help {args} {
	dump [lindex [info level 0] 0] $args
}

proc hla {args} {
	dump [lindex [info level 0] 0] $args
}

proc hla_command {args} {
	dump [lindex [info level 0] 0] $args
}

proc hla_device_desc {args} {
	dump [lindex [info level 0] 0] $args
}

proc hla_layout {args} {
	dump [lindex [info level 0] 0] $args
}

proc hla_serial {args} {
	dump [lindex [info level 0] 0] $args
}

proc hla_vid_pid {args} {
	dump [lindex [info level 0] 0] $args
}

proc init {args} {
	dump [lindex [info level 0] 0] $args
}

proc init_reset {args} {
	dump [lindex [info level 0] 0] $args
}

proc interface_list {args} {
	dump [lindex [info level 0] 0] $args
}

proc invoke-event {args} {
	dump [lindex [info level 0] 0] $args
}

proc ip {args} {
	dump [lindex [info level 0] 0] $args
}

proc irscan {args} {
	dump [lindex [info level 0] 0] $args
}

proc itm {args} {
	dump [lindex [info level 0] 0] $args
}

proc jlink {args} {
	dump [lindex [info level 0] 0] $args
}

proc jtag {args} {
	dump [lindex [info level 0] 0] $args
}

proc jtag_init {args} {
	dump [lindex [info level 0] 0] $args
}

proc jtag_ntrst_assert_width {args} {
	dump [lindex [info level 0] 0] $args
}

proc jtag_ntrst_delay {args} {
	dump [lindex [info level 0] 0] $args
}

proc jtag_rclk {args} {
	dump [lindex [info level 0] 0] $args
}

proc jtag_reset {args} {
	dump [lindex [info level 0] 0] $args
}

proc jtagspi {args} {
	dump [lindex [info level 0] 0] $args
}

proc kinetis {args} {
	dump [lindex [info level 0] 0] $args
}

proc kinetis_ke {args} {
	dump [lindex [info level 0] 0] $args
}

proc load_image {args} {
	dump [lindex [info level 0] 0] $args
}

proc log_output {args} {
	dump [lindex [info level 0] 0] $args
}

proc lpc2000 {args} {
	dump [lindex [info level 0] 0] $args
}

proc lpc288x {args} {
	dump [lindex [info level 0] 0] $args
}

proc lpc2900 {args} {
	dump [lindex [info level 0] 0] $args
}

proc lpc3180 {args} {
	dump [lindex [info level 0] 0] $args
}

proc lpcspifi {args} {
	dump [lindex [info level 0] 0] $args
}

proc ls {args} {
	dump [lindex [info level 0] 0] $args
}

proc mac {args} {
	dump [lindex [info level 0] 0] $args
}

proc mdb {args} {
	dump [lindex [info level 0] 0] $args
}

proc mdh {args} {
	dump [lindex [info level 0] 0] $args
}

proc mdr {args} {
	dump [lindex [info level 0] 0] $args
}

proc mdw {args} {
	dump [lindex [info level 0] 0] $args
}

proc mem2array {args} {
	dump [lindex [info level 0] 0] $args
}

proc memTestAddressBus {args} {
	dump [lindex [info level 0] 0] $args
}

proc memTestDataBus {args} {
	dump [lindex [info level 0] 0] $args
}

proc memTestDevice {args} {
	dump [lindex [info level 0] 0] $args
}

proc meminfo {args} {
	dump [lindex [info level 0] 0] $args
}

proc mflash {args} {
	dump [lindex [info level 0] 0] $args
}

proc mrvlqspi {args} {
	dump [lindex [info level 0] 0] $args
}

proc mwb {args} {
	dump [lindex [info level 0] 0] $args
}

proc mwh {args} {
	dump [lindex [info level 0] 0] $args
}

proc mww {args} {
	dump [lindex [info level 0] 0] $args
}

proc mx3 {args} {
	dump [lindex [info level 0] 0] $args
}

proc mxc {args} {
	dump [lindex [info level 0] 0] $args
}

proc nand {args} {
	dump [lindex [info level 0] 0] $args
}

proc niietcm4 {args} {
	dump [lindex [info level 0] 0] $args
}

proc nrf51 {args} {
	dump [lindex [info level 0] 0] $args
}

proc ocl {args} {
	dump [lindex [info level 0] 0] $args
}

proc oocd_trace {args} {
	dump [lindex [info level 0] 0] $args
}

proc opendous {args} {
	dump [lindex [info level 0] 0] $args
}

proc openjtag {args} {
	dump [lindex [info level 0] 0] $args
}

proc openjtag_device_desc {args} {
	dump [lindex [info level 0] 0] $args
}

proc openjtag_variant {args} {
	dump [lindex [info level 0] 0] $args
}

proc orion {args} {
	dump [lindex [info level 0] 0] $args
}

proc parport {args} {
	dump [lindex [info level 0] 0] $args
}

proc parport_cable {args} {
	dump [lindex [info level 0] 0] $args
}

proc parport_port {args} {
	dump [lindex [info level 0] 0] $args
}

proc parport_toggling_time {args} {
	dump [lindex [info level 0] 0] $args
}

proc parport_write_on_exit {args} {
	dump [lindex [info level 0] 0] $args
}

proc pathmove {args} {
	dump [lindex [info level 0] 0] $args
}

proc peek {args} {
	dump [lindex [info level 0] 0] $args
}

proc pic32mx {args} {
	dump [lindex [info level 0] 0] $args
}

proc pld {args} {
	dump [lindex [info level 0] 0] $args
}

proc poke {args} {
	dump [lindex [info level 0] 0] $args
}

proc poll {args} {
	dump [lindex [info level 0] 0] $args
}

proc power {args} {
	dump [lindex [info level 0] 0] $args
}

proc presto {args} {
	dump [lindex [info level 0] 0] $args
}

proc presto_serial {args} {
	dump [lindex [info level 0] 0] $args
}

proc profile {args} {
	dump [lindex [info level 0] 0] $args
}

proc program {args} {
	dump [lindex [info level 0] 0] $args
}

proc psoc4 {args} {
	dump [lindex [info level 0] 0] $args
}

proc rbp {args} {
	dump [lindex [info level 0] 0] $args
}

proc readgroup {args} {
	dump [lindex [info level 0] 0] $args
}

proc reg {args} {
	dump [lindex [info level 0] 0] $args
}

proc remote_bitbang {args} {
	dump [lindex [info level 0] 0] $args
}

proc remote_bitbang_host {args} {
	dump [lindex [info level 0] 0] $args
}

proc remote_bitbang_port {args} {
	dump [lindex [info level 0] 0] $args
}

proc reset {args} {
	dump [lindex [info level 0] 0] $args
}

proc reset_config {args} {
	dump [lindex [info level 0] 0] $args
}

proc resume {args} {
	dump [lindex [info level 0] 0] $args
}

proc rlink {args} {
	dump [lindex [info level 0] 0] $args
}

proc rm {args} {
	dump [lindex [info level 0] 0] $args
}

proc rtck {args} {
	dump [lindex [info level 0] 0] $args
}

proc runAllMemTests {args} {
	dump [lindex [info level 0] 0] $args
}

proc runtest {args} {
	dump [lindex [info level 0] 0] $args
}

proc rwp {args} {
	dump [lindex [info level 0] 0] $args
}

proc s3c2410 {args} {
	dump [lindex [info level 0] 0] $args
}

proc s3c2412 {args} {
	dump [lindex [info level 0] 0] $args
}

proc s3c2440 {args} {
	dump [lindex [info level 0] 0] $args
}

proc s3c2443 {args} {
	dump [lindex [info level 0] 0] $args
}

proc s3c6400 {args} {
	dump [lindex [info level 0] 0] $args
}

proc scan_chain {args} {
	dump [lindex [info level 0] 0] $args
}

proc shutdown {args} {
	dump [lindex [info level 0] 0] $args
}

proc sim3x {args} {
	dump [lindex [info level 0] 0] $args
}

proc sleep {args} {
	dump [lindex [info level 0] 0] $args
}

proc soft_reset_halt {args} {
	dump [lindex [info level 0] 0] $args
}

proc stellaris {args} {
	dump [lindex [info level 0] 0] $args
}

proc step {args} {
	dump [lindex [info level 0] 0] $args
}

proc stm32f1x {args} {
	dump [lindex [info level 0] 0] $args
}

proc stm32f2x {args} {
	dump [lindex [info level 0] 0] $args
}

proc stm32lx {args} {
	dump [lindex [info level 0] 0] $args
}

proc stmsmi {args} {
	dump [lindex [info level 0] 0] $args
}

proc str7x {args} {
	dump [lindex [info level 0] 0] $args
}

proc str9x {args} {
	dump [lindex [info level 0] 0] $args
}

proc str9xpec {args} {
	dump [lindex [info level 0] 0] $args
}

proc svf {args} {
	dump [lindex [info level 0] 0] $args
}

proc swd {args} {
	dump [lindex [info level 0] 0] $args
}

proc tap_select {args} {
	dump [lindex [info level 0] 0] $args
}

proc target_request {args} {
	dump [lindex [info level 0] 0] $args
}

proc targets {args} {
	dump [lindex [info level 0] 0] $args
}

proc tcl_notifications {args} {
	dump [lindex [info level 0] 0] $args
}

proc tcl_port {args} {
	dump [lindex [info level 0] 0] $args
}

proc tcl_trace {args} {
	dump [lindex [info level 0] 0] $args
}

proc telnet_port {args} {
	dump [lindex [info level 0] 0] $args
}

proc test_image {args} {
	dump [lindex [info level 0] 0] $args
}

proc tms470 {args} {
	dump [lindex [info level 0] 0] $args
}

proc tpiu {args} {
	dump [lindex [info level 0] 0] $args
}

proc trace {args} {
	dump [lindex [info level 0] 0] $args
}

proc trunc {args} {
	dump [lindex [info level 0] 0] $args
}

proc ulink {args} {
	dump [lindex [info level 0] 0] $args
}

proc usb_blaster {args} {
	dump [lindex [info level 0] 0] $args
}

proc usb_blaster_device_desc {args} {
	dump [lindex [info level 0] 0] $args
}

proc usb_blaster_firmware {args} {
	dump [lindex [info level 0] 0] $args
}

proc usb_blaster_lowlevel_driver {args} {
	dump [lindex [info level 0] 0] $args
}

proc usb_blaster_pin {args} {
	dump [lindex [info level 0] 0] $args
}

proc usb_blaster_vid_pid {args} {
	dump [lindex [info level 0] 0] $args
}

proc usbprog {args} {
	dump [lindex [info level 0] 0] $args
}

proc verify_image {args} {
	dump [lindex [info level 0] 0] $args
}

proc verify_image_checksum {args} {
	dump [lindex [info level 0] 0] $args
}

proc verify_ircapture {args} {
	dump [lindex [info level 0] 0] $args
}

proc verify_jtag {args} {
	dump [lindex [info level 0] 0] $args
}

proc version {args} {
	dump [lindex [info level 0] 0] $args
}

proc virt2phys {args} {
	dump [lindex [info level 0] 0] $args
}

proc virtex2 {args} {
	dump [lindex [info level 0] 0] $args
}

proc virtual {args} {
	dump [lindex [info level 0] 0] $args
}

proc vsllink {args} {
	dump [lindex [info level 0] 0] $args
}

proc wait_halt {args} {
	dump [lindex [info level 0] 0] $args
}

proc wp {args} {
	dump [lindex [info level 0] 0] $args
}

proc x86_32 {args} {
	dump [lindex [info level 0] 0] $args
}

proc xmc1xxx {args} {
	dump [lindex [info level 0] 0] $args
}

proc xmc4xxx {args} {
	dump [lindex [info level 0] 0] $args
}

proc xscale {args} {
	dump [lindex [info level 0] 0] $args
}

proc xsvf {args} {
	dump [lindex [info level 0] 0] $args
}

proc ZY1000 {args} {
	dump [lindex [info level 0] 0] $args
}
