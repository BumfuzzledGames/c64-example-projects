ASM        ?= kickass
ASM_FLAGS  ?= -vicesymbols -debugdump
EMU        ?= x64sc

%.prg: %.asm
	$(ASM) $(ASM_FLAGS) -o $@ $<
