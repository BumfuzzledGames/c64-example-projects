ASM        ?= kickass
ASM_FLAGS  ?= -vicesymbols -debugdump
EMU        ?= x64sc

%.prg: %.asm
	$(ASM) $(ASM_FLAGS) -o $@ $<

# Removes ALL files not tracked by git, BE CAREFUL
clean:
	git clean -f
