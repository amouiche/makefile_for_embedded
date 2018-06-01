
# Initialize flags, sources and includes.


LDFLAGS  :=
CFLAGS   :=
CXXFLAGS :=
CPPFLAGS := 
ASFLAGS  :=

# Prefer SOURCES-y to SOURCES
# It makes easy to user configuration items
# ex:
#    CONFIG_FOO=y
#    CONFIG_BAR=n
#    [...]
#    SOURCES-$(CONFIG_FOO) += foo.c    # <= build
#    SOURCES-$(CONFIG_BAR) + bar.c     # <= not build
#
SOURCES-y :=
INCLUDES-y :=


# provide "$(module_localdir)" to return the current relative directory from this Makefile
# Must not be called after using "include" to source another makefile, otherwise it returns an erroneous value
# usage:
#     MY_LOCAL_DIR := $(module_localdir)
#     [...]
#     SOURCES-y += $(MY_LOCAL_DIR)/foo.c
#
module_localdir = $(patsubst %/,%,$(dir $(lastword $(MAKEFILE_LIST))))


# Useful helpers for config evaluation
# usage: SOURCES-$(not_$(CONFIG_FOO)) += foo.c
#        SOURCES-$($(CONFIG_FOO)_or_$(CONFIG_BAR)) += bar.c

not_n   := y
not_    := y

y_or_y  := y
n_or_y  := y
 _or_y  := y
y_or_n  := y
y_or_   := y

y_and_y := y
