*       Print all characters to text screen

        org     $4000

key     equ     $852b
cls     equ     $ba77

begin   ldx     #$0400          ; Text screen start
        ldy     #$0600          ; Text screen end
        lda     #$80            ; -128

loop    sta     ,x+             ; From the start
        sta     ,-y             ; From the end
        inca
        bvc     loop            ; Loop until overflow

end     jsr     key             ; Wait for key press
        jmp     cls             ; Done
