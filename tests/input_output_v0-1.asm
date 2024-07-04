;
;
;
.ORIG x3100

; Subroutine

        ; Initialize Registers
        
            ; ATTENTION: DO NOT INITIALIZE R3 or R7
            ; R3 contains the MA of the String, R7 contains the address of the main routine
            
            AND         R0, R0, #0
            AND         R1, R1, #0
            AND         R2, R2, #0

        ; Prompt Input
            LEA         R0, PROMPT 
            PUTS
            
        ; Get Characters
AGAIN       GETC
            OUT
            
        ; Uppercase bottom check
            LD          R1, UPPER_BOT     
            ADD         R2, R0, R1
            BRn         OUTPUT
            
        ; Uppercase top check
            LD          R1, UPPER_TOP
            ADD         R2, R0, R1
            BRp         OUTPUT
            
            
        ; Store Character
            LEA         R1, STRING
            LD          R2, POINTER
            ADD         R1, R1, R2
            STR         R0, R1, #0
            ADD         R2, R2, #1
            ST          R2, POINTER
            BRnzp       AGAIN     
            
        ; End input
OUTPUT      LEA         R0, NEWLINE
            PUTS
            LEA         R0, STRING
            PUTS
            
        ; End of Main Routine
            HALT
            
; Labels
NEWLINE     .STRINGZ    "\n"
PROMPT      .STRINGZ    "Input a 10 character string: "
STRING      .BLKW       10
POINTER     .FILL       #0
UPPER_BOT   .FILL       #-65
UPPER_TOP   .FILL       #-90
LOWER_BOT   .FILL       #-97
LOWER_TOP   .FILL       #-122

; End of File
.END