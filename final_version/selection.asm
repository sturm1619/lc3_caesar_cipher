;
;   Select subroutine
;
.ORIG x3200

; Subroutine
            
            ; Initialize Registers
                AND         R0, R0, #0
                AND         R1, R1, #0
            
            ; Prompt
AGAIN           LEA         R0, PROMPT
                PUTS
                GETC
                OUT
                
            ; Check for Exit input
            
                ; Get and Check NEWLINE factor
                LD          R1, NEWLINE
                NOT         R1, R1
                ADD         R1, R1, #1
                ADD         R1, R0, R1
                BRz         CLOSE
                
                ; Check for 0
                AND         R1, R0, xF
                BRz         EXCEPTION
                
                ; Check for 1
                LD          R1, ONE
                ADD         R1, R0, R1
                BRz         MODE
                
                ; Check for 2
                LD          R1, TWO
                ADD         R1, R0, R1
                BRz         MODE
                
                ; Invalid Input Handling
EXCEPTION       LEA         R0, ERROR
                PUTS
                BRnzp       AGAIN
                
            ; Prepare Mode
MODE            LD          R1, ASCII
                ADD         R0, R0, R1
                RET
            
            ; Prepare to close
CLOSE           AND         R0, R0, #0
                ADD         R0, R0, #-1
                RET



; Labels
PROMPT      .STRINGZ        "\nMenu:\n1. Encryption\n2. Decryption\nInput type of encryption. Press Enter to finish program: \n"
NEWLINE     .STRINGZ        "\n"
ONE         .FILL           #-49
TWO         .FILL           #-50
ASCII       .FILL           #-49
ERROR       .STRINGZ        "\nCommand not recognized. Try again."


; End of File
.END