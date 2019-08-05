# meet_your_MakeR
Basic and highly addoptive Makefile basis for developing/debugging/profiling C-based projects

Thus Makefile contains special mk-configs and lots of stuff
___
## DEFAULTS:
* Compile using gcc;
* CFLAGS is -Wall -Wextra -Werror (called PROJ_CFLAGS)
* Traversing through working directory and building all libraries which has been placed within "libraries" dir
* Adds "includes" dir and corresponding includes from the libraries to default compiler inc-searching directories
* Outgoing project title is named after current directory.
> Yep, officially kinda. Also if working directory name corresponds to "*lib" pattern - project will create static library
* Sources compiling in separeted threads
* Rules processing and preparetions are recursively processed by subcalls of Make

## BUILDS: (set BUILD variable)
> Temporarily unavailable
* You can add specific sources to directories "Release"/"Debug"
* When make detects BUILD variable value as "RELEASE" or "DEBUG" - it automaticly add sources from corresponding directory
to sources list. You should use one of this values as toggler. Combining both of them together is unexpected condition
> Directories "release" and "debug" should be placed in "sources" directory and named in lowercase

## FLAGS: (set FLAG variable)
* **DEBUG** - adds basic debug flags to project and initialize debugger instance with current app immediatly after making
  * Undefined behaviour when making libraries
  * Works standalone, no need to add afterwards instructions in command prompt to start debugging
* **OPTIMIZE** -adds lots of optimization flags
  * Designed to monitor code behaviour when using all of the available optimizations in gcc
  * Safe to use with clang for now due to vanilla optimizations only - work in progress
* **WARNINGS** - turns on litteruly almost all of the available error flags in compiler
  * Warns even in std headers
  * Better way to combine thus flag with "#pragmas"
* **SANITIZE** - turns on an code sanitizer at all avaliable levels
  * Have extra flag "ASAN" (ADDRESS|MEMORY|THREAD|just blank)
  * ADDRESS - Produses address sanitize (for gcc & clang)
  * MEMORY - Produses memory sanitize (clang only)
  * THREAD - Produses thread sanitize (for gcc & clang)
  * (leave blank) - Produces undefined behaviour sanitize (for gcc & clang)
> MacOS support is very poor becouse of clang-build restrictions

## MODIFIERS: (MODIFIERS.mk file in "configs" directory)
* MODIFIERS.mk may be used in order to set some specific flags, create build configs, modify exsisting variables values
  * This file is included in Makefile at the very ending of all preparations and rules settings
> By default contains flag which clears terminal. If this flag is not appear in this file, clearing will not happens

## HOW TO
___
* `make`
  * simple make current target
* `make PROJ_CC=clang re`
  * rebuild current target with clang compiler
* `make ASAN=ADDRESS PROJ_CC=gcc FLAG=WARNINGS,SANITIZE re`
  * rebuild current target with gcc compiler, add all warnings flags and sanitizer flags with memory leaks detection
* `make BUILD=DEBUG FLAG=DEBUG re`
> Temporarily unavailable
  * rebuild current target with "debug" sources added and then start lldb instance for current target
* `make FLAG=SANITIZE re_libs`
  * rebuild all libs in current project with undefined behaviour sanitize and then start lldb instance for current target
