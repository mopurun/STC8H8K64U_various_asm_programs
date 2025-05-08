.area HOME (CODE)
.area XSEG (XDATA)
.area PSEG (PAG,XDATA)
.area RSEG (ABS,DATA)
P1 = 0x90 ;p262
P2 = 0xA0 ;
P3 = 0xB0
P4 = 0xC0
P5 = 0xC8
P6 = 0xE8;p347
P7 = 0xF8;p276
P2M0 = 0x96
P2M1 = 0x95
P4M0 = 0xB4
P4M1 = 0xB3
P5M0 = 0xCA
P5M1 = 0xC9
P6M0 = 0xCC
P6M1 = 0xCB
P7M0 = 0xE2
P7M1 = 0xE1
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
	mov P7 , #0
_start:





	mov A , P6
	cpl A
	rlc A ; rotate left
	cpl A ; NOT A
	mov P6 ,A
	mov A, #255
	push A


wait1_bloop:	
	mov A, #255
wait1_loop:
	nop
	nop
	nop
	nop
	nop
	dec A
	jnz wait1_loop
	pop A
	dec A
	push A	
	jnz wait1_bloop


	ljmp _start