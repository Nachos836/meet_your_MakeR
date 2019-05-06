define newline


endef

ASAN	?=

define address_sanitize_flags=
address,
pointer-compare,
pointer-subtract,
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

# CFLAGS	+=	-g3 \
# 			-fno-omit-frame-pointer \
# 			-fno-merge-debug-strings \
# 			-fsanitize="$(subst $(newline),,${sanitize_flags})" \
# 			-fsanitize-address-use-after-scope \
# 			-fsanitize-undefined-trap-on-error \
# 			-fsanitize-coverage="trace-cmp" \

CFLAGS	+=	-g3 \
			-fno-omit-frame-pointer \
			-fno-merge-debug-strings

ifeq ($(ASAN),)
	CFLAGS	+=	-fsanitize="$(subst $(newline),,${sanitize_flags})"
else ifeq ($(ASAN),LEAKS)
	CFLAGS	+=	-fsanitize="$(subst $(newline),,${address_sanitize_flags})"
endif