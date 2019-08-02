#
# Some of often using variables for producing info logs
#

comma	?=	,
empty	?=
space	?=	$(empty) $(empty)
tab		?=	$(empty)	$(empty)
enter	?=	$(space) \
$(space)
error	?=	ERROR

define newline


endef

COM_COLOR   ?= \033[0;34m
NAME_COLOR  ?= \033[1;35m
OBJ_COLOR   ?= \033[0;36m
OK_COLOR    ?= \033[0;32m
ERROR_COLOR ?= \033[0;31m
WARN_COLOR  ?= \033[0;33m
NO_COLOR    ?= \033[m

OK_STRING    ?= "[OK]"
ERROR_STRING ?= "[ERROR]"
WARN_STRING  ?= "[WARNING]"
COM_STRING   ?= "[COMPILING]"

#
#	@printf "%b %b %*b\n" \
# 	"$(COM_COLOR)$(COM_STRING)" \
# 	"$(OBJ_COLOR)$(notdir $@)$(NO_COLOR)" \
# 	40 "$(WARN_COLOR)|$(FLAG)-BUILD|$(NO_COLOR)";
#
