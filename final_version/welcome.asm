;
;   Welcome message
;
.ORIG x3100

; Subroutine
            
            ; Load Welcome Message
                LEA         R0, SQUARE
                PUTS
                LEA         R0, MESSAGE
                PUTS
                LEA         R0, AUTHORS,
                PUTS
                LEA         R0, SQUARE
                PUTS
                
            ; End of Subroutine
                RET;HALT;
            
; Labels
SQUARE          .STRINGZ    "|============================|\n"
MESSAGE         .STRINGZ    "| ENCRYPTING MACHINE         |\n"
AUTHORS         .STRINGZ    "| By C.Rubio and  S. Gregory |\n"

; End of File
.END