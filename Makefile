.SUFFIXES: .asm .tx .o .gbc

TEXTFILES =	main.tx

all: prism.gbc

prism.o: prism.asm constants.asm wram.asm ${TEXTFILES}
	rgbasm -o prism.o prism.asm
	
.asm.tx:
	python preprocessor.py < $< > $@

prism.gbc: prism.o
	rgblink -o $@ $<
	#rgbfix -Cjv -i BYTE -k 01 -l 0x33 -m 0x10 -p 0 -r 3 -t PM_CRYSTAL $@
	cmp baserom.gbc $@

clean:
	rm -f main.tx prism.o prism.gbc ${TEXTFILES}
