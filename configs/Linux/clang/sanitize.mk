define newline


endef

ASAN	?=

define sanitize_flags_CLANG=
undefined,
shift,
shift-exponent,
shift-base,
integer-divide-by-zero,
unreachable,
vla-bound,
null,
signed-integer-overflow,
bounds,
alignment,
float-divide-by-zero,
float-cast-overflow,
nonnull-attribute,
returns-nonnull-attribute,
bool,
enum,
pointer-overflow,
builtin
endef

# MSAN_OPTIONS=poison_in_dtor=1 - extreme memory uninitialized values detection flag
# Add before execution of the compiled app

PROJ_CFLAGS	+=	-g3 -Og \
				-fno-omit-frame-pointer \
				-fno-optimize-sibling-calls
				

ifeq ($(ASAN),)
	PROJ_CFLAGS	+=	-fsanitize="$(subst $(newline),,${sanitize_flags_CLANG})"
else ifeq ($(ASAN),ADDRESS)
	PROJ_CFLAGS	+=	-fsanitize="address"
else ifeq ($(ASAN),MEMORY)
	PROJ_CFLAGS	+=	-fsanitize="memory" \
				-fsanitize-memory-track-origins \
				-fsanitize-memory-use-after-dtor
else ifeq ($(ASAN),THREAD)
	PROJ_CFLAGS	+=	-fsanitize="thread" -fPIE
endif
