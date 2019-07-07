
#
# Recursive wildcart function for finding all folders/files
#     $1 - starting folder
#     $2 - file/pattern
#

rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))



#
# Function for triming directories from files
#     $1 - starting folder
#

directory_only=$(sort $(dir $(wildcard $1)))



#
# Function for removing repeating words from a string
#     $1 - input string
#

unique_str = $(if $1,$(firstword $1) $(call unique_str,$(filter-out $(firstword $1),$1)))
