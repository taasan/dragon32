*       Print all characters to text screen

        org     $4000

txtscr  equ     $0400           ; Text screen
inkey   equ     $8006
cls     equ     $ba77

begin   ldx     #txtscr
        lda     #$80            ; -128

incloop sta     ,x+
        inca
        bvc     incloop         ; Loop until overflow

decloop deca                    ; Then reverse
        sta     ,x+
        cmpa    #$80
        bne     decloop

end     jsr     inkey
        beq     end
        jmp     cls
