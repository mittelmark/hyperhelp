if {![package vsatisfies [package provide Tcl] 8.6]} {return}

package ifneeded oohistory  0.4.0 [list source [file join $dir oohistory.tcl]]

