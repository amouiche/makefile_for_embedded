
LIBA_DIR := $(module_localdir)


# set to y or n to select assembler or C implementation for liba_add()
LIBA_BUILD_ASM?=y



SOURCES-y += $(LIBA_DIR)/liba.c
SOURCES-$(LIBA_BUILD_ASM) += $(LIBA_DIR)/liba_asm.s
	
	
INCLUDES-y += $(LIBA_DIR)

# Each module can modify the various flags
ifeq ($(LIBA_BUILD_ASM),y)
CPPFLAGS += -DLIBA_BUILD_ASM=1
endif
