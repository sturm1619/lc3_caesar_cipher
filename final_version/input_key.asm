;
;   Input Key
;
.ORIG x3400

; Subroutine

            ; Initialize Registe

                ; Attention: DO NOT TOUCH R4, R5, R6 OR R7
                ;
                ; R4 CONTAINS MA for the Key
                ;
                ; R5 CONTAINS MA for the Encryption
                ;
                ; R6 CONTAINS MA for the String
                ;
                ; R7 Contains MA of the Main Routine
                
                AND         R0, R0, #0
                AND         R1, R1, #0
                AND         R2, R2, #0
                AND         R3, R3, #0
                
            ; Prompt
AGAIN           LEA         R0, PROMPT
                PUTS
                
            ; Get first digit
                GETC
                
                ; Check for characters below numeric
                LD          R1, BINARY_BOT
                ADD         R1, R0, R1
                BRn         EXCEPTION
                
                ; Check for characters above numeric
                LD          R1, BINARY_TOP
                ADD         R1, R0, R1
                BRp         EXCEPTION
                
                ; Convert number to
                OUT
                LD          R1, BINARY_BOT
                ADD         R0, R0, R1 ; Store Binary of INT in R0 into R0
                ST          R0, DIG_1 
            
            ; Get second digit
                GETC
                
                ; Check for newline
                LD          R1, NEWLINE
                NOT         R1, R1
                ADD         R1, R1, #1
                ADD         R1, R0, R1
                BRnp        NO_NEWLINE
                AND         R0, R0, #0
                ADD         R0, R0, #-1
                ST          R0, DIG_2
                BRnzp       CONVERSION
                
                ; Check for characters below numeric
NO_NEWLINE      LD          R1, BINARY_BOT
                ADD         R1, R0, R1
                BRn         EXCEPTION
                
                ; Check for characters above numeric
                LD          R1, BINARY_TOP
                ADD         R1, R0, R1
                BRp         EXCEPTION
                
                ; 
                OUT
                LD          R1, BINARY_BOT
                ADD         R0, R0, R1 ; Store Binary of INT in R0 into R0
                ST          R0, DIG_2
            
            ; Add tenths and units (CONVERSION)
                ; Load Digits
CONVERSION      LD          R1, DIG_2
                LD          R0, DIG_1
                
                ; Check if DIG_2 is a number
                ADD         R1, R1, #0
                BRn         CORRECT_KEY
                
                ; If DIG_2 is a number, load multiply DIG_1 by 10
                LEA         R2, LOOKUP ; Load Lookup Table
                ADD         R2, R0, R2 ; Find MA of the tenth
                LDR         R0, R2, #0 ; Load R0 x 10    
                BRnzp       CONTINUE

CORRECT_KEY     ADD         R1, R1, #1
                
                ; Calculate Key
CONTINUE        ADD         R0, R0, R1 ; Add number

                ; Check that Key is within Range
                LD          R2, INT_TOP
                ADD         R1, R0, R2
                BRn         STORE
                ; If key is out of range or not an numeric.
EXCEPTION       LEA         R0, ERROR
                PUTS
                BRnzp       AGAIN
            
            
            ; Store integer
STORE           STR         R0, R4, #0
            
            ; Return
                LEA         R0, NEWLINE
                PUTS
                RET
            
            
; Labels
PROMPT          .STRINGZ    "Input a 1 or 2 digit integer key (integer from 1 to 26): "
ERROR           .STRINGZ    "\nThe key is out of range or is not a valid number. Input another key.\n"
NEWLINE         .STRINGZ    "\n"

DIG_1           .FILL       #0
DIG_2           .FILL       #0

BINARY_BOT      .FILL       #-48
BINARY_TOP      .FILL       #-57

INT_TOP         .FILL       #-26

LOOKUP          .FILL       #0
                .FILL       #10
                .FILL       #20
                .FILL       #30
                .FILL       #40
                .FILL       #50
                .FILL       #60
                .FILL       #70
                .FILL       #80
                .FILL       #90
; End of File
.END