ORG 8100H
MOV DPTR, #9000H
MOV R2, #5H
MOV R0, #5H
	GENERATOR:  
            MOV A,R0
            MOVX @DPTR, A
            INC DPTR
            DJNZ R0, GENERATOR

MOV DPTR, #9000H
OUTER_LOOP:
MOV R3, #4H


INNER_LOOP:
MOVX A,@DPTR
MOV R5,A
MOV B,R5
INC DPTR
MOVX A,@DPTR
CJNE A,B,SWP;
swp:
JNC NO_SWAP

MOV R6,A
MOV A,B
MOVX @DPTR,A
DEC DPL
MOV A,R6
MOVX @DPTR,A
INC DPTR

NO_SWAP:
DJNZ R3,INNER_LOOP
MOV DPTR, #9000H
DJNZ R2, OUTER_LOOP


MOV R4,#2H
MOV R3,#5H
MOV R0,#0H

MOV DPTR,#9550H
MOV A,-1
MOVX @DPTR,A

BINARY_SEARCH:
MOV DPTR,#9000H
MOV A,R0
ADD A,R3
MOV B,#02H;
DIV AB
MOV R5, A;
MOV B, #00H       ; Clear register B (used for carry if needed)
ADD A, DPL        ; Add the value in DPL (lower byte of DPTR) to A (A = A + DPL)
MOV DPL, A        ; Store the result (lower byte) back into DPL

MOV A, B          ; Move carry (if any) from B into A
ADD A, DPH        ; Add the value in DPH (upper byte of DPTR) to A (A = A + DPH + carry)
MOV DPH, A        ; Store the result (upper byte) back into DPH



MOVX A,@DPTR
MOV B,R4
CJNE A,B,operate

JMP EQUAL


operate:
JNC MIDPOINT_GREATER
JC MIDPOINT_LESS

MIDPOINT_GREATER:
MOV A,R5;
MOV R3,A
MOV A,R3
MOV B,R0
CJNE A,B, BINARY_SEARCH

MIDPOINT_LESS:
MOV A,R5
MOV R0,A
MOV A,R0
MOV B,R3
CJNE A,B, BINARY_SEARCH

EQUAL:
MOV DPTR, #9550H
MOV A,R5;
MOVX @DPTR, A;


END
