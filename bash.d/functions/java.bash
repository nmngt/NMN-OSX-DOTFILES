# ----------------------------------------------------------------------------
#  BASH: Functions - JAVA
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} JAVA Helper" ${BASH_SOURCE}

if [ -x "/usr/libexec/java_home" ]; 
then
	# Set JAVA HOME
	#export JAVA_HOME=$(/usr/libexec/java_home)

	# Java Switcher -> 6
	function iwant_java6 
	{
	    export JAVA_HOME=$(/usr/libexec/java_home -v 1.6)
	}

 	# Java Switcher -> 7
	function iwant_java7 
	{
	    export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)
	}

	# Java Switcher -> 8
	function iwant_java8 
	{
	    export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
	}

fi