if {![package vsatisfies [package provide Tcl] 8.6]} {return}

package ifneeded shistory  0.3.0 [list source [file join $dir shistory.tcl]]
package ifneeded hyperhelp 1.0.0 [list source [file join $dir hyperhelp.tcl]]

