;    (1) Initializes the interrupt vector table with the starting
;        address of the interrupt service routine. The keyboard
;        interrupt vector is x80. The keyboard interrupt service routine
;        begins at x1000. 
;    (2) Sets bit 14 of the KBSR to enable interrupts.
;    (3) Pushes a PSR and PC to the system stack so that it can jump
;        to the user program at x3000 using an RTI instruction.

        .ORIG x0800
     AND R0 R0 #0

AND R1 R1 #0

AND R2 R2 #0

AND R3 R3 #0

AND R4 R4 #0

AND R5 R5 #0

AND R7 R7 #0
        LD R2 VEC
        LD R3 ISR
        STR R2 R3 #0
        ; (2) Set bit 14 of KBSR.
        LD R4 KBSR
        LD R5 MASK
        LDI R2 KBSR
        NOT R7 R2
        NOT R3 R5
        AND R1 R3 R7
        NOT R1 R1
        STR R1 R4 #0

        ; (3) Set up the system stack to enter user space.
        LD R0, PSR
        ADD R6, R6, #-1
        STR R0, R6, #0
        LD R0, PC
        ADD R6, R6, #-1
        STR R0, R6, #0
        ; Enter user space.
        RTI
        
; Fill out these values to init the machine properly
VEC     .FILL x1000
ISR     .FILL x0180
KBSR    .FILL xFE00
MASK    .FILL x4000
PSR     .FILL x8002
PC      .FILL x3000
        .END

        .ORIG x3000
AND R0 R0 #0

AND R1 R1 #0

AND R2 R2 #0

AND R3 R3 #0

AND R4 R4 #0

AND R5 R5 #0


AND R7 R7 #0

RESTART LEA R0 BANNER

;LD R3 ASCII

;NOT R3 R3 

;ADD R3 R3 #1


;JUMP LDR R0 R2 #0

;ADD R4 R3 R0

;Brnp PUT

;Brz STOP
 PUTS
STOP    ST  R1, SaveR1
        LD  R1, COUNT
REP     ADD R1, R1, #-1
        BRnp REP
        LD  R1, SaveR1
        Brnzp RESTART
COUNT   .FILL x7FFF 
SaveR1  .BLKW #1


;PUT OUT

;ADD R2 R2 #1

;Brnzp JUMP
BANNER .STRINGZ "====================\n*    *  *******\n*    *     *\n*    *     *\n*    *     *\n ****      *\n                \n****   ****  ****\n*     *      *\n****  *      ****\n*     *      *\n****   ****  ****\n====================\n"
ASCII .STRINGZ "\0"

        .END

        .ORIG x1000
         ST R7 MEMR7
         LDI R2 KBDR
         ST R2 INPUT
         LDI R4 NEWLINE
         NOT R4 R4
         ADD R4 R4 #1
         LEA R3 NEWSTRING
         NEXTLETTER LDR R5 R3 #0
         Brz INVALID
         NOT R5 R5
         ADD R5 R5 #1
         ADD R4 R2 R5
         Brnp CHECKNEXT
         Brz VALID
         CHECKNEXT ADD R3 R3 #1
         ADD R7 R7 #1
         Brnzp NEXTLETTER
         
         INVALID LD R3 INVALIDCOUNTER
         LD R2 INPUT
         LEA R4 INVALIDSTRING
         STR R2 R4 #1
         PRINT LDR R0 R4 #0
         Brz DONE
         OUT
         ADD R4 R4 #1
         ADD R3 R3 #-1
         Brnp PRINT
         Brz DONE
         
         
         
         
         
         VALID LD R0 NEWLINE
         OUT
         ADD R7 R7 #1
         LEA R3 NEWSTRING
         LDAGAIN LDR R0 R3 #0
         ADD R7 R7 #-1
         OUT
         Brz DONE
         ADD R3 R3 #1
         Brnzp LDAGAIN
         
         DONE LEA R3 NEWLINE
         LDR R0 R3 #0
         OUT
         LD R7 MEMR7
         RTI
         

        MEMR7 .BLKW #1
        NEWSTRING .STRINGZ "123456789"
        NEWLINE   .STRINGZ "\n"
        INVALIDSTRING .STRINGZ "\n# is not a decimal digit."
        KBDR .FILL xfe02
        INVALIDCOUNTER      .FILL x1A
        INPUT .BLKW #1
        NEWLINE2 .BLKW #1
        SAVEANDRESTORE  .BLKW #10
        .END
