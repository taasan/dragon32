*       Swap As and Bs in string
*       Position independent code

        org     $4000           ; Place code at address 0x4000

main    jsr     $BA77           ; Clear screen
        ldx     #$0400          ; x = 0x0400 (Beginning of text screen)
        stx     $88             ; Set current text cursor position to x

        leax    W1,pcr          ; Print, swap and print W1
        bsr     Psp

        leax    W2,pcr          ; Print, swap and print W2
        bra     Psp             ; and exit

W1      fcn     /BRAKAR/        ; Null-terminated strings
W2      fcn     /ABBA/
ARROW   fcn     / -> /

;;; Print, swap and print
Psp     bsr     Print           ; Original
        bsr     Parr            ; Print arrow
        bsr     Swap            ; Swap as and bs
        bra     PrintLn         ; Print swapped

;;; Print arrow
Parr    pshs    x
        leax    ARROW,pcr
        bsr     Print
        puls    x
        rts

Swap    pshs    x,a,cc          ; Save registers
loop    lda     ,x              ; a = *x
        beq     done            ; if a == 0 then goto done

        cmpa    #'A             ; Compare a to 'A'
        beq     setB            ; if equals then goto setB

        cmpa    #'B             ; Compare a to 'B'
        beq     setA            ; if equals then goto setA

        ;; else
store   sta     ,x              ; *x = a
        leax    1,x             ; x += 1
        bra     loop            ; goto loop

setA    lda     #'A             ; a = 'A'
        bra     store

setB    lda     #'B             ; a = 'B'
        bra     store

done    puls    x,a,cc          ; Restore registers
        rts

Print   pshs    x
        leax    -1,x            ; x -= 1
        jsr     $90E5           ; print x
        puls    x
        rts

PrintLn bsr     Print
        jmp     $90A1           ; new line
