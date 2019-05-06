# meet_your_MakeR
Basic and highly addoptive Makefile basis for developing/debugging/profiling C-based projects

This Makefile contains special mk-configs and lots of stuff
# DEFAULTS:
	Compile using gcc;
	CFLAGS is -Wall -Wextra -Werror
	Traversing through working directory and building all libraries which has been placed within "libraries" dir
	Adds "includes" dir and corresponding includes from the libraries to default compiler inc-searching directories
	Outgoing project title is named after current directory. Yep, officially kinda.
		If working directory name corresponds to "*lib" pattern - project will create static library

# BUILDS:
	You can add specific sources to directories "Release"/"Debug"
	When make detects BUILD variable value as "RELEASE" or "DEBUG" - it automaticly add sources from corresponding directory
	to sources list. You should use one of this values as toggler. Combining both of them together is unexpected condition
	
# FLAGS:

