
.phony : all clean test

# set the default target for 'make' called without target
all:


include ../scripts/MakefilePre.mk


# Define the cross-prefix used by the cross toolchain.
# For the example purpose we will build something that 'qemu-arm' can simply run
# so we will not have to deal with a specific hardware board.
CROSS_PREFIX = arm-none-eabi-

CC =  $(CROSS_PREFIX)gcc
CXX = $(CROSS_PREFIX)g++
AS =  $(CROSS_PREFIX)as
LD =  $(CROSS_PREFIX)ld
OBJCOPY = $(CROSS_PREFIX)objcopy


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



# list of sources to build
SOURCES-y += main.cxx
    
# include the various modules of the project
include ../libA/Module.mk
include ../libB/Module.mk
include ../libC++/Module.mk

    
# what is the expected output of the project
OUTPUT = project.elf
    

# now, include the rules to build the project
include ../scripts/MakefilePost.mk



all: $(OUTPUT)

clean:
	rm -f $(OBJS) $(OUTPUT)
	
test: all
	@echo "------------ test --------------"
	$(HIDECMD) qemu-arm $(OUTPUT)

