
ifeq ($(OS_DETECT),$(OS_LINUX))
	MKDIR		:= mkdir -p
	RMDIR		:= rm -rf
	RMFILE		:= rm -f
else ifeq ($(OS_DETECT),$(OS_OSX))
	MKDIR		:= mkdir -p
	RMDIR		:= rm -rf
	RMFILE		:= rm -f
else ifeq ($(OS_DETECT),$(OS_WINDOWS))
	MKDIR		:= mkdir
	RMDIR		:= rmdir /s /q
	RMFILE		:= del
else
	MKDIR		:= $(error)
	RMDIR		:= $(error)
	RMFILE		:= $(error)
endif

PROJ_CFLAGS	:=
PROJ_CC		:=	gcc

OS_DETECT	?=	$(error)
LIB_DETECT	?=	$(error)
NAME		?=	$(notdir $(CURDIR))
BUILD		?=	VANILLA
OBJECTS_DIR	:=	$(CURDIR)/objects

INCLUDES_DIR	?=	$(dir $(wildcard $(CURDIR)/includes/))
ifeq ($(INCLUDES_DIR),)
	INCLUDES_DIR	:= $(CURDIR)/
endif
INCLUDES_DIR	:= $(patsubst %/,%,$(INCLUDES_DIR))

ifneq (,$(findstring lib,$(NAME)))
	LIB_DETECT	:=	$(NAME)
	NAME		:=	$(addsuffix .a,$(NAME))
endif

SOURCES_DIR	?=	$(dir $(wildcard $(CURDIR)/sources/))
ifeq ($(SOURCES_DIR),)
	SOURCES_DIR	:= $(CURDIR)/
endif
SOURCES_DIR	:= $(patsubst %/,%,$(SOURCES_DIR))

INCLUDES	:= $(strip $(call unique_str,$(dir $(call rwildcard,$(INCLUDES_DIR),*.h))))
SOURCES		:= $(strip $(call rwildcard,$(SOURCES_DIR)/,*.c))

ifneq ($(OS_DETECT),$(error))
ifeq ($(OS_DETECT),$(OS_LINUX))
SOURCES	:=	$(filter-out $(SOURCES_DIR)/$(OS_WINDOWS)/%,$(SOURCES))
SOURCES	:=	$(filter-out $(SOURCES_DIR)/$(OS_OSX)/%,$(SOURCES))
OBJECTS	:= $(strip $(patsubst $(SOURCES_DIR)/%.c,$(OBJECTS_DIR)/%.o,$(SOURCES)))
endif
ifeq ($(OS_DETECT),$(OS_OSX))
SOURCES	:=	$(filter-out $(SOURCES_DIR)/$(OS_WINDOWS)/%,$(SOURCES))
SOURCES	:=	$(filter-out $(SOURCES_DIR)/$(OS_LINUX)/%,$(SOURCES))
OBJECTS	:= $(strip $(patsubst $(SOURCES_DIR)/%.c,$(OBJECTS_DIR)/%.o,$(SOURCES)))
endif
ifeq ($(OS_DETECT),$(OS_WINDOWS))
SOURCES	:=	$(filter-out $(SOURCES_DIR)/$(OS_OSX)/%,$(SOURCES))
SOURCES	:=	$(filter-out $(SOURCES_DIR)/$(OS_LINUX)/%,$(SOURCES))
OBJECTS	:= $(strip $(patsubst $(SOURCES_DIR)/%.c,$(OBJECTS_DIR)/%.o,$(SOURCES)))
endif
endif

# ifeq ($(BUILD),VANILLA)
# 	SOURCES_VERSION_DIR	?=
# else ifeq ($(BUILD),DEBUG)
# 	CFLAGS	+=	-D BUILD__DEBUG
# 	SOURCES_VERSION_DIR	:= $(dir $(wildcard $(SOURCES_DIR)debug/))
# else ifeq ($(BUILD),RELEASE)
# 	SOURCES_VERSION_DIR	:= $(dir $(wildcard $(SOURCES_DIR)release/))
# endif




# SOURCES			:=	$(notdir $(wildcard $(SOURCES_DIR)*c))
# SOURCES_VERSION	:=	$(notdir $(wildcard $(SOURCES_VERSION_DIR)*c))

# OBJ		:=	$(addprefix $(OBJECTS_DIR),$(SOURCES:.c=.o))
# OBJ		+=	$(addprefix $(OBJECTS_DIR),$(SOURCES_VERSION:.c=.o))
