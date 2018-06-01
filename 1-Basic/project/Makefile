
.phony : all clean test

# set the default target for 'make' called without target
all:



# Define the cross-prefix used by the cross toolchain.
# For the example purpose we will build something that 'qemu-arm' can simply run
# so we will not have to deal with a specific hardware board.
CROSS_PREFIX = arm-none-eabi-


CC =  $(CROSS_PREFIX)gcc
CXX = $(CROSS_PREFIX)g++
AS =  $(CROSS_PREFIX)as
LD =  $(CROSS_PREFIX)ld
OBJCOPY = $(CROSS_PREFIX)objcopy



# list of sources to build
SOURCES = \
	../libA/liba.c \
	../libA/liba_asm.s \
	\
	../libB/libb.c \
	\
	../libC++/libc.cxx \
	\
	main.cxx
    

# list of directories where to find C headers
INCLUDES = \
	../libA \
	../libB \
	../libC++
    

    
OUTPUT = project.elf
    

# Define the various flags required for build and link
# CFLAGS: required options for C compilation
# CXXFLAGS: options for C++ compilation
# CPPFLAGS: flags for preprocessor. Applied both for C and C++
# LDFLAGS


# We simply want to run the examples with 'qemu-arm project.elf' 
# instead of building for a particular hardware.
# The easiest is to link with semihosting libc version (ie. rdimon.specs)
LDFLAGS = --specs=rdimon.specs 
CFLAGS   = -Wall
CXXFLAGS = -Wall -fno-exceptions -fno-rtti  # disable exceptions and RTTI to simplify the linking of C++ code (anyway, does exceptions and RTTI are a good idea in deep embedded code ?)
CPPFLAGS = 
ASFLAGS  =

# add INCLUDES directory to CPPFLAGS
CPPFLAGS += $(addprefix -I,$(INCLUDES))


# build the object files to build from sources
OBJS = $(addsuffix .o,$(basename $(sort $(SOURCES))))



# if VERBOSE is not defined, don't display the complete gcc command line, but only 'CC  foo.c'
ifeq ($(VERBOSE),)
HIDECMD=@
else
HIDECMD=
endif


# Source headers dependencies to know when it is required to rebuild some objects when headers are modified.
# main.d & co files were created the previous time we run the makefile
include $(wildcard $(addsuffix .d,$(basename $(OBJS))))

$(warning OBJS = $(OBJS))

# generic rules for build and generating dependency list
%.o: %.c
	@test -z "$(HIDECMD)" || echo "  CC    $<"
	$(HIDECMD) $(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@ -MMD -MP
	
%.o: %.cxx
	@test -z "$(HIDECMD)" || echo "  CXX   $<"
	$(HIDECMD) $(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@ -MMD -MP
	
%.o: %.s
	@test -z "$(HIDECMD)" || echo "  AS    $<"
	$(HIDECMD) $(AS) $(ASFLAGS) -c $< -o $@

$(OUTPUT): $(OBJS)
	@test -z "$(HIDECMD)" || echo "  LD    $@"
	$(HIDECMD) $(CC) $(LDFLAGS) -o $@ $^






all: $(OUTPUT)

clean:
	rm -f $(OBJS) $(OUTPUT)
	
test: all
	@echo "------------ test --------------"
	$(HIDECMD) qemu-arm $(OUTPUT)

