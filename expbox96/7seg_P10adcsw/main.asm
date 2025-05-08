.include "STC8H8K64U.inc"

P1IE = 0xFE31
.area HOME (CODE)
.area XSEG (XDATA)
.area PSEG (PAG,XDATA)
.area RSEG (ABS,DATA)

.area CSEG (ABS,CODE)
	xrl P4M0, #1 ; xor
	clr P4M1 ; xor	
	xrl P6M0, #255 ; xor
	clr P6M1; 
	clr P4
	mov P6 , #254

	xrl P5M0, #0x10 ; xor
	clr P5M1 ; xor



	xrl P7M0, #255 ; xor
	clr P7M1; 
	mov P7 , #255
_start:

;P10
	mov DPTR, #P1IE
	movx A, @DPTR
	anl A, #0x1
	movx @DPTR, A
	clr P1M0 
	orl P1M1 ,#1
	
	mov A ,#0xC0
	mov ADC_CONTR, A
adc1:	
	mov A,ADC_CONTR
	anl A,#0x40
	jnz adc1
	mov A , ADC_RES
	lcall sevenseg8bit



	ljmp _start



;for 7segment led

delay:
	mov	R5, #0xFF
loop1:
    mov	R6, #0x1       
loop2:
    mov	R7, #0x1   
loop3:
    djnz  R7, loop3   
    djnz  R6, loop2    
    djnz  R5 , loop1
	ret




sevenseg8bit:
	mov B , #10
	div AB
	mov R1 , B
	mov B , #10	
	div AB
	mov R2 ,B
	mov B , #10	
	div AB
	mov R3,B

	mov P7 , #~(1<<0)	;lower
	mov A , R1
	lcall sevenseg
	lcall delay

	mov P7 , #~(1<<1)
	mov A , R2
	lcall sevenseg
	lcall delay

	mov P7 , #~(1<<2)
	mov A , R3
	lcall sevenseg
	lcall delay


	ret




sevenseg:
	jz segnum0
	dec A
	jz segnum1
	dec A
	jz segnum2
	dec A
	jz segnum3
	dec A
	jz segnum4
	dec A
	jz segnum5
	dec A
	jz segnum6
	dec A
	jz segnum7
	dec A
	jz segnum8
	dec A	
	jz segnum9
	ret			
	;dot-A-G
segnum0:
	;0
	mov P6 ,#0b11000000
	ret
segnum1:
	;1
	mov P6 ,#0b11111001
	ret
segnum2:
	;2
	mov P6 ,#0b10100100
	ret
segnum3:
	;3
	mov P6 ,#0b10110000
	ret
segnum4:
	;4
	mov P6 ,#0b10011001
	ret
segnum5:
	;5
	mov P6 ,#0b10010010
	ret
segnum6:
	;6
	mov P6 ,#0b10000010
	ret
segnum7:
	;7
	mov P6 ,#0b11111000
	ret
segnum8:
	;8
	mov P6 ,#0b10000000
	ret
segnum9:
	;9
	mov P6 ,#0b10010000
	ret
	;.
	mov P6 ,#0b01111111

	ret
