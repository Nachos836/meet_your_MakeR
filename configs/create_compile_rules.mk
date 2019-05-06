#
# This routines creates specific subrules to compile an app with corresponding libs
#

PROJ_CFLAGS		?=
INCLUDE_DIR		?=
LIBS_NAMES		?=
LIBRARIES_DIR	?=

ifndef (space)
	empty	:=
	space	:=	$(empty) $(empty)
endif

COMPILE_OBJ_RULE	?=	$(PROJ_CFLAGS) \
					$(addprefix -I,"$(INCLUDE_DIR)")
ifneq ($(LIBS_NAMES),$(error))
	COMPILE_OBJ_RULE += $(foreach lib,\
							$(LIBS_NAMES),\
							$(addprefix -I,"$(LIBRARIES_DIR)lib$(lib)/includes/"))
endif

COMPILE_APP_RULE	?=	$(PROJ_CFLAGS) \
						$(addprefix -I,"$(INCLUDE_DIR)")
ifneq ($(LIBS_NAMES),$(error))
	COMPILE_APP_RULE	+=	$(foreach lib,\
							$(LIBS_NAMES),\
							$(addprefix -I,"$(LIBRARIES_DIR)lib$(lib)/includes/"))
	COMPILE_APP_RULE	+=	$(foreach lib,\
							$(LIBS_NAMES),\
							$(addprefix -L,"$(LIBRARIES_DIR)lib$(lib)/"))
	COMPILE_APP_RULE	+=	$(foreach lib,\
							$(LIBS_NAMES),\
							$(addprefix -l,$(lib)))
endif

ifneq ($(LIBS_NAMES),$(error))
	MAKE_LIBS	?=	$(foreach lib,\
			$(LIBS_NAMES),\
			$(MAKE)$(space)-C"$(LIBRARIES_DIR)lib$(lib)"$(space)--no-print-directory$(newline))
	FCLEAN_LIBS	?=	$(foreach lib,\
			$(LIBS_NAMES),\
			$(MAKE)$(space)-C"$(LIBRARIES_DIR)lib$(lib)"$(space)fclean$(space)--no-print-directory$(newline))
	RE_LIBS		?=	$(foreach lib,\
			$(LIBS_NAMES),\
			$(MAKE)$(space)-C"$(LIBRARIES_DIR)lib$(lib)"$(space)re$(space)--no-print-directory$(newline))
endif
