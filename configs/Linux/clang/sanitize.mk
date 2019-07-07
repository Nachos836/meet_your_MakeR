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

PROJ_CFLAGS	+=	-g3 \
				-fno-omit-frame-pointer

ifeq ($(ASAN),)
	PROJ_CFLAGS	+=	-fsanitize="$(subst $(newline),,${sanitize_flags_CLANG})"
else ifeq ($(ASAN),LEAKS)
	PROJ_CFLAGS	+=	-fsanitize="memory"
endif
