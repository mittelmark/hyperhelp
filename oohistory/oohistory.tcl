#' ---
#' title: oohistory __PKGVERSION__
#' author: Detlef Groth, University of Potsdam, Germany
#' date: 2024-12-31 01:01
#' ---
#
#' ## NAME
#'
#' **oohistory** - history command implemented with tcloo
#'
#' ## <a name='toc'></a>TABLE OF CONTENTS
#' 
#'  - [SYNOPSIS](#synopsis)
#'  - [DESCRIPTION](#description)
#'  - [COMMAND](#command)
#'  - [TYPE OPTIONS](#options)
#'  - [TYPE COMMANDS](#commands)
#'  - [EXAMPLE](#example)
#'  - [INSTALLATION](#install)
#'  - [DOCUMENTATION](#docu)
#'  - [TODO](#todo)
#'  - [AUTHOR](#author)
#'  - [COPYRIGHT](#copyright)
#'  - [LICENSE](#license)
#'  
#' ## <a name='synopsis'>SYNOPSIS</a>
#' 
#' ```
#' package require oohistory
#' oohistory cmd ?option value?
#' cmd back 
#' cmd canBackward
#' cmd canForward
#' cmd canFirst
#' cmd canLast
#' cmd cget option
#' cmd configure option value
#' cmd current
#' cmd first
#' cmd forward
#' cmd getHistory
#' cmd home
#' cmd insert value
#' cmd last
#' cmd resetHistory
#' ```
#'
#' ## <a name='description'>DESCRIPTION</a>
#'
#' The **oohistory** class provides a command to allow the storage of text strings in a history. 
#' this can be useful to store for instance a browser history or a move history in a board game like Chess or Go.
#'
#' ## <a name='options'>TYPE OPTIONS</a>
#'


package require Tcl 8.6-
package provide oohistory

oo::class create oohistory {
    #' __-home__ value
    #'
    #' > The value which is set as the home, it is stored in principle as the first item in the history. Defaults to an empty string.
    variable options
    variable home ""
    variable index -1
    variable history
    constructor {args} {
        my variable history
        my variable options
        my variable index
        set index -1
        array set options [list -home ""]
        set history [list]
        my configure {*}$args
    }
    method configure {args} {
        my variable home
        my variable options
        if {[llength $args] == 0} {
            return [array get options]
        } else {
            array set options $args
            set home $options(-home)
        }
    }

    #' 
    #' ## <a name='commands'>TYPE COMMANDS</a>
    #' 
    #' The **oohistory** type supports a few commands to navigate in a history list.
    #'
    
    #' *cmd* **back** 
    #' 
    #' > Walks back in history one step and retrieves the value of the history at this position.
    #' 
    
    method back {} {
        my variable index
        my variable history
        incr index -1
        return [lindex $history $index]
    }
    #' *cmd* **canBackward** 
    #' 
    #' > Returns true if the current position in history is not the first value in history and if the length of history is greater than 1.
    #' 
    #'
    method canBackward {} {
        my variable index
        my variable history
        if {$index > 0} {
            return true
        } else {
            return false
        }
    }
    #' *cmd* **canFirst** 
    #' 
    #' > Returns true if the current position in history is not the first value in history and if history length is greater than 1.
    #'
    method canFirst {} {
        my variable index
        my variable history
        if {$index == 0} {
            return false
        } else {
            return true
        }
        
    }
    #' *cmd* **canForward** 
    #' 
    #' > Returns true if the current position in history is not the last value in history.
    #'
    method canForward {} {
        my variable index
        my variable history
        if {[llength $history] > [expr {$index+1}]} {
            return true
        } else {
            return false
        }
    }
    #' *cmd* **canLast** 
    #' 
    #' > Returns true if the current position in history is not the last value in history.
    #'
    method canLast {} {
        my variable index
        my variable history
        if {$index == [expr {[llength $history] -1}]} {
            return false
        } else {
            return true
        }
    }
    #' *cmd* **cget** *option*
    #' 
    #' > Retrieves the given option value for the oohistory object. Curently only the *-home* option is available for *cget*.
    #'
    #' *cmd* **configure** *option value ?option value ...?*
    #' 
    #' > Configures the given option for the oohistory object. Curently only the *-home* option is available for *configure*.
    #'
    #' *cmd* **current** 
    #' 
    #' > Retrieves the current value of the history.
    #'
    method current {} {
        my variable index
        my variable history
        return [lindex $history $index]
    }
    
    #' *cmd* **first** 
    #' 
    #' > Jumps to the first entry in history and returns it.
    #'
    method first {} {
        my variable index
        my variable history
        set index 0
        return [lindex $history $index]
    }
    #' *cmd* **forward** 
    #' 
    #' > Gos one step forward in history and returns the value there.
    #'
    method forward {} {
        my variable index
        my variable history
        # to check if possible
        incr index +1
        return [lindex $history $index]
    }
    #' *cmd* **getHistory** 
    #' 
    #' > Returns the history, a list of text entries.
    #'
    method getHistory {} {
        my variable history
        return $history
    }
    
    #' *cmd* **insert**  *value*
    #' 
    #' > Inserts the value in the history at the actual index.
    #'
    method insert {item} {
        my variable index
        my variable history
        set item [regsub {/$} $item ""]
        if {$item ne [lindex $history $index]} {
            incr index
            if {$item ne [lindex $history $index]} {
                #puts "index=$index $item"
                set history [linsert $history $index $item]
            } else {
                incr index -1
            }
        }
        return $item
    }
    
    #' *cmd* **home** 
    #' 
    #' > Returns the home index value which was set using the _-home_ option.
    #'
    method home {} {
        return $options(-home)
    }
    
    method resetHistory {} {
        set index -1
        set history [list]

    }
    #' *cmd* **last** 
    #' 
    #' > Jumps to the last value in history and returns the value there.
    #'
    method last {} {
        set index [llength $history]
        incr index -1
        return [lindex $history $index]
    }
}

package provide oohistory 0.4.0

#' 
#' ## <a name='example'>EXAMPLE</a>
#'
#' ```
#'  package require oohistory
#'  set sh [oohistory new -home h]
#'  $sh insert a
#'  $sh insert a ;# should not give duplicates
#'  $sh insert a
#'  $sh insert b
#'  puts "\ncanback: [$sh canBackward]"
#'  puts "canforw: [$sh canForward]"
#'  $sh back
#'  $sh insert z
#'  puts [$sh getHistory]
#'  puts [$sh home]
#'  puts "last: [$sh last]"
#' ```
#'
#' ## <a name='install'>INSTALLATION</a>
#'
#' Installation is easy, you can install and use this **oohistory** package folder
#' To use the **oohistory**  package then, you can either source the file oohistory.tcl or copy
#' or by copying the folder *oohistory* to a path belonging to your Tcl `$auto_path` variable.
#'
#' ## <a name='docu'>DOCUMENTATION</a>
#'
#' The script contains embedded the documentation in Markdown format. 
#' To extract the documentation you should use the following command line:
#'
#' ```
#' $ tclsh oohistory.tcl --man
#' ```
#'
#' The output of this command can be used to create a markdown document for conversion into a markdown 
#' document that can be converted thereafter into a html or pdf document. If, for instance, you have pandoc installed you could execute the following commands:
#'
#' ```
#' tclsh ../oohistory.tcl --man > oohistory.md
#' pandoc -i oohistory.md -s -o oohistory.html
#' ```
#' 
#' ## <a name='todo'>TODO</a>
#'
#' * github url for putting the code in its own package
#'
#' ## <a name='author'>AUTHOR</a>
#'
#' The **oohistory** command was written Detlef Groth, University of Potsdam, Germany.
#'
#' ## <a name='copyright'>COPYRIGHT</a>
#'
#' Copyright (c) 2019-24  Dr. Detlef Groth, E-mail: detlef(at)dgroth(dot)de
#'
#' ## <a name='license'>LICENSE</a>
#' 
#' oohistory package - data structure, a list of text entries 
#' which can be navigated as history, version __PKGVERSION__.
#'
#' Copyright (c) 2019-24  Detlef Groth, University of Potsdam, Germany
#' E-mail: dgroth(at)uni(minus)potsdam(dot)de
#' 
#' This library is free software; you can use, modify, and redistribute it
#' for any purpose, provided that existing copyright notices are retained
#' in all copies and that this notice is included verbatim in any
#' distributions.
#' 
#' This software is distributed WITHOUT ANY WARRANTY; without even the
#' implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#' 

if {[info exists argv0] && $argv0 eq [info script] && [regexp {oohistory} $argv0]} {
    set VERSION [package provide oohistory]
    if {[llength $argv] == 1 && [lindex $argv 0] eq "--version"} {    
        puts $VERSION
    } elseif {[llength $argv] == 1 && [lindex $argv 0] eq "--test"} {
        package require tcltest
        set argv [list] 
        tcltest::test dummy-1.1 {
            Calling my proc should always return a list of at least length 3
        } -body {
            set result 1
        } -result {1}
        tcltest::test history-1.1 {
            Starting a history
        } -body {
            set sh [oohistory new -home h]
            return [$sh home]
        } -result {h}
        tcltest::test history-1.2 {
            insert a value
        } -body {
            $sh insert a
            return [$sh current]
        } -result {a}
        tcltest::test history-1.3 {
            insert a value repeated
        } -body {
            $sh insert a
            $sh insert a
            $sh insert a
            llength [$sh getHistory]
        } -result {1}
        tcltest::test history-1.4 {
            can back with 1 item
        } -body {
             $sh canBackward
        } -result {false}
        tcltest::test history-1.5 {
            can back with 2 items
        } -body {
            $sh insert b
            $sh canBackward
        } -result {true}
        tcltest::test history-1.6 {
            can forward at the end?
        } -body {
            $sh canForward
        } -result {false}
        tcltest::test history-1.7 {
            can forward if going back?
        } -body {
            $sh back
            $sh canForward
        } -result {true}
        tcltest::test history-1.8 {
            insert in the middle
        } -body {
            $sh insert c
            $sh insert c
            $sh getHistory
        } -result {a c b}
        tcltest::test history-1.9 {
            check first
        } -body {
            $sh first
        } -result {a}
        tcltest::test history-1.10 {
            canBackward at first
        } -body {
            $sh canBackward
        } -result {false}
        tcltest::test history-1.11 {
            canForward at first
        } -body {
            $sh canForward
        } -result {true}
        tcltest::test history-1.12 {
            canForward at end
        } -body {
            $sh last
            $sh canForward
        } -result {false}
        tcltest::test history-1.13 {
            canBackward at last
        } -body {
            $sh canBackward
        } -result {true}
        tcltest::cleanupTests
    } elseif {[llength $argv] == 1 && ([lindex $argv 0] eq "--license")} {
        puts "MIT License"
    } elseif {[llength $argv] == 1 && ([lindex $argv 0] eq "--man")} {
        set filename [info script]
        if [catch {open $filename r} infh] {
            puts stderr "Cannot open $filename: $infh"
            exit
        } else {
            while {[gets $infh line] >= 0} {
                if {[regexp {^ *#' ?(.*)} $line -> line]} {
                    set line [regsub {__PKGVERSION__} $line $VERSION]
                    puts $line
                }
            }
            close $infh
        }
    } else {
        puts "\n    -------------------------------------"
        puts "     The [file rootname [file tail [info script]]] package $VERSION qfor Tcl"
        puts "    -------------------------------------\n"
        puts "Copyright (c) 2019-24  Detlef Groth, University of Potsdam, Germany"
        puts "              E-mail: dgroth(at)uni(minus)potsdam(dot)de\n"
        puts "License: MIT - License see manual page"
        puts "\nThe oohistory package provides a list with text entries which can used as" 
        puts "history data structure for programmers of the Tcl/Tk Programming language"
        puts ""
        puts "Usage: [info nameofexe] [info script] option\n"
        puts "    Valid options are:\n"
        puts "        --help    : printing out this help page"
        puts "        --test    : running some test code"
        puts "        --license : printing the license to the terminal"
        puts "        --man     : printing the man page in pandoc markdown to the terminal"
        puts "        --version : printing the package version to the terminal"        
        puts ""
        puts "    The --man option can be used to generate the documentation pages as well with"
        puts "    a command like: "
        puts ""
        puts "    tclsh [info script] --man | pandoc -t html -f Markdown -s > temp.html\n"
    }

}
