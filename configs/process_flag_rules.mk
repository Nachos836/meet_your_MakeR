
# Making specifics corrections to basic compiling rules via toggling flags

FLAG		?=	NONE
DB			:=	lldb
P_FUNCTION	?=

ifeq (WARNINGS,$(findstring WARNINGS,$(strip $(FLAG))))
	include	$(CURDIR)/configs/$(OS_DETECT)/$(PROJ_CC)/warnings.mk
	PROJ_CFLAGS	+=	-D PROJECT__WARNINGS
endif
ifeq (OPTIMIZE,$(findstring OPTIMIZE,$(strip $(FLAG))))
	include	$(CURDIR)/configs/$(OS_DETECT)/$(PROJ_CC)/optimize.mk
	PROJ_CFLAGS	+=	-D PROJECT__OPTIMIZE
endif
ifeq (SANITIZE,$(findstring SANITIZE,$(strip $(FLAG))))
	include	$(CURDIR)/configs/$(OS_DETECT)/$(PROJ_CC)/sanitize.mk
endif
ifeq (DEBUG,$(findstring DEBUG,$(strip $(FLAG))))
	include	$(CURDIR)/configs/$(OS_DETECT)/$(PROJ_CC)/debug.mk
	PROJ_CFLAGS	+=	-D PROJECT__DEBUG
endif
ifeq (PROFILE,$(findstring PROFILE,$(strip $(FLAG))))
	include	$(CURDIR)/configs/$(OS_DETECT)/$(PROJ_CC)/profile.mk
	ifeq ($(OS_DETECT),$(OS_WINDOWS))
		P_OUT		:=	nul
		P_OUT_FLAGS	:=
	else ifeq ($(OS_DETECT),$(OS_LINUX))
		PROF		:=	gprof
		PROF_FLAGS	:=	-b -a
		ifneq ($(P_FUNCTION),)
			PROF_FLAGS	+= -q$(P_FUNCTION)
		endif
		P_OUT		:=	/dev/null
		P_OUT_FLAGS	:=	2>&1
	endif
endif
ifeq (NONE,$(findstring NONE,$(strip $(FLAG))))
	PROJ_CFLAGS		+=	-Wall -Wextra -Werror
endif
