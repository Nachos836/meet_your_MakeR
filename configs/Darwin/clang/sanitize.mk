
PROJ_CFLAGS	+=	-g3 \
				-fno-omit-frame-pointer

ifeq ($(ASAN),)
	PROJ_CFLAGS	+=	-fsanitize="undefined,shift,shift-exponent,shift-base,integer-divide-by-zero,unreachable,vla-bound,null,signed-integer-overflow,bounds,alignment,float-divide-by-zero,float-cast-overflow,nonnull-attribute,returns-nonnull-attribute,bool,enum,pointer-overflow"
else ifeq ($(ASAN),ADDRESS)
	PROJ_CFLAGS	+=	-fsanitize="address"
else ifeq ($(ASAN),THREAD)
	PROJ_CFLAGS	+=	-fsanitize="thread" -fPIE
endif
