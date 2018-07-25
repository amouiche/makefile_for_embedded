
LIBA_DIR := $(module_localdir)


# set to y or n to select assembler or C implementation for liba_add()
LIBA_BUILD_ASM?=y


INTERMEDIATE_LIBS += libA


# list of input files required to build libA
libA_SOURCES-y += $(LIBA_DIR)/liba.c
libA_SOURCES-y += $(LIBA_DIR)/src/common_filename.c
libA_SOURCES-$(LIBA_BUILD_ASM) += $(LIBA_DIR)/src/liba_asm.s
	

# append INCLUDES-y so the whole project can find libA headers
INCLUDES-y += $(LIBA_DIR)

# Internal includes path when building libA sources
# Not used when building the remaining of the project.
libA_INCLUDES-y += $(LIBA_DIR)/src


# Each module can modify the various flags.
ifeq ($(LIBA_BUILD_ASM),y)
# Here, -DLIBA_BUILD_ASM=1 is append to gcc options only when building libA.
# Remain build operation of the project are not affected.
libA_CPPFLAGS += -DLIBA_BUILD_ASM=1
endif


# common_function_name() function exists in libA and libC.
# In both cases, they are internal function.
# The most simple way to avoid the name collision when linking the project
# is to make those kind of function local to the intermediate lib
# (ie. not exported to the remain part of the project).
libA_OBJCOPYFLAGS = --localize-symbol=common_function_name