

# build the object files to build from sources
OBJS = $(addprefix $(BUILDDIR)/,$(notdir $(addsuffix .o,$(basename $(sort $(SOURCES-y))))))

# add INCLUDES directory to CPPFLAGS
CPPFLAGS += $(addprefix -I,$(INCLUDES-y))


# if VERBOSE is not defined, don't display the complete gcc command line, but only 'CC  foo.c'
# run 'VERBOSE=1 make' to build the project with details.
ifeq ($(VERBOSE),)
HIDECMD=@
else
HIDECMD=
endif


# Source headers dependencies to know when it is required to rebuild some objects when headers are modified.
# main.d & co files were created the previous time we run the makefile
include $(wildcard $(addsuffix .d,$(basename $(OBJS))))

# Uncomment following line to debug to build object list
#$(warning OBJS = $(OBJS))

VPATH += $(dir $(SOURCES-y))

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

# generic rules for build and generating dependency list
$(BUILDDIR)/%.o: %.c | $(BUILDDIR)
	@test -z "$(HIDECMD)" || echo "  CC    $<"
	$(HIDECMD) $(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@ -MMD -MP
	
$(BUILDDIR)/%.o: %.cxx | $(BUILDDIR)
	@test -z "$(HIDECMD)" || echo "  CXX   $<"
	$(HIDECMD) $(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@ -MMD -MP
	
$(BUILDDIR)/%.o: %.s | $(BUILDDIR)
	@test -z "$(HIDECMD)" || echo "  AS    $<"
	$(HIDECMD) $(AS) $(ASFLAGS) -c $< -o $@

$(OUTPUT): $(OBJS) | $(BUILDDIR)
	@test -z "$(HIDECMD)" || echo "  LD    $@"
	$(HIDECMD) $(CC) $(LDFLAGS) -o $@ $^



