
#
# OS detecting routines
#

OS_DETECT	?=

ifeq ($(OS),Windows_NT)
	OS_DETECT	:= Windows
else ifeq ($(origin OS), undefined)
	OS_DETECT	:= $(shell sh -c 'uname 2>/dev/null || echo Unknown')
endif

ifeq ($(OS_DETECT),Linux)
	OS_DETECT	:=	linux
else ifeq ($(OS_DETECT),Darwin)
	OS_DETECT	:=	osx
else ifeq ($(OS_DETECT),Windows)
	OS_DETECT	:=	win32
else
	OS_DETECT	:=	$(error)
endif
