ORG 0H
LJMP MAHMAIN

MAHMAIN:
    ACALL CONFIGURE_LCD
    MOV P2, #0
    MOV R7, #100 ;TO TURN THE LOOP 100 TIMES SO THAT 100*10000 = 1*10^6
    MOV TMOD, #01H ; Timer 0, Mode 1 (16-bit)
    MOV IE, #10000010B ; Enable all interrupts (EA) and Timer 0 interrupt (ET0)
BACKTO505:
    MOV TL0, #0EFH ; FFFF-10000 LOW PART
    MOV TH0, #0D8H ; FFFF-10000 HIGH PART
    SETB TR0 ; Start Timer 0
    ; The main program can now do other tasks while the timer counts
    ; Wait for the count to complete
    DJNZ R7, $
    
    CLR TR0 ; Stop Timer 0
    
    MOV A, R3
    MOV B, #100D
    DIV AB
    MOV R4, A ; TO CHECK WHETER IT IS 0 OR NOT
    ADD A,#48
    ACALL SEND_DATA
    
    MOV A,B
    MOV B, #10D
    DIV AB
    ADD A,#48
    ACALL SEND_DATA
    MOV A,B
    ADD A,#48
    ACALL SEND_DATA
    
    MOV R3,#48
    MOV A, R4
    JZ  NO_LED
    SETB P2.5 ; Set the LED if R4 is not zero
    
NO_LED:
    SJMP $
INTT:
    INC R3
    RETI
CONFIGURE_LCD:
    mov a,#38H ;TWO LINES, 5X7 MATRIX
    acall SEND_COMMAND
    mov a,#0FH ;DISPLAY ON, CURSOR BLINKING
    acall SEND_COMMAND
    mov a,#06H ;INCREMENT CURSOR (SHIFT CURSOR TO RIGHT)
    acall SEND_COMMAND
    mov a,#01H ;CLEAR DISPLAY SCREEN
    acall SEND_COMMAND
    mov a,#80H ;FORCE CURSOR TO BEGINNING OF THE FIRST LINE
    acall SEND_COMMAND
    ret
SEND_COMMAND:
    mov p1,a ;THE COMMAND IS STORED IN A, SEND IT TO LCD
    clr p3.5 ;RS=0 BEFORE SENDING COMMAND
    clr p3.6 ;R/W=0 TO WRITE
    setb p3.7 ;SEND A HIGH TO LOW SIGNAL TO ENABLE PIN
    acall DELAY
    clr p3.7
    ret
SEND_DATA:
    mov p1,a ;SEND THE DATA STORED IN A TO LCD
    setb p3.5 ;RS=1 BEFORE SENDING DATA
    clr p3.6 ;R/W=0 TO WRITE
    setb p3.7 ;SEND A HIGH TO LOW SIGNAL TO ENABLE PIN
    acall DELAY
    clr p3.7
    ret
DELAY:
    push 0
    push 1
    mov r0,#50
DELAY_OUTER_LOOP:
    mov r1,#255
    djnz r1,$
    djnz r0,DELAY_OUTER_LOOP
    pop 1
    pop 0
    ret
KEYBOARD:
    mov P0, #0ffh ;makes P0 input
K1:
    mov P2, #0 ;ground all rows
    mov A, P0
    anl A, #00001111B
    cjne A, #00001111B, K1
K2:
    acall DELAY
    mov A, P0
    anl A, #00001111B
    cjne A, #00001111B, KB_OVER
    sjmp K2
KB_OVER:
    acall DELAY
    mov A, P0
    anl A, #00001111B
    cjne A, #00001111B, KB_OVER1
    sjmp K2
KB_OVER1:
    mov P2, #11111110B
    mov A, P0
    anl A, #00001111B
    cjne A, #00001111B, ROW_0
    mov P2, #11111101B
    mov A, P0
    anl A, #00001111B
    cjne A, #00001111B, ROW_1
    mov P2, #11111011B
    mov A, P0
    anl A, #00001111B
    cjne A, #00001111B, ROW_2
    mov P2, #11110111B
    mov A, P0
    anl A, #00001111B
    cjne A, #00001111B, ROW_3
    ljmp K2
ROW_0:
    mov DPTR, #KCODE0
    sjmp KB_FIND
ROW_1:
    mov DPTR, #KCODE1
    sjmp KB_FIND
ROW_2:
    mov DPTR, #KCODE2
    sjmp KB_FIND
ROW_3:
    mov DPTR, #KCODE3
KB_FIND:
    rrc A
    jnc KB_MATCH
    inc DPTR
    sjmp KB_FIND
KB_MATCH:
    clr A
    movc A, @A+DPTR;
    ret
;ASCII look-up table
KCODE0:
    DB '1', '2', '3', 'A'
KCODE1:
    DB '4', '5', '6', 'B'
KCODE2:
    DB '7', '8', '9', 'C'
KCODE3:
    DB '*', '0', '#', 'D'
END