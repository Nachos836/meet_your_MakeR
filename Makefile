include $(CURDIR)/configs/functions.mk
include $(CURDIR)/configs/preparation.mk
include $(CURDIR)/configs/libraries_processing.mk

include $(CURDIR)/configs/process_flag_rules.mk
include $(CURDIR)/configs/create_compile_rules.mk

include $(CURDIR)/configs/MODIFIERS.mk

all:
ifdef CLEAR
	@$(CLEAR)
endif
	@mkdir -p $(OBJECTS_DIR)
ifneq ($(LIBS_NAMES),$(error))
	$(MAKE_LIBS)
endif
	@$(MAKE) $(NAME) --no-print-directory

$(OBJECTS_DIR)%.o:$(SOURCES_DIR)%.c
	@$(info [COMPILING] $(notdir $<))
	@$(PROJ_CC) $(COMPILE_OBJ_RULE) -o $@ -c $<

$(OBJECTS_DIR)%.o:$(SOURCES_VERSION_DIR)%.c
	@$(info [COMPILING] $(notdir $<))
	@$(PROJ_CC) $(COMPILE_OBJ_RULE) -o $@ -c $<

$(NAME):
	@$(info [CREATING]	$@	[$(BUILD)-$(FLAG)])
	@$(MAKE) -j $(OBJ)
ifeq ($(LIB_DETECT).a,$(NAME))
	@ar rc $(NAME) $(OBJ)
	@ranlib $(NAME)
else
	@$(PROJ_CC) $(OBJ) $(COMPILE_APP_RULE) -o $(NAME)
endif
ifeq ($(LIB_DETECT),$(error))
ifeq (DEBUG,$(findstring DEBUG,$(strip $(FLAG))))
	@$(DB) $(NAME)
endif
ifeq (PROFILE,$(findstring PROFILE,$(strip $(FLAG))))
	@./$(NAME) > $(P_OUT) $(P_OUT_FLAGS)
	@$(PROF) $(PROF_FLAGS) $(NAME)
endif
endif

clean:
	@$(info [REMOVING] $(OBJECTS_DIR))
	@rm -rf $(OBJECTS_DIR)

fclean: clean
	@$(info [REMOVING] $(NAME))
	@rm -rf $(NAME)

re:
	@$(info [REWORKING])
	@$(MAKE) fclean --no-print-directory
	@$(MAKE) all --no-print-directory

re_libs:
	@$(RE_LIBS)

fclean_libs:
	@$(FCLEAN_LIBS)

re_all:
	@$(MAKE) -j re_libs --no-print-directory
	@$(MAKE) re --no-print-directory

fclean_all:
	@$(MAKE) -j fclean_libs --no-print-directory
	@$(MAKE) fclean
