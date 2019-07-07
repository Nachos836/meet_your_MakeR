include $(CURDIR)/configs/detect_os.mk

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
NAME		?=	$(notdir $(CURDIR))
BUILD		?=	VANILLA
OBJECTS_DIR	:=	$(CURDIR)/objects

INCLUDES_DIR	?=	$(dir $(wildcard $(CURDIR)/includes/))
ifeq ($(INCLUDES_DIR),)
	INCLUDES_DIR	:= $(CURDIR)
endif

ifneq (,$(findstring lib,$(NAME)))
	LIB_DETECT	:=	$(NAME)
	NAME		:=	$(addsuffix .a,$(NAME))
endif

SOURCES_DIR	?=	$(dir $(wildcard $(CURDIR)/sources/))
ifeq ($(SOURCES_DIR),)
	SOURCES_DIR	:= $(CURDIR)
endif

INCLUDES	:= $(call unique_str,$(dir $(call rwildcard,$(INCLUDES_DIR),*.h)))
SOURCES		:= $(call rwildcard,$(SOURCES_DIR),*.c)
OBJECTS		:= $(patsubst $(SOURCES_DIR)%.c,$(OBJECTS_DIR)//%.o,$(SOURCES))

# $(info INCLUDES: $(INCLUDES))
# $(info SOURCES: $(SOURCES))
# $(info OBJECTS: $(OBJECTS))

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
