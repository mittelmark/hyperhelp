

help:
	cd hyperhelp && pantcl hyperhelp.tcl hyperhelp.html  -s --css mini.css
	cd hyperhelp && htmlark hyperhelp.html -o hyperhelp-out.html 
	mv hyperhelp/hyperhelp-out.html hyperhelp/hyperhelp.html 
	
