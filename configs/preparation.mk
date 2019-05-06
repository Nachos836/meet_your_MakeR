include $(CURDIR)/configs/common_variables.mk
include $(CURDIR)/configs/detect_os.mk

PROJ_CFLAGS	:=
PROJ_CC		:=	gcc

OS_DETECT	?=	$(error)
NAME		?=	$(notdir $(CURDIR))
BUILD		?=	VANILA
OBJECTS_DIR	:=	$(CURDIR)/objects/

INCLUDE_DIR	?=	$(dir $(wildcard $(CURDIR)/includes/))
ifeq ($(INCLUDE_DIR),)
	INCLUDE_DIR	:= $(CURDIR)
endif

ifneq (,$(findstring lib,$(NAME)))
	LIB_DETECT	:=	$(NAME)
	NAME		:=	$(addsuffix .a,$(NAME))
endif

SOURCES_DIR	?=	$(dir $(wildcard $(CURDIR)/sources/))
ifeq ($(SOURCES_DIR),)
	SOURCES_DIR	:= $(CURDIR)
endif

ifeq ($(BUILD),VANILLA)
	SOURCES_VERSION_DIR	?=
else ifeq ($(BUILD),DEBUG)
	CFLAGS	+=	-D BUILD__DEBUG
	SOURCES_VERSION_DIR	:= $(dir $(wildcard $(SOURCES_DIR)debug/))
else ifeq ($(BUILD),RELEASE)
	SOURCES_VERSION_DIR	:= $(dir $(wildcard $(SOURCES_DIR)release/))
endif

SOURCES			:=	$(notdir $(wildcard $(SOURCES_DIR)*c))
SOURCES_VERSION	:=	$(notdir $(wildcard $(SOURCES_VERSION_DIR)*c))

OBJ		:=	$(addprefix $(OBJECTS_DIR),$(SOURCES:.c=.o))
OBJ		+=	$(addprefix $(OBJECTS_DIR),$(SOURCES_VERSION:.c=.o))
