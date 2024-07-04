;
;   Caesar's Cipher Machine
;
.ORIG x3000

; Main Routine

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
                
                AND         R0, R0, #0  ;   Consacrated to the inputs
                AND         R1, R1, #0  ;   Consacrated 
                AND         R2, R2, #0
                AND         R3, R3, #0
                AND         R4, R4, #0
                AND         R5, R5, #0
                AND         R6, R6, #0
                AND         R7, R7, #0
                
        ; Load String Address
                LEA         R4, KEY
                LD          R5, ENCRYPTED
                LD          R6, STRING

        ; Welcome Message
                LD          R0, WELCOME
                JSRR        R0

                
        ; Select Mode
AGAIN           LD          R0, SELECTION
                JSRR        R0
                BRn         CLOSE
                BRz         POS 
                BRp         NEG
   
        ; Encryption Mode             
POS        
        ; Get Input
                LD          R0, INPUT_STRING
                JSRR        R0     
        
        ; Get Encryption Key
                LD          R0, INPUT_KEY
                JSRR        R0
        
        ; Encrypt and output
                LD          R0, ENCRYPT
                JSRR        R0
        
        
        ;  Loop back
                LEA         R0, NEWLINE
                PUTS
                BRnzp       AGAIN
        
        ; Decryption Mode
NEG         
        ; Get Input
                LD          R0, INPUT_STRING
                JSRR        R0     
        
        ; Get Encryption Key
                LD          R0, INPUT_KEY
                JSRR        R0
        
        ; Encrypt and output
                LD          R0, DECRYPT
                JSRR        R0
                
        ; Loop back
                LEA         R0, NEWLINE
                PUTS
                BRnzp       AGAIN

        ; End of the Main Routine
CLOSE           LEA         R0, CLOSING
                PUTS
                HALT
        
; Subroutines
WELCOME         .FILL       x3100
SELECTION       .FILL       x3200
INPUT_STRING    .FILL       x3300
INPUT_KEY       .FILL       x3400
ENCRYPT         .FILL       x3500
DECRYPT         .FILL       x3600
            
; Labels
KEY             .BLKW 1
STRING          .FILL       x3700; .BLKW 10
ENCRYPTED       .FILL       x3800; .BLKW 10
CLOSING         .STRINGZ    "\nClosing CAESAR'S CIPHER MACHINE.\nHave a great day!"
NEWLINE         .STRINGZ    "\n"

; End of File
.END