cd /D %~dp0
sdas8051 -l -o -s  main.asm 
sdcc -mmcs51   --xram-size 0x2000 --xram-loc 0x10000  --code-size 0x20000 main.rel
packihx main.ihx > main.hex