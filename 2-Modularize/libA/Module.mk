
LIBA_DIR := $(module_localdir)

SOURCES-y += $(addprefix $(LIBA_DIR)/, \
	liba.c \
	liba_asm.s \
	)
	
	
INCLUDES-y += $(LIBA_DIR)

# Each module can modify the various flags
CPPFLAGS += -DBUILD_LIBA=1
