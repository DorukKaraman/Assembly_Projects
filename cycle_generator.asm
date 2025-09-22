ORG 0
ACALL CONFIGURE_LCD
KEYBOARD_LOOP:
    ACALL KEYBOARD
    MOV R0, A  ; Get the first digit (tens)
    ACALL SEND_DATA
    ACALL KEYBOARD
    MOV R1, A  ; Get the second digit (ones)
    ACALL SEND_DATA

; Convert ASCII to HEX and calculate duty cycle percentage
ASCIITOHEX:
    MOV B, #30H
    SUBB A, B
    MOV R0, A  ; R0 has the tens digit in hex
    MOV A, R1
    SUBB A, B
    MOV R1, A  ; R1 has the ones digit in hex

    MOV A, R0
    MOV B, #10
    MUL AB
    ADD A, R1
    MOV R2, A ; R2 now holds the duty cycle percentage (0-100)

; Display the duty cycle
LCD_DISPLAY:
    ACALL CONFIGURE_LCD
    MOV A, #'D'
    ACALL SEND_DATA
    MOV A, #'='
    ACALL SEND_DATA
    MOV A,R0
    ACALL SEND_DATA
    MOV A,R1
    ACALL SEND_DATA
    MOV A, #'%`
    ACALL SEND_DATA
    
; Generate PWM signal
PWM_GEN:
    MOV B, R2      ; B = duty cycle percentage
    MOV A, #100    ; A = total period (100)
    SUBB A, B
    MOV R4, A      ; R4 = low portion of the period
    MOV R3, B      ; R3 = high portion of the period

    ; A simple loop to generate PWM signal with a fixed delay
    LOOP_PWM:
        SETB P2.5  ; High portion of the signal
        MOV R5, R3
        L_HIGH:
            ACALL D1_25
            DJNZ R5, L_HIGH

        CLR P2.5   ; Low portion of the signal
        MOV R5, R4
        L_LOW:
            ACALL D1_25
            DJNZ R5, L_LOW
    SJMP LOOP_PWM

; Delay subroutines
D1_25:
    MOV R5, #12 ; A simple delay loop
    HERE:
    DJNZ R5, HERE
    RET
D2_50: ; This function is not used in the new logic but is kept for reference
    MOV R5, #22
    HEREE:
    DJNZ R5, HEREE
    RET

; Standard LCD and Keyboard subroutines
CONFIGURE_LCD:
	mov a,#38H
	acall SEND_COMMAND
	mov a,#0FH
	acall SEND_COMMAND
	mov a,#06H
	acall SEND_COMMAND
	mov a,#01H
	acall SEND_COMMAND
	mov a,#80H
	acall SEND_COMMAND
	ret
SEND_COMMAND:
	mov p1,a
	clr p3.5
	clr p3.6
	setb p3.7
	acall DELAY
	clr p3.7
	ret
SEND_DATA:
	mov p1,a
	setb p3.5
	clr p3.6
	setb p3.7
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
	mov	P0, #0ffh
K1:
	mov	P2, #0
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, K1
K2:
	acall	DELAY
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, KB_OVER
	sjmp	K2
KB_OVER:
	acall DELAY
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, KB_OVER1
	sjmp	K2
KB_OVER1:
	mov	P2, #11111110B
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, ROW_0
	mov	P2, #11111101B
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, ROW_1
	mov	P2, #11111011B
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, ROW_2
	mov	P2, #11110111B
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, ROW_3
	ljmp	K2
ROW_0:
	mov	DPTR, #KCODE0
	sjmp	KB_FIND
ROW_1:
	mov	DPTR, #KCODE1
	sjmp	KB_FIND
ROW_2:
	mov	DPTR, #KCODE2
	sjmp	KB_FIND
ROW_3:
	mov	DPTR, #KCODE3
KB_FIND:
	rrc	A
	jnc	KB_MATCH
	inc	DPTR
	sjmp	KB_FIND
KB_MATCH:
	clr	A
	movc	A, @A+DPTR
	ret
KCODE0:	DB	'1', '2', '3', 'A'
KCODE1:	DB	'4', '5', '6', 'B'
KCODE2:	DB	'7', '8', '9', 'C'
KCODE3:	DB	'*', '0', '#', 'D'
END