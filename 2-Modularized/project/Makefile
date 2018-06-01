
.phony : all clean test help

# set the default target for 'make' called without target
help:


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
# CFLAGS:   required options for C compilation
# CXXFLAGS: options for C++ compilation
# CPPFLAGS: flags for preprocessor. Applied both for C and C++
# LDFLAGS:  linker flags

# We simply want to run the examples with 'qemu-arm project.elf' 
# instead of building for a particular hardware.
# The easiest is to link with semihosting libc version (ie. rdimon.specs)
LDFLAGS  += --specs=rdimon.specs 
CFLAGS   += -Wall
CXXFLAGS += -Wall -fno-exceptions -fno-rtti  # disable exceptions and RTTI to simplify the linking of C++ code (anyway, does exceptions and RTTI are a good idea in deep embedded code ?)


# turning on DEBUG=1 macro if DEBUG=y is set in make command line
DEBUG?=n  
ifeq ($(DEBUG),y)
CPPFLAGS += -DDEBUG=1
endif

# list of project sources to build
SOURCES-y += main.cxx
    
    

# include the various modules of the project

# by default, configure libA to build assembler part, except if 'make LIBA_BUILD_ASM=n' is used to build
LIBA_BUILD_ASM=y 
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


help:
	@echo "usage:"
	@echo "   make [clean|all|test] [LIBA_BUILD_ASM=(y)/n] [VERBOSE=1] [DEBUG=y/(n)]"
	@echo "      VERBOSE=1 : Display the detail of every CC, LD, etc build operation."
	@echo "                  (default is to display a short line for each build operation)"
	@echo "      LIBA_BUILD_ASM=(y)/n : Does liba is build with assembler implementation (default yes)."
	@echo "      DEBUG=y/(n) : Set DEBUG=1 macro for every C file"
	
	
	