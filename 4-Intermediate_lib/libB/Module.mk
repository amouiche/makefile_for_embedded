

LIBB_DIR := $(module_localdir)

INTERMEDIATE_LIBS += libB


libB_SOURCES-y += $(LIBB_DIR)/libb.c
libB_SOURCES-y += $(LIBB_DIR)/common_filename.c

INCLUDES-y += $(LIBB_DIR)


# common_function_name() function exists in libA and libC.
# In both cases, they are internal function.
# libA deal with this by making 'common_function_name' local to the lib.
# Another way exposed here is to make to localized every symbol of the lib
# expect the one of the lib API (eg. libb_bar) we want to export.
# (see 'man objcopy')
libB_OBJCOPYFLAGS = --wildcard '--localize-symbol=!libb_bar' '--localize-symbol=*'
