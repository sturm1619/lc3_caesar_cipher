;
;  Substract key to a character
;
.ORIG x3600

; Subroutine

        ;   Initialize Registers
            
                ; Attention: DO NOT TOUCH R4, R5, R6 OR R7
                ;
                ; R4 CONTAINS MA for the Key
                ;
                ; R5 CONTAINS MA for the Encryption
                ;
                ; R6 CONTAINS MA for the String
                ;
                ; R7 Contains MA of the Main Routine
                
                AND     R0, R0, #0  ;   Character
                AND     R1, R1, #0  ;   Key and other variables
                AND     R2, R2, #0  ;   String Memory Location
                ; AND     R3, R3, #0
                
            ; Message
                LEA         R0, OUTPUT
                PUTS
        
        ;   Compute Memory Address for String
                ADD         R2, R6, #0
                ADD         R3, R5, #0
                
        ;   Load Char
AGAIN           LDR         R0, R2, #0
                
        ;   Verify Character is not x0000
                ADD         R0, R0, #0
                BRz         DONE
                
        ;   Verify Character is Space
                LD          R1, SPACE
                ADD         R1, R0, R1
                BRz         STORE
        
        ;   Substract Key
                LDR         R1, R4, #0 ;LD          R1, KEY
                ; Invert key
                NOT         R1, R1
                ADD         R1, R1, #1
                ; Addition
                ADD         R0, R0, R1
        
        ;   Verify Key was added correctly
                LD          R1, UPPER_BOT
                ADD         R1, R0, R1
                BRzp        STORE
        
        ;   Correct ASCII
                LD          R0, UPPER_TOP
                ADD         R0, R0, R1

        ;   Store, Output and repeat
STORE           OUT
                STR         R0, R3, #0
                ADD         R2, R2, #1 ; Increase String Pointer
                ADD         R3, R3, #1 ; INcrease Encrypted Pointer
                BRnzp       AGAIN
        
        ;   End of Main Routine
DONE            RET ;HALT

; Labels
;STRING          .STRINGZ    "ABC"
;ENCRYPTED       .BLKW       10
;KEY             .FILL       #3
OUTPUT          .STRINGZ    "\nThe decrypted message: "
NEWLINE         .STRINGZ    "\n"
UPPER_TOP       .FILL       #91
UPPER_BOT       .FILL       #-65
SPACE           .FILL       #-32

; End of file
.END