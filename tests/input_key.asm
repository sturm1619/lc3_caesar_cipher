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
                
            ; Load BINARY factor
                LD          R3, BINARY
                
            ; Prompt
AGAIN           LEA         R0, PROMPT
                PUTS
                
            ; Get tenths
                GETC
                OUT
                ADD         R1, R0, R3
                LEA         R0, LOOKUP
                ADD         R2, R0, R1
                LDR         R1, R2, #0
                
            
            ; Get units
                GETC
                OUT
                ADD         R0, R0, R3 
            
            
            ; Add tenths and units
                ADD         R0, R0, R1
                LD          R2, TOP
                ADD         R1, R0, R2
                BRn         STORE
                LEA         R0, ERROR
                PUTS
                BRnzp       AGAIN
            
            
            ; Store integer
STORE           ST         R0, KEY;R4
            
            ; Return
                HALT ;RET
            
            
; Labels
KEY             .BLKW       1
PROMPT          .STRINGZ    "\nInput key (integer from 1 to 26): "
ERROR           .STRINGZ    "\nThe key is out of range"
BINARY          .FILL       #-48
TOP             .FILL       #-26
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