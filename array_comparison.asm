ORG 0
ACALL COMPARE
SJMP $ ; Halt the program after the comparison

COMPARE:
      MOV R0, #30H ; Address to store matches
      MOV R1, #00 ; Counter for matches
      
      MOV R4, #05 ; Counter for LOOKUP_INPUT (Array 2)
      MOV R2, #00 ; Index for LOOKUP_INPUT
LOOP_OUTER:
      MOV DPTR, #LOOKUP_INPUT
      MOV A, R2
      MOVC A, @A+DPTR ; Get value from LOOKUP_INPUT
      MOV B, A ; Store it in B for comparison
      
      MOV R7, #25 ; Counter for LOOKUP1 (Array 1)
      MOV R3, #00 ; Index for LOOKUP1
LOOP_INNER:
      MOV DPTR, #LOOKUP1
      MOV A, R3
      MOVC A, @A+DPTR ; Get value from LOOKUP1
      
      CJNE A, B, NEXT_ELEMENT
      
      MOV @R0, B ; Store the match
      INC R0
      INC R1 ; Increment match counter
      
NEXT_ELEMENT:
      INC R3
      DJNZ R7, LOOP_INNER
      
      INC R2
      DJNZ R4, LOOP_OUTER

RET

ORG 0100H ;LOOKUPTABLETEMPLATE
LOOKUP1: DB 250,240,230,220,210,200,190,180,170,160,150,140,130,120,110,100,90,80,70,60,50,40,30,20,10

ORG 0500H ;LOOKUPTABLEINPUTS
LOOKUP_INPUT: DB 50,40,5,200,3