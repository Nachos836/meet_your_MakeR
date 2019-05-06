
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
