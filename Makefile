#### PROJECT SETTINGS ####
.DEFAULT_GOAL = release

# The name of the executable to be created
BIN_NAME := md5.o

# Path to the source directory, relative to the makefile
SRC_PATH = .

# General compiler flags
COMPILE_FLAGS = -g -Wnon-virtual-dtor -Winit-self -Wredundant-decls -Wcast-align -Wundef -Wfloat-equal -Wunreachable-code -Wmissing-include-dirs -Wswitch-default -Wmain -pedantic-errors -pedantic -Wzero-as-null-pointer-constant -Wfatal-errors -Wextra -Wall -Werror -Wno-unknown-pragmas -fdiagnostics-show-option -fexpensive-optimizations -O3

# Add additional include paths
INCLUDES = -I $(SRC_PATH)

#### END PROJECT SETTINGS ####

# Generally should not need to edit below this line

# Obtains the OS type, either 'Darwin' (OS X) or 'Linux'
UNAME_S:=$(shell uname -s)

# Function used to check variables. Use on the command line:
# make print-VARNAME
# Useful for debugging and adding features
print-%: ; @echo $*=$($*)

# Shell used in this makefile
# bash is used for 'echo -en'
SHELL = /bin/bash
# Clear built-in rules
.SUFFIXES:

# Combine compiler and linker flags
release: CXXFLAGS := $(CXXFLAGS) $(COMPILE_FLAGS) $(RCOMPILE_FLAGS)
debug: CXXFLAGS := $(CXXFLAGS) $(COMPILE_FLAGS) $(DCOMPILE_FLAGS)

SOURCE = $(SRC_PATH)/md5.cpp

# Standard release build
.PHONY: release
release: $(BIN_NAME)

# Debug build for gdb debugging
.PHONY: debug
debug: $(BIN_NAME)

.PHONY: clean
clean:
	@$(RM) $(BIN_NAME)

$(BIN_NAME): $(SOURCE)
	@echo "Compiling: $< -> $@"
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@
