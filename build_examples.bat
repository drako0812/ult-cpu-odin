@echo off

tools\customasm\customasm.exe examples\ex0001.asm -f binary -o examples\ex0001.bin -- -f annotated -o examples\ex0001-annotated.txt -- -f symbols -o examples\ex0001-symbols.txt
tools\customasm\customasm.exe examples\ex-lcg.asm -f binary -o examples\ex-lcg.bin -- -f annotated -o examples\ex-lcg-annotated.txt -- -f symbols -o examples\ex-lcg-symbols.txt
tools\customasm\customasm.exe examples\ex-dbg-out.asm -f binary -o examples\ex-dbg-out.bin -- -f annotated -o examples\ex-dbg-out-annotated.txt -- -f symbols -o examples\ex-dbg-out-symbols.txt
