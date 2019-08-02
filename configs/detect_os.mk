
#
# OS detecting routines
#

OS_DETECT	?=

OS_LINUX	:=	Linux
OS_OSX		:=	Darwin
OS_WINDOWS	:=	Windows

OS_LIST		:=	$(OS_LINUX) \
				$(OS_OSX) \
				$(OS_WINDOWS)

ifeq ($(OS),Windows_NT)
	OS_DETECT	:= $(OS_WINDOWS)
else ifeq ($(origin OS), undefined)
	OS_DETECT	:= $(shell sh -c 'uname 2>/dev/null || echo Unknown')
endif

ifeq ($(OS_DETECT),$(OS_LINUX))
	
else ifeq ($(OS_DETECT),$(OS_OSX))

else ifeq ($(OS_DETECT),$(OS_WINDOWS))

else
	OS_DETECT	:=	$(error)
endif

OS_NOT_CURRENT	:=	$(filter-out $(OS_DETECT),$(OS_LIST))
