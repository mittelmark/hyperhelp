if {![package vsatisfies [package provide Tcl] 8.6-]} {return}

package ifneeded hyperhelp 1.1.1 [list source [file join $dir hyperhelp.tcl]]

