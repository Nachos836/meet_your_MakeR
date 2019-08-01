define newline


endef

ASAN	?=

define address_sanitize_flags=
address,
pointer-compare,
pointer-subtract
endef

define sanitize_flags=
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
bounds-strict,
alignment,
object-size,
float-divide-by-zero,
float-cast-overflow,
nonnull-attribute,
returns-nonnull-attribute,
bool,
enum,
vptr,
pointer-overflow,
builtin
endef

PROJ_CFLAGS	+=	-g3 \
				-fno-omit-frame-pointer \
				-fno-merge-debug-strings

ifeq ($(ASAN),)
	PROJ_CFLAGS	+=	-fsanitize="$(subst $(newline),,${sanitize_flags})"
else ifeq ($(ASAN),ADDRESS)
	PROJ_CFLAGS	+=	-fsanitize="$(subst $(newline),,${address_sanitize_flags})"
else ifeq ($(ASAN),THREAD)
	PROJ_CFLAGS	+=	-fsanitize="thread" -fPIE -pie
endif
