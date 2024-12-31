if {![package vsatisfies [package provide Tcl] 8.6]} {return}

package ifneeded hyperhelp 1.1.0 [list source -encoding iso8859-15 [file join $dir hyperhelp.tcl]]

