;
;
;
.ORIG x3300

; Subroutine

        ; Initialize Registers
        
            ; Attention: DO NOT TOUCH R4, R5, R6 OR R7
            ;
            ; R4 CONTAINS MA for the Key
            ;
            ; R5 CONTAINS MA for the Encryption
            ;
            ; R6 CONTAINS MA for the String
            ;
            ; R7 Contains MA of the Main Routine
            
            AND         R0, R0, #0 ; Character
            AND         R1, R1, #0 ; Check summand
            AND         R2, R2, #0 ; Check and Pointer
            AND         R3, R3, #0


        ; Initialize memory location
            
        
        ; Prompt Input
            LEA         R0, PROMPT 
            PUTS
            
        ; Get Characters
AGAIN       GETC
            
        ; Space Character check
            LD          R1, SPACE
            ADD         R2, R0, R1
            BRz         STORE
        
        ; Uppercase bottom check
            LD          R1, UPPER_BOT     
            ADD         R2, R0, R1
            BRn         OUTPUT
            
        ; Uppercase top check
            LD          R1, UPPER_TOP
            ADD         R2, R0, R1
            BRp         OUTPUT
            
        ; Store Character
            ; R0 contains the Charater
STORE       OUT
            LD          R2, POINTER
            ADD         R1, R6, R2 ; R1, R1, R2
            STR         R0, R1, #0
            ADD         R2, R2, #1
            ST          R2, POINTER
            BRnzp       AGAIN     
            
        ; End of Subroutine
            ; Print Newline
OUTPUT      LD          R0, NEWLINE
            OUT
            
            ; Store a Null character
            AND         R0, R0, #0
            LD          R2, POINTER
            ADD         R1, R6, R2
            STR         R0, R1, #0
            
            ; Clear pointer
            AND         R2, R2, #0
            ST          R2, POINTER
            
            ; Return to Main Routine
            RET ; HALT
            
; Labels
PROMPT      .STRINGZ    "\nInput a string and press ENTER (use only UPPERCASE and SPACE characters): "
NEWLINE     .STRINGZ    "\n"
; STRING      .BLKW       10
SPACE       .FILL       #-32
POINTER     .FILL       #0
UPPER_BOT   .FILL       #-65
UPPER_TOP   .FILL       #-90
LOWER_BOT   .FILL       #-97
LOWER_TOP   .FILL       #-122

; End of File
.END