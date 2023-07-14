# The following commented out line would set the name of the executable file to the name of the directory without a call to shell.
#EXE := $(lastword $(subst /, ,$(abspath $(dir $(lastword $(MAKEFILE_LIST))))))
EXE := $(shell basename $(PWD))
OBJS := $(EXE).o
$(info "The executable is "$(EXE)", the objects are "$(OBJS))

CC=mpif77
CFLAGS=-O2 -xAVX

$(EXE):$(OBJS)

clean:
	rm -f $(OBJS) $(EXE)
