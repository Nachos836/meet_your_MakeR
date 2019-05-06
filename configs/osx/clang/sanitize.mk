
CFLAGS	+=	-g3 \
			-fno-omit-frame-pointer

ifeq ($(ASAN),)
	CFLAGS	+=	-fsanitize="undefined,shift,shift-exponent,shift-base,integer-divide-by-zero,unreachable,vla-bound,null,signed-integer-overflow,bounds,alignment,float-divide-by-zero,float-cast-overflow,nonnull-attribute,returns-nonnull-attribute,bool,enum,pointer-overflow,builtin"
else ifeq ($(ASAN),LEAKS)
	CFLAGS	+=	-fsanitize="address"
endif
