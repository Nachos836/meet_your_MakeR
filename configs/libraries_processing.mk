#
# Processing library dir and finding corresponding libraries
#

LIBRARIES_DIR	?=	$(dir $(wildcard $(CURDIR)/libraries/))
ifeq ($(LIBRARIES_DIR),)
	LIBRARIES_DIR	:= $(error)
endif
LIBRARIES_DIR	:= $(patsubst %/,%,$(LIBRARIES_DIR))

LIBS_LIST		?=	$(wildcard $(LIBRARIES_DIR)/lib*/Makefile)
ifeq ($(LIBS_LIST),)
	LIBS_LIST	:= $(error)
endif

LIBS_NAMES		?=	$(subst $(CURDIR)/libraries/lib,,$(LIBS_LIST))
LIBS_NAMES		:=	$(subst /Makefile,,$(LIBS_NAMES))
ifeq ($(LIBS_NAMES),)
	LIBS_NAMES	:=	$(error)
endif
