

# add INCLUDES directory to CPPFLAGS
CPPFLAGS += $(addprefix -I,$(INCLUDES-y))


# if VERBOSE is not defined, don't display the complete gcc command line, but only 'CC  foo.c'
# run 'VERBOSE=1 make' to build the project with details.
ifeq ($(VERBOSE),)
HIDECMD=@
else
HIDECMD=
endif






# build the object files to build from sources
# If the project is organized the following way.
#
# /home/user/xxx/yyy/PROJECT_ROOT
#                        +-- project
#                        |      +-- Makefile
#                        +-- scripts
#                        |      +-- MakefilePost.mk   (this file)
#                        +-- libA
#                               +-- liba.c
# For source ../liba/liba.c (abspath /home/user/xxx/yyy/PROJECT_ROOT/libA/liba.c
# we will build 
#            $(BUILDDIR)//home/user/xxx/yyy/PROJECT_ROOT/libA/liba.o
#
# This way 'make', for the rule 
#    $(BUILDDIR)/%.o: %.c
#
# we have '%.o' = '/home/user/xxx/yyy/PROJECT_ROOT/libA/liba.o'
# and make will easily find 'liba.c' inside /home/user/xxx/yyy/PROJECT_ROOT/libA
# without even requiring a VPATH indication.

OBJS = $(addprefix $(BUILDDIR)/,$(abspath $(addsuffix .o,$(basename $(sort $(SOURCES-y))))))


# Source headers dependencies to know when it is required to rebuild some objects when headers are modified.
# main.d & co files were created the previous time we run the makefile
include $(wildcard $(addsuffix .d,$(basename $(OBJS))))

# Uncomment following line to debug to build object list
#$(warning OBJS = $(OBJS))


# generic rules for build and generating dependency list
$(BUILDDIR)/%.o: %.c
	@mkdir -p $(@D)
	@test -z "$(HIDECMD)" || echo "  CC    $<"
	$(HIDECMD) $(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@ -MMD -MP
	
$(BUILDDIR)/%.o: %.cxx
	@mkdir -p $(@D)
	@test -z "$(HIDECMD)" || echo "  CXX   $<"
	$(HIDECMD) $(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@ -MMD -MP
	
$(BUILDDIR)/%.o: %.s
	@mkdir -p $(@D)
	@test -z "$(HIDECMD)" || echo "  AS    $<"
	$(HIDECMD) $(AS) $(ASFLAGS) -c $< -o $@







# Create some special rules Template to build libs listed in INTERMEDIATE_LIBS
# to build a library named 'foo', each Module should define
#    - INTERMEDIATE_LIBS += foo
#    - foo_SOURCES = [list of files to build]
#    - foo_[C|CXX|CPP|AS]FLAGS = [special flags for building the sources of foo]
#    - foo_LDFLAGS = [additional flags to build the intermediate library object (see 'ld -r')
#    - foo_OBJCOPYFLAGS = [optional objcopy operation flags to perform on the resulting library]
define INTERMEDIATE_LIB_BUILD_EVAL

INTERMEDIATE_LIB_OBJS := $(addprefix $(BUILDDIR)/,$(abspath $(addsuffix .o,$(basename $(sort $($(libname)_SOURCES-y))))))

include $$(wildcard $$(addsuffix .d,$$(basename $$(INTERMEDIATE_LIB_OBJS)))) # source dependencies informations

# Target specific variables
$$(INTERMEDIATE_LIB_OBJS): CFLAGS   += $$($(libname)_CFLAGS)
$$(INTERMEDIATE_LIB_OBJS): CXXFLAGS += $$($(libname)_CXXFLAGS)
$$(INTERMEDIATE_LIB_OBJS): ASFLAGS  += $$($(libname)_ASFLAGS)
$$(INTERMEDIATE_LIB_OBJS): CPPFLAGS  = $$($(libname)_CPPFLAGS) $$(addprefix -I,$$($(libname)_INCLUDES-y)) $(CPPFLAGS)

$(BUILDDIR)/$(libname).lib: $$(INTERMEDIATE_LIB_OBJS)
	@mkdir -p $$(@D)
	@test -z "$(HIDECMD)" || echo "  LD    $$@"
	$(HIDECMD) $$(LD) -r -o $$@ $$^ $$($(libname)_LDFLAGS)
	$(HIDECMD) if [ -n "$$($(libname)_OBJCOPYFLAGS)" ]; then \
		test -z "$(HIDECMD)" || echo "  OBJCOPY $$@"; \
		$$(OBJCOPY) $$($(libname)_OBJCOPYFLAGS) $$@; \
	fi
	
# add the resulting intermediate lib file to the final objects
OBJS += build/$(libname).lib
	
endef # INTERMEDIATE_LIB_BUILD_EVAL


$(warning INTERMEDIATE_LIB: $(INTERMEDIATE_LIB))
# And now apply this template for every name in the list.
# Uncomment the following line to debug how the template is evaluated
#$(foreach libname,$(INTERMEDIATE_LIBS),$(info $(INTERMEDIATE_LIB_BUILD_EVAL)))
$(foreach libname,$(INTERMEDIATE_LIBS),$(eval $(INTERMEDIATE_LIB_BUILD_EVAL)))




# and now, the final rule to gather objects and intermediate libs of the project
$(OUTPUT): $(OBJS)
	@mkdir -p $(@D)
	@test -z "$(HIDECMD)" || echo "  LD    $@"
	$(HIDECMD) $(CC) $(LDFLAGS) -o $@ $^

