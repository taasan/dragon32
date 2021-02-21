SHELL := bash


ifeq ($(USE_LWASM),yes)
  # http://www.lwtools.ca/
  ASM := lwasm --raw -9
  LISTING := lwasm --no-output --list-nofiles
else
  # https://www.6809.org.uk/asm6809/
  ASM := asm6809 -v
  LISTING := asm6809
endif

# https://www.6809.org.uk/dragon/
BIN2CAS ?= bin2cas.pl

SOURCES := $(wildcard *.asm)

BINS      := $(patsubst %.asm,%.bin,$(SOURCES))
LISTINGS  := $(patsubst %.asm,%.lst,$(SOURCES))
CASSETTES := $(patsubst %.asm,%.cas,$(SOURCES))

TARGETS = $(BINS) $(LISTINGS) $(CASSETTES)

.PHONY: all
all: $(TARGETS)

%.bin: %.asm
	$(ASM) -o $@ $<

%.lst: %.asm
	$(LISTING) -l$@ $<

# load code to highest possible ram address
# Redirect from stdin to prevent wc from printing file name
.ONESHELL:
%.cas: %.bin
	location=$(shell expr 32768 - $(shell wc -c <$<))
	$(BIN2CAS) --load $$location --exec $$location -o $@ $<

.PHONY: clean
clean:
	$(RM) $(TARGETS)
