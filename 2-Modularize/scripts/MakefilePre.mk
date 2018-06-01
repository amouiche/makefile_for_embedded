

SOURCES-y :=
INCLUDES-y :=


# provide "$(module_localdir)" to return the current relative directory from this Makefile
# Must not be called after using "include" to source another makefile, otherwise it returns an erroneous value
module_localdir = $(patsubst %/,%,$(dir $(lastword $(MAKEFILE_LIST))))
