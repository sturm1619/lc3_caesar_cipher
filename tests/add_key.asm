;
;  Add key to a character
;
.ORIG x3200

; Main Routine

        ;   Initialize Registers
                AND     R0, R0, #0  ;   Character
                AND     R1, R1, #0  ;   Key and other variables
                AND     R2, R2, #0  ;   String Memory Location
                AND     R3, R3, #0
        
        ;   Compute Memory Address for String
                LEA     R2, STRING
                
        ;   Load Char
AGAIN           LDR     R0, R2, #0
                
        ;   Verify Character is not x0000
                ADD     R0, R0, #0
                BRz     DONE
        
        ;   Add Key
                LD      R1, KEY
                ADD     R0, R0, R1
        
        ;   Verify Key was added correctly
                LD      R1, UPPER_TOP
                ADD     R1, R0, R1
                BRnz    STORE
        
        ;   Correct ASCII
                LD      R0, UPPER_BOT
                ADD     R0, R0, R1

        ;   Store, Output and repeat
STORE           OUT
                STR     R0, R2, #0
                ADD     R2, R2, #1
                BRnzp   AGAIN
        
        ;   End of Main Routine
DONE            HALT

; Labels
STRING          .STRINGZ    "ABC"
ENCRYPTED       .BLKW       10
KEY             .FILL       #1
UPPER_TOP       .FILL       #-90
UPPER_BOT       .FILL       #65

; End of file
.END